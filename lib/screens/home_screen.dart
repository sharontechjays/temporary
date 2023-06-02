import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter/SharedPreferencesHelper.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/screens/home_screen.dart';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getToken() async {
    SharedPreferencesHelper.init();
    String? token = await SharedPreferencesHelper.getString('token');
    return token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<String>(
            future: getToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // While waiting for the future to complete, display a progress indicator
              } else if (snapshot.hasData) {
                return Text(snapshot.data!); // Display the token if the future completed successfully
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Display an error message if an error occurred
              } else {
                return const Text('No token available'); // Display a default message if no data or error is available
              }
            },
          ),
        ),
      ),
    );
  }

}
