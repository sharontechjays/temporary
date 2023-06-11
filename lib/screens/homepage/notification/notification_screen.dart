import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/screens/homepage/notification/widgets/notfication_item.dart';
import '../../../blocs/notifications/notfication_bloc.dart';
import '../../../blocs/notifications/notfication_event.dart';
import '../../../blocs/notifications/notification_state.dart';
import 'package:test_flutter/models/notifications.dart' as MyNotifications;

/*
*/ /*class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(
        context: context,
        offset: 0,
        limit: 2,
        mData: [], // <-- Pass an empty list here
      )..add(LoadNotificationEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NotificationInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoadedState) {
              final mData = state.notifications;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NotificationBloc>().add(LoadNotificationEvent());
                },
                child: mData.isEmpty
                    ? Center(child: Text('No notifications available.'))
                    : NotificationListView(
                  notifications: mData,
                  loadNextPage: () {
                    context.read<NotificationBloc>().add(LoadMoreNotificationEvent());
                  },
                  isNextPageAvailable: state.nextLink,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}*/ /*


class NotificationListView extends StatefulWidget {
  final List<MyNotifications.Data> notifications;
  final VoidCallback loadNextPage;
  final bool isNextPageAvailable;

  const NotificationListView({
    Key? key,
    required this.notifications,
    required this.loadNextPage,
    required this.isNextPageAvailable,
  }) : super(key: key);

  @override
  _NotificationListViewState createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingNextPage = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_isLoadingNextPage && widget.isNextPageAvailable) {
      _isLoadingNextPage = true;
      widget.loadNextPage();
    }

    // Reset the flag after loading the next page
    _isLoadingNextPage = false;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.notifications.length + (widget.isNextPageAvailable ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.notifications.length) {
          final notification = widget.notifications[index];
          return NotificationItem(notification: notification);
        } else if (index == widget.notifications.length && widget.isNextPageAvailable) {
          // Show a loading indicator at the end of the list
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(); // Empty container for the extra item
        }
      },
      controller: _scrollController,
    );
  }
}*/
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => NotificationBloc(
          context: context,
          offset: 0,
          limit: 10,
          mData: [],
        )..add(LoadNotificationEvent()),
        child: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NotificationInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoadedState) {
              final mData = state.notifications;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NotificationBloc>().add(LoadNotificationEvent());
                },
                child: mData.isEmpty
                    ? Center(child: Text('No notifications available.'))
                    : NotificationListView(
                  notifications: mData,
                  loadNextPage: () {
                    context.read<NotificationBloc>().add(LoadMoreNotificationEvent());
                  },
                  isNextPageAvailable: state.nextLink,
                  offset: context.read<NotificationBloc>().offset,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class NotificationListView extends StatefulWidget {
  final List<MyNotifications.Data> notifications;
  final VoidCallback loadNextPage;
  final bool isNextPageAvailable;
  final int offset;

  const NotificationListView({
    Key? key,
    required this.notifications,
    required this.loadNextPage,
    required this.isNextPageAvailable,
    required this.offset,
  }) : super(key: key);

  @override
  _NotificationListViewState createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingNextPage = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_isLoadingNextPage && widget.isNextPageAvailable) {
      setState(() {
        _isLoadingNextPage = true;
      });
      widget.loadNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.notifications.length + (widget.isNextPageAvailable ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.notifications.length) {
          final notification = widget.notifications[index];
          return NotificationItem(notification: notification);
        } else if (index == widget.notifications.length && widget.isNextPageAvailable) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
      controller: _scrollController,
    );
  }
}


