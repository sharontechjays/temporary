import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<String> titles = ['Tab 1', 'Tab 2', 'Tab 3'];
  final List<String> descriptions = [
    'This is the first tab description.',
    'This is the second tab description.',
    'This is the third tab description.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => buildIndicator(index, context),
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  return OnBoardingPage(
                    title: titles[index],
                    description: descriptions[index],
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
    return Container(
      width: (MediaQuery.of(context).size.width - 100) / 3,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _currentPage >=index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final String title;
  final String description;

  const OnBoardingPage(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
