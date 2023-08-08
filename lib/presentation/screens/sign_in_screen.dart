import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/data/SharedPreferencesHelper.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/onboarding/onboarding.dart';
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
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (_) => SignInBloc(),
        child: const SignInForm(),
      ),
    );
  }
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
    final bloc = BlocProvider.of<SignInBloc>(context);

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
                emailController: _emailController,
                title: Strings.usernameOrEmail,
                hintText: Strings.usernameOrEmailHintText),
            dimenHieght32,

            Column(
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
            ),
            const SizedBox(height: 24),
            CustomTextButton(
              text: Strings.forgotPasswordOrUsername,
              onClickButton: navToForgotPassword,
            ),
            const SizedBox(height: 24),
            CustomMaterialButton(
                bloc: bloc,
                emailController: _emailController,
                passwordController: _passwordController),
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

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.bloc,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final SignInBloc bloc;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bloc.add(SignInButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
