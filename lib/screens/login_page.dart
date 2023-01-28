import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_validation_form/constants/colors.dart';
import 'package:simple_validation_form/constants/styles.dart';
import 'package:simple_validation_form/screens/components/custom_text_field.dart';
import 'package:simple_validation_form/screens/home_page.dart';
import 'package:simple_validation_form/screens/signup_page.dart';

import '../cubit/auth_cubit.dart';

var _formKey = GlobalKey<FormState>();
var _emailController = TextEditingController();
var _passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Login',
          style: TextStyle(color: kBorderColor, letterSpacing: 2),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.getContext(context);
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(shrinkWrap: true, children: [
                  CustomFormFields(
                    hintText: 'Email',
                    controller: _emailController,
                  ),
                  kSizedBoxHeight10,
                  CustomFormFields(
                    hintText: 'Password',
                    controller: _passwordController,
                  ),
                  kSizedBoxHeight10,
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      ),
                      child: const Text(
                        'create an account',
                        style: TextStyle(
                          fontSize: 16.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  kSizedBoxHeight25,
                  SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              var authenticate = cubit.authenticateUser(
                                  _emailController.text,
                                  _passwordController.text);

                              if (authenticate) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: kErrorColor,
                                  content: Text(
                                    'You have successfully logged in',
                                    style: TextStyle(color: kBorderColor),
                                  ),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: kErrorColor,
                                  content: Text(
                                    'User does not exists',
                                    style: TextStyle(color: kBorderColor),
                                  ),
                                ));
                              }
                              _emailController.clear();
                              _passwordController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kBorderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          )))
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
