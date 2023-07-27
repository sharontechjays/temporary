import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/endlessscroller/endless_recycler_impl.dart';
import '../../blocs/notifications/notification_bloc.dart';
import '../../blocs/notifications/notification_event.dart';
import '../../blocs/notifications/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with WidgetsBindingObserver {
  late ScrollController _scrollController;
  late NotificationsBloc _notificationsBloc;
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
    _notificationsBloc = NotificationsBloc();
    _scrollController.addListener(_onScroll);
    _notificationsBloc.add(FetchNotifications(
        _notificationsBloc.offset, _notificationsBloc.limit));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _notificationsBloc.close();
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
      if (_notificationsBloc.isNextLink) {
        _notificationsBloc.offset =
            _notificationsBloc.offset + _notificationsBloc.limit;
        _notificationsBloc.add(FetchNotifications(
            _notificationsBloc.offset, _notificationsBloc.limit));
      }
    }
  }

  Future<void> _onRefresh() async {
    _notificationsBloc.offset = 0;
    _notificationsBloc.notifications.clear();
    _notificationsBloc.isNextLink = true;
    _notificationsBloc.add(FetchNotifications(
        _notificationsBloc.offset, _notificationsBloc.limit));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsBloc>(
      create: (context) => _notificationsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificationsLoaded) {
                return _buildNotificationsList(state);
              } else if (state is NotificationsError) {
                return Center(child: Text(state.message));
              } else if (state is NotificationEmpty) {
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

  Widget _buildNotificationsList(NotificationsLoaded state) {
    return ListView.separated(
      controller: _scrollController,
      itemCount:
      state.notifications.length + (_notificationsBloc.isNextLink ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < state.notifications.length) {
          final notification = state.notifications[index];
          return ListTile(
            title: Text("$notification >> $index"),
          );
        } else if (_notificationsBloc.isNextLink) {
          return const Center(child: CircularProgressIndicator());
        } else if (_notificationsBloc.offset == 0 &&
            state.notifications.isEmpty) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

}

