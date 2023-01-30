import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../../cubit/cart_cubit.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingVertical10,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          CartCubit cubit = CartCubit.getContext(context);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: cubit.items.length,
            itemBuilder: (context, index) {
              final item = cubit.items[index];
              return Padding(
                padding: kPaddingHorizontal10,
                child: Card(
                  color: kBrightColor,
                  elevation: 5,
                  child: Padding(
                    padding: kPaddingAll10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Image.asset(
                            'assets/${item['image']}',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          kSizedBoxWidth15,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 16,
                                ),
                              ),
                              kSizedBoxHeight10,
                              Text(
                                '\$${item['price']}',
                                style: const TextStyle(
                                  color: kAmberColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ]),
                        ElevatedButton(
                            onPressed: () {
                              cubit.insertIntoCart(
                                  item['name'], item['price'], item['image']);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: kWhiteColor,
                                content: Text(
                                  'Item added to cart successfully',
                                  style: TextStyle(color: kBrightColor),
                                ),
                              ));
                            },
                            child: const Text('Add to Cart'))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
