import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../../cubit/cart_cubit.dart';

class CartModule extends StatelessWidget {
  const CartModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        CartCubit cubit = CartCubit.getContext(context);
        cubit.cartItemsTotal();
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: kPaddingVertical10,
                child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.cartLists.length,
                      itemBuilder: (context, index) {
                        final item = cubit.cartLists[index];
                        return Padding(
                          padding: kPaddingHorizontal10,
                          child: Slidable(
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.2,
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      cubit.deleteFromCart(item['id']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: kWhiteColor,
                                        content: Text(
                                          'Item removed from the cart',
                                          style: TextStyle(
                                            color: kBrightColor,
                                          ),
                                        ),
                                      ));
                                    },
                                    backgroundColor: kBrightColor,
                                    foregroundColor: kErrorColor,
                                    icon: Icons.close,
                                    borderRadius: BorderRadius.circular(10),
                                  )
                                ]),
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
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      kSizedBoxWidth15,
                                      Text(
                                        item['name'],
                                        style: const TextStyle(
                                          color: kWhiteColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ]),
                                    Text(
                                      '\$${item['price']}',
                                      style: const TextStyle(
                                        color: kAmberColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ),
            ),
            Container(
              color: kBrightColor,
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$${cubit.sum}',
                      style: const TextStyle(
                        color: kAmberColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
            ),
          ],
        );
      },
    );
  }
}
