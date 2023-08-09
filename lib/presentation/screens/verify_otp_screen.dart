import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter/presentation/blocs/verifyotp/verify_otp_bloc.dart';
import 'package:test_flutter/presentation/blocs/verifyotp/verify_otp_event.dart';
import 'package:test_flutter/presentation/constants/app_strings.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';
import '../blocs/verifyotp/verify_otp_state.dart';
import '../utils/styles/custom_dimens.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/otp_text_field.dart';
import 'create_password_screen.dart';

class VerifyOTPScreen extends StatelessWidget {
  static const String routeName = RouteNames.verifyOtpScreen;

  const VerifyOTPScreen({Key? key, required this.mEmail}) : super(key: key);
  final String mEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: "", onAppbarRightButtonClicked: navToSignInScreen),
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
                    navToSignUpScreen(context, widget.mEmail);
                  },
                  icon: SvgPicture.asset('assets/icons/ic_editPencil.svg'),
                ),
              ],
            ),
            dimenHeight32,
            OTPTextField(
              width: MediaQuery.of(context).size.width,
              length: 4,
              fieldWidth: 50,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.start,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {},
            ),
            dimenHeight32,
            CountdownWidget(
              onResendClicked: _onResendClicked,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              title: Strings.confirm,
              onPrimaryButtonClicked: _onConfirmButtonClicked,
            ),
            const SizedBox(height: 16),
            BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
              listener: (context, state) {
                if (state is VerifyOTPSuccess) {
                  navToCreatePasswordScreen(context);
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

  navToSignUpScreen(BuildContext context, String email) {
    Navigator.pushReplacementNamed(context, SignUpScreen.routeName,
        arguments: email);
  }

  navToCreatePasswordScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, CreatePasswordScreen.routeName);
  }

  _onResendClicked(BuildContext context) {
    if (kDebugMode) {
      print("clicked resend button");
    }
  }

  void _onConfirmButtonClicked(BuildContext context) {
    final verifyOtpBloc = BlocProvider.of<VerifyOtpBloc>(context);
    verifyOtpBloc.add(VerifyOtpButtonPressed(pin: "0000"));
  }

  void _clearForm(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void navToForgotPassword(BuildContext context) {}
}
