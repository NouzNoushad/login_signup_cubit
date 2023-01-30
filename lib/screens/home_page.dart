import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_validation_form/constants/colors.dart';
import 'package:simple_validation_form/cubit/cart_cubit.dart';
import 'package:simple_validation_form/screens/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        CartCubit cubit = CartCubit.getContext(context);
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
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: kBrightColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: kAmberColor,
            unselectedItemColor: kBackgroundColor,
            currentIndex: cubit.currentBottomNavIndex,
            onTap: (value) => cubit.changeBottomNavIndex(value),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: '',
              ),
            ],
          ),
          body: cubit.moduleScreens[cubit.currentBottomNavIndex],
        );
      },
    );
  }
}
