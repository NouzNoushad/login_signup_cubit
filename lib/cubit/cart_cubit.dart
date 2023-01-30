import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_validation_form/screens/modules/cart.dart';
import 'package:simple_validation_form/screens/modules/home.dart';
import 'package:sqflite/sqflite.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static getContext(context) => BlocProvider.of<CartCubit>(context);

  int currentBottomNavIndex = 0;

  List<Widget> moduleScreens = [
    const HomeModule(),
    const CartModule(),
  ];

  Database? database;
  List<Map> cartLists = [];
  int sum = 0;

  changeBottomNavIndex(value) {
    currentBottomNavIndex = value;
    emit(CartBottomNavChangeState());
  }

  List<Map<String, dynamic>> items = [
    {
      'image': 'ferns_desert.jpg',
      'name': 'Ferns desert',
      'price': 200,
    },
    {
      'image': 'snake_plant.jpg',
      'name': 'Snake Plant',
      'price': 400,
    },
    {
      'image': 'ferns.jpg',
      'name': 'Ferns',
      'price': 100,
    },
    {
      'image': 'bonsai.jpg',
      'name': 'Bonsai',
      'price': 500,
    },
  ];

  createCartDatabase() {
    openDatabase('cart.db', version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE cart (id INTEGER PRIMARY KEY, name TEXT, price TEXT, image TEXT)');
    }, onOpen: (db) {
      getCartDetails(db);
      emit(CartGetDatabaseState());
    }).then((value) {
      print('Cart table created');
      database = value;
      emit(CartCreateDatabaseState());
    }).catchError((err) {
      print('Failed to create cart database, error: ${err.toString()}');
    });
  }

  getCartDetails(Database db) {
    cartLists = [];
    db.rawQuery('SELECT * FROM cart').then((carts) {
      for (var cart in carts) {
        cartLists.add(cart);
      }
      emit(CartGetDatabaseState());
    }).catchError((err) {
      print('Failed to get cart lists, error: ${err.toString()}');
    });
  }

  insertIntoCart(name, price, image) {
    database!
        .rawInsert('INSERT INTO cart (name, price, image) VALUES (?, ?, ?)', [
      name,
      price,
      image,
    ]).then((value) {
      getCartDetails(database!);
      print('Items added to Cart');
      emit(CartInsertDatabaseState());
    }).catchError((err) {
      print('Failed to insert items into cart, error: ${err.toString()}');
    });
  }

  deleteFromCart(id) {
    database!.rawDelete('DELETE FROM cart WHERE id = ?', [id]).then((value) {
      getCartDetails(database!);
      print('Item deleted from cart');
      emit(CartDeleteDatabaseState());
    }).catchError((err) {
      print('Failed to delete items from cart, error: ${err.toString()}');
    });
  }

  cartItemsTotal() {
    List<int> prices = cartLists.map<int>((cart) => int.parse(cart['price'])).toList();
    sum = prices.fold(
        0, (previousValue, currentValue) => previousValue + currentValue);
  }
}
