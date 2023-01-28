import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_validation_form/constants/colors.dart';
import 'package:simple_validation_form/screens/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text('Home Page'),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: kErrorColor,
                  content: Text(
                    'You have logged out',
                    style: TextStyle(color: kBorderColor),
                  ),
                ));
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(
            color: kBorderColor,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
