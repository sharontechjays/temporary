import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/screens/verify_otp_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';
import '../blocs/signup/sign_up_bloc.dart';
import '../utils/styles/custom_dimens.dart';
import '../widgets/custom_appbar.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = RouteNames.signUpScreen;

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: Strings.logIn, onAppbarRightButtonClicked: navToSignInScreen),
      body: BlocProvider(
        create: (_) => SignUpBloc(),
        child: const SignUpForm(),
      ),
    );
  }
}

navToSignInScreen(BuildContext context) {
  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
}

navToVerifyOTPScreen(BuildContext context) {
  Navigator.pushReplacementNamed(context, VerifyOTPScreen.routeName);
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenHeading(
              title: Strings.signUpScreenHeading,
            ),
            const ScreenSubHeading(text: Strings.signUpSubHeading),
            CustomFormField(
                myController: _emailController,
                title: Strings.email,
                hintText: Strings.usernameOrEmailHintText),
            dimenHeight32,
            const SizedBox(height: 24),
            PrimaryButton(
              title: Strings.confirm,
              onPrimaryButtonClicked: _onConfirmButtonClicked,
            ),
            const SizedBox(height: 16),
            BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  navToVerifyOTPScreen(context);
                } else if (state is SignupFailure) {
                  _clearForm(context);
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SignupFailure) {
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

  void _onConfirmButtonClicked(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    signUpBloc.add(SignUpButtonPressed(email: _emailController.text));
  }

  void _clearForm(BuildContext context) {
    _emailController.clear();
    FocusScope.of(context).unfocus();
  }

  void navToForgotPassword(BuildContext context) {}
}
