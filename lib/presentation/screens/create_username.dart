import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/blocs/createusername/create_username_bloc.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/allow_notifications_screen.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';
import '../utils/styles/custom_dimens.dart';
import '../widgets/custom_appbar.dart';

class CreateUsernameScreen extends StatelessWidget {
  static const String routeName = RouteNames.createUsrNameScreen;

  const CreateUsernameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: "", onAppbarRightButtonClicked: navToSignInScreen),
      body: BlocProvider(
        create: (_) => CreateUsernameBloc(),
        child: const CreateUserNameForm(),
      ),
    );
  }
}

navToSignInScreen(BuildContext context) {
  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
}

class CreateUserNameForm extends StatefulWidget {
  const CreateUserNameForm({Key? key}) : super(key: key);

  @override
  State<CreateUserNameForm> createState() => _CreateUserNameFormState();
}

class _CreateUserNameFormState extends State<CreateUserNameForm> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenHeading(
              title: Strings.createUserName,
            ),
            const ScreenSubHeading(
                text: Strings.createUserNameScreenSubHeading),
            dimenHeight32,
            CustomFormField(
                myController: _usernameController,
                title: Strings.userName,
                prefilledText: "",
                hintText: Strings.usernameTextHint),
            dimenHeight32,
            const SizedBox(height: 32),
            PrimaryButton(
              title: Strings.confirm,
              onPrimaryButtonClicked: _onConfirmButtonClicked,
            ),
            const SizedBox(height: 16),
            BlocConsumer<CreateUsernameBloc, CreateUsernameState>(
              listener: (context, state) {
                if (state is CreateUsernameSuccess) {
                  navToAllowNotificationScreen(context);
                } else if (state is CreateUsernameFailure) {
                  _clearForm(context);
                }
              },
              builder: (context, state) {
                if (state is CreateUsernameFailure) {
                  return Text(state.error);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  navToAllowNotificationScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, AllowNotificationsScreen.routeName);
  }

  void _onConfirmButtonClicked(BuildContext context) {
    final createUsernameBloc = BlocProvider.of<CreateUsernameBloc>(context);
    createUsernameBloc.add(CreateUsernameButtonPressed(username: ""));
  }

  void _onUsernameChanged(BuildContext context) {
    final createUsernameBloc = BlocProvider.of<CreateUsernameBloc>(context);
    createUsernameBloc.add(CreateUsernameAvailability(username: ""));
  }

  void _clearForm(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
