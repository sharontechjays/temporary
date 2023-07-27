import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sign_in/sign_in_bloc.dart';
import '../blocs/sign_in/sign_in_event.dart';
import '../blocs/sign_in/sign_in_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
  SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
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
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoading) {
                return const CircularProgressIndicator();
              } else if (state is SignInSuccess) {
                return Text(state.message);
              } else if (state is SignInFailure) {
                return Text(state.error);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
