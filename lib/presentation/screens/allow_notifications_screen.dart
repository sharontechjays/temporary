import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_dimens.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';
import '../widgets/custom_appbar.dart';
import 'create_password_screen.dart';

class AllowNotificationsScreen extends StatelessWidget {
  static const String routeName = RouteNames.allowNotifications;

  const AllowNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          title: Strings.skip, onAppbarRightButtonClicked: _navToHomePage),
      body: AllowNotificationBody(),
    );
  }
}

_navToHomePage(BuildContext context) {
  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
}

class AllowNotificationBody extends StatelessWidget {
  const AllowNotificationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenHeading(
                title: Strings.neverMissAPage,
              ),
              const ScreenSubHeading(text: Strings.notificationSubHeading),
              dimenHeight32,
              const Center(
                child: Image(
                  image: AssetImage('assets/drawables/image_one.png'),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          PrimaryButton(
            title: Strings.allowNotifications,
            onPrimaryButtonClicked: _onConfirmButtonClicked,
          ),
        ],
      ),
    );
  }

  navToSignUpScreen(BuildContext context, String email) {
    Navigator.pushReplacementNamed(context, SignUpScreen.routeName,
        arguments: email);
  }

  navToCreatePasswordScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, CreatePasswordScreen.routeName);
  }

  void _onConfirmButtonClicked(BuildContext context) {}
}
