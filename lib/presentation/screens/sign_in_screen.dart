import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/data/SharedPreferencesHelper.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';

import '../blocs/sign_in/sign_in_bloc.dart';
import '../blocs/sign_in/sign_in_event.dart';
import '../blocs/sign_in/sign_in_state.dart';
import '../utils/styles/custom_dimens.dart';
import '../widgets/custom_appbar.dart';
import 'homepage.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = RouteNames.signInScreen;

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(onAppbarRightButtonClicked: navToSignUPScreen),
      body: BlocProvider(
        create: (_) => SignInBloc(),
        child: const SignInForm(),
      ),
    );
  }
}

void navToSignUPScreen(BuildContext context) {
  Navigator.pushReplacementNamed(context, SignUpScreen.routeName,
      arguments: "");
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.logIn,
              style: screenTitle,
            ),
            CustomFormField(
                myController: _emailController,
                title: Strings.usernameOrEmail,
                prefilledText: "",
                hintText: Strings.usernameOrEmailHintText),
            dimenHeight32,
            buildPasswordColumn(),
            const SizedBox(height: 24),
            CustomTextButton(
              text: Strings.forgotPasswordOrUsername,
              onClickButton: navToForgotPassword,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
                title: Strings.signIn,
                onPrimaryButtonClicked: _signInButtonClicked),
            const SizedBox(height: 16),
            BlocConsumer<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignInSuccess) {
                  SharedPreferencesHelper.init();
                  SharedPreferencesHelper.setDummyToken(state.message.token);
                  debugPrint(state.message.email);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else if (state is SignInFailure) {
                  _clearForm(context);
                }
              },
              builder: (context, state) {
                if (state is SignInLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SignInFailure) {
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

  Column buildPasswordColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontSize: 16.0),
        ),
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
            hintStyle: hintStyle,
            hintText: Strings.passwordHint,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
            suffixIcon: IconButton(
              icon: _isPasswordVisible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: _togglePasswordVisibility,
              color: AppColors.hintColor,
            ),
          ),
          obscureText: !_isPasswordVisible,
          controller: _passwordController,
        ),
      ],
    );
  }

  _signInButtonClicked(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    bloc.add(SignInButtonPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  void _clearForm(BuildContext context) {
    _emailController.clear();
    _passwordController.clear();
    FocusScope.of(context).unfocus();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void navToForgotPassword(BuildContext context) {}
}
