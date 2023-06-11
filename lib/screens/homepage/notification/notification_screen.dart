import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/screens/homepage/notification/widgets/notification_list_view.dart';
import '../../../blocs/notifications/notfication_bloc.dart';
import '../../../blocs/notifications/notfication_event.dart';
import '../../../blocs/notifications/notification_state.dart';

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
              return mData.isEmpty
                  ? const Center(child: Text('No notifications available.'))
                  : NotificationListView(
                      notifications: mData,
                      loadNextPage: () {
                        context
                            .read<NotificationBloc>()
                            .add(LoadMoreNotificationEvent());
                      },
                      isNextPageAvailable: state.nextLink,
                      offset: context.read<NotificationBloc>().offset,
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
