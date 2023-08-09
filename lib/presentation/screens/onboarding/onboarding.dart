import 'package:flutter/material.dart';
import 'package:test_flutter/presentation/screens/sign_in_screen.dart';
import 'package:test_flutter/presentation/screens/sign_up_screen.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';

import '../../constants/app_strings.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  int numOfTabs = 4;

  final List<String> titles = [
    'Welcome to Bracketology!',
    'Compete Against Other Fans',
    'Dynamic Gameplay',
    '100% Free to Play'
  ];
  final List<AssetImage> assetImages = [
    const AssetImage('assets/drawables/image_one.png'),
    const AssetImage('assets/drawables/image_one.png'),
    const AssetImage('assets/drawables/image_one.png'),
    const AssetImage('assets/drawables/image_one.png')
  ];

  final List<String> descriptions = [
    'Play fantasy games for all of your favorite reality TV shows in one centralized location.',
    'Join a public league, or start a private league with friends.',
    'Choose from multiple game types, with show-specific rules and fully automated scoring.',
    'We are committed to offering free fantasy gaming for all reality TV fans.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    numOfTabs,
                    (index) => buildIndicator(index, context),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: numOfTabs,
                itemBuilder: (context, index) {
                  return OnBoardingPage(
                    title: titles[index],
                    description: descriptions[index],
                    assetImage: assetImages[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: _currentPage >= index
              ? Colors.white
              : Colors.white.withOpacity(0.50),
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final String title;
  final String description;
  final AssetImage assetImage;

  const OnBoardingPage(
      {super.key,
      required this.title,
      required this.description,
      required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child: Image(
                        image: AssetImage('assets/drawables/image_one.png')))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    title: Strings.getStarted,
                    onPrimaryButtonClicked: navToSignUp),
                const SizedBox(
                  height: 20,
                ),
                CustomTextButton(
                  text: Strings.loginWithExistingAccount,
                  onClickButton: navToSigIn,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void navToSigIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  void navToSignUp(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignUpScreen.routeName,
        arguments: "");
  }
}
