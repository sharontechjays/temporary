import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/data/SharedPreferencesHelper.dart';


import '../blocs/sign_in/sign_in_bloc.dart';
import '../blocs/sign_in/sign_in_event.dart';
import '../blocs/sign_in/sign_in_state.dart';
import 'homepage.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocProvider(
        create: (context) => SignInBloc(),
        child: SignInForm(),
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: _isPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            obscureText: !_isPasswordVisible,
            controller: passwordController,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              bloc.add(SignInButtonPressed(
                email: emailController.text,
                password: passwordController.text,
              ));
            },
            child: const Text('Sign In'),
          ),
          const SizedBox(height: 16),
          BlocListener<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state is SignInSuccess) {
                SharedPreferencesHelper.init();
                SharedPreferencesHelper.setDummyToken(state.message);
                print(state.message);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
              if (state is SignInFailure) {
                clearForm(context);
              }
            },
            child: BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInLoading) {
                  return const CircularProgressIndicator();
                } else if (state is SignInFailure) {
                  return Text(state.error);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void clearForm(BuildContext context) {
    emailController.clear();
    passwordController.clear();
    FocusScope.of(context).unfocus();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}
