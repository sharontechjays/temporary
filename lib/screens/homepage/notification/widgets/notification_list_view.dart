import 'package:flutter/material.dart';
import 'package:test_flutter/models/notifications.dart' as MyNotifications;
import 'package:test_flutter/screens/homepage/notification/widgets/notfication_item.dart';

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
    return ListView.separated(
      itemCount:
          widget.notifications.length + (widget.isNextPageAvailable ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.notifications.length) {
          final notification = widget.notifications[index];
          return NotificationItem(notification: notification);
        } else if (index == widget.notifications.length &&
            widget.isNextPageAvailable) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
      controller: _scrollController,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 2.0,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD4D4D4), Colors.white, Color(0xFFD4D4D4)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
        );

      },
    );
  }
}
