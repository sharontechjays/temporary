import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter/presentation/blocs/verify_otp_bloc.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';
import '../utils/styles/custom_dimens.dart';
import '../widgets/custom_appbar.dart';

class VerifyOTPScreen extends StatelessWidget {
  static const String routeName = RouteNames.verifyOtpScreen;

  const VerifyOTPScreen({Key? key, required this.mEmail}) : super(key: key);
  final String mEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: Strings.logIn, onAppbarRightButtonClicked: navToSignInScreen),
      body: BlocProvider(
        create: (_) => VerifyOtpBloc(),
        child: VerifyOTPForm(
          mEmail: mEmail,
        ),
      ),
    );
  }
}

navToSignInScreen(BuildContext context) {
  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
}

class VerifyOTPForm extends StatefulWidget {
  const VerifyOTPForm({Key? key, required this.mEmail}) : super(key: key);
  final String mEmail;

  @override
  State<VerifyOTPForm> createState() => _VerifyOTPFormState();
}

class _VerifyOTPFormState extends State<VerifyOTPForm> {
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
              title: Strings.verifyOtpHeading,
            ),
            const ScreenSubHeading(text: Strings.verifyOtpSubHeading),
            Row(
              children: [
                Text(
                  widget.mEmail,
                  style: screenTitle.copyWith(fontSize: 14),
                ),
                IconButton(
                  onPressed: () {
                    navToSignInScreen(context, widget.mEmail);
                  },
                  icon: SvgPicture.asset('assets/icons/ic_editPencil.svg'),
                )
              ],
            ),
            dimenHeight32,
            const SizedBox(height: 24),
            PrimaryButton(
              title: Strings.confirm,
              onPrimaryButtonClicked: _onConfirmButtonClicked,
            ),
            const SizedBox(height: 16),
            BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
              listener: (context, state) {
                if (state is VerifyOTPSuccess) {
                } else if (state is VerifyOTPFailure) {
                  _clearForm(context);
                }
              },
              builder: (context, state) {
                if (state is VerifyOtpLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VerifyOTPFailure) {
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

  navToSignInScreen(BuildContext context, String email) {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName,
        arguments: email);
  }

  void _onConfirmButtonClicked(BuildContext context) {
    /*  final VerifyOTPBloc = BlocProvider.of<VerifyOTPBloc>(context);
    VerifyOTPBloc.add(VerifyOTPButtonPressed(email: _emailController.text));*/
  }

  void _clearForm(BuildContext context) {
    _emailController.clear();
    FocusScope.of(context).unfocus();
  }

  void navToForgotPassword(BuildContext context) {}
}
