import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_validation_form/constants/colors.dart';
import 'package:simple_validation_form/screens/login_page.dart';

import 'cubit/auth_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..createDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: kPrimaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
