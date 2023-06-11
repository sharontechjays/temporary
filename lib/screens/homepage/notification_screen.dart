import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/widgets/notfication_item.dart';

import '../../blocs/notifications/notfication_bloc.dart';
import '../../blocs/notifications/notfication_event.dart';
import '../../blocs/notifications/notification_state.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(
        context: context,
        offset: 0,
        limit: 3,
        mData: [],
      )..add(LoadNotificationEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoadedState) {
              final mData = state.notifications;
              return ListView.builder(
                itemCount: mData.length,
                itemBuilder: (context, index) {
                  final notification = mData[index];
                  return NotificationItem(notification: notification);
                },
              );
            } else if (state is NotificationErrorState) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
