import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_validation_form/constants/colors.dart';
import 'package:simple_validation_form/constants/styles.dart';
import 'package:simple_validation_form/screens/components/custom_text_field.dart';

import '../cubit/auth_cubit.dart';

var _formKey = GlobalKey<FormState>();
var _nameController = TextEditingController();
var _emailController = TextEditingController();
var _passwordController = TextEditingController();
var _confirmPasswordController = TextEditingController();

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Sign up',
          style: TextStyle(color: kBorderColor, letterSpacing: 2),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.getContext(context);
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(shrinkWrap: true, children: [
                  CustomFormFields(
                    hintText: 'Name',
                    controller: _nameController,
                    validator: (value) => cubit.nameValidation(value),
                  ),
                  kSizedBoxHeight10,
                  CustomFormFields(
                    hintText: 'Email',
                    controller: _emailController,
                    validator: (value) => cubit.emailValidation(value),
                  ),
                  kSizedBoxHeight10,
                  CustomFormFields(
                    hintText: 'Password',
                    controller: _passwordController,
                    validator: (value) => cubit.passwordValidation(value),
                  ),
                  kSizedBoxHeight10,
                  CustomFormFields(
                    hintText: 'Confirm Password',
                    controller: _confirmPasswordController,
                    validator: (value) => cubit.cPasswordValidation(
                        value, _passwordController.text),
                  ),
                  kSizedBoxHeight25,
                  SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            var name = _nameController.text;
                            var email = _emailController.text;
                            var password = _passwordController.text;

                            if (_formKey.currentState!.validate()) {
                              // save user data
                              cubit.insertToDatabase(name, email, password);
                              // clear text
                              _nameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kBorderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: const Text(
                            'Sign up',
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
