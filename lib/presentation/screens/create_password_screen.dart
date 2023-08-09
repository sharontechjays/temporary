import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/blocs/create_password_bloc.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/create_username.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';
import '../utils/styles/custom_dimens.dart';
import '../widgets/custom_appbar.dart';

class CreatePasswordScreen extends StatelessWidget {
  static const String routeName = RouteNames.createPasswordScreen;

  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: "", onAppbarRightButtonClicked: navToSignUPScreen),
      body: BlocProvider(
        create: (_) => CreatePasswordBloc(),
        child: const CreatePasswordForm(),
      ),
    );
  }
}

void navToSignUPScreen(BuildContext context) {
  Navigator.pushReplacementNamed(context, SignUpScreen.routeName,
      arguments: "");
}

class CreatePasswordForm extends StatefulWidget {
  const CreatePasswordForm({Key? key}) : super(key: key);

  @override
  State<CreatePasswordForm> createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<CreatePasswordForm> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenHeading(
              title: Strings.createPassword,
            ),
            const ScreenSubHeading(text: Strings.createPasswordSubHeading),
            dimenHeight32,
            Column(
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
            ),
            dimenHeight32,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryColor),
                    ),
                    hintStyle: hintStyle,
                    hintText: Strings.confirmPasswordHintText,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryColor),
                    ),
                    suffixIcon: IconButton(
                      icon: _isConfirmPasswordVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: _toggleConfirmPasswordVisibility,
                      color: AppColors.hintColor,
                    ),
                  ),
                  obscureText: !_isConfirmPasswordVisible,
                  controller: _confirmPasswordController,
                ),
              ],
            ),
            dimenHeight32,
            PrimaryButton(
              title: Strings.confirm,
              onPrimaryButtonClicked: _onConfirmButtonClicked,
            ),
            BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
              listener: (context, state) {
                if (state is CreatePasswordSuccess) {
                } else if (state is CreatePasswordFailure) {
                  _clearForm(context);
                }
              },
              builder: (context, state) {
                if (state is CreatePasswordLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CreatePasswordFailure) {
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
    _confirmPasswordController.clear();
    _passwordController.clear();
    FocusScope.of(context).unfocus();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _onConfirmButtonClicked(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      CreateUsernameScreen.routeName,
    );
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void navToForgotPassword(BuildContext context) {}
}
