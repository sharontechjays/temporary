import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/blocs/products/products_bloc.dart';
import '../../../utils/endlessscroller/endless_recycler_impl.dart';
import '../../blocs/products/products_event.dart';
import '../../blocs/products/products_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with WidgetsBindingObserver {
  late ScrollController _scrollController;
  late NotificationsBloc _productsBloc;
  late EndlessScrollListenerImpl _endlessScrollListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  _init() {
    _scrollController = ScrollController();
    _endlessScrollListener = EndlessScrollListenerImpl(_scrollController);
    _productsBloc = NotificationsBloc();
    _scrollController.addListener(_onScroll);
    _productsBloc
        .add(FetchNotifications(_productsBloc.offset, _productsBloc.limit));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _productsBloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onRefresh();
    }
  }

  void _onScroll() {
    _endlessScrollListener.onScrolled();
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_productsBloc.isNextLink) {
        _productsBloc.offset = _productsBloc.offset + _productsBloc.limit;
        _productsBloc
            .add(FetchNotifications(_productsBloc.offset, _productsBloc.limit));
      }
    }
  }

  Future<void> _onRefresh() async {
    _productsBloc.offset = 0;
    _productsBloc.products.clear();
    _productsBloc.isNextLink = true;
    _productsBloc
        .add(FetchNotifications(_productsBloc.offset, _productsBloc.limit));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsBloc>(
      create: (context) => _productsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<NotificationsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductsLoaded) {
                return _buildNotificationsList(state);
              } else if (state is ProductsError) {
                return Center(child: Text(state.message));
              } else if (state is ProductsEmpty) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(ProductsLoaded state) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: state.products.length + (_productsBloc.isNextLink ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < state.products.length) {
          final notification = state.products[index];
          return ExpansionTile(
            title: Text(notification.title),
            subtitle: Text(notification.brand),
            children: [
              notification.images.isNotEmpty
                  ? Image.network(notification.images.first)
                  : const SizedBox(),
              Text("Category: ${notification.category}"),
              Text("Description: ${notification.description}"),
              Text("Discount: ${notification.discountPercentage}"),
              Text("Rating: ${notification.rating}"),
              Text("Price: ${notification.price}"),
            ],
          );
        } else if (_productsBloc.isNextLink) {
          return const Center(child: CircularProgressIndicator());
        } else if (_productsBloc.offset == 0 && state.products.isEmpty) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
