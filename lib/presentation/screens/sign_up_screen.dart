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

  const SignUpScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: Strings.logIn, onAppbarRightButtonClicked: navToSignInScreen),
      body: BlocProvider(
        create: (_) => SignUpBloc(),
        child: SignUpForm(
          email: email,
        ),
      ),
    );
  }
}

navToSignInScreen(BuildContext context) {
  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
}

navToVerifyOTPScreen(BuildContext context, String email) {
  Navigator.pushReplacementNamed(context, VerifyOTPScreen.routeName,
      arguments: email);
}

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key, required this.email}) : super(key: key);
  final String email;

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
                prefilledText: email,
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
                  navToVerifyOTPScreen(context, state.message);
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
}
