part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitialState extends CartState {}

class CartBottomNavChangeState extends CartState{}

class CartCreateDatabaseState extends CartState{}

class CartGetDatabaseState extends CartState{}

class CartInsertDatabaseState extends CartState{}

class CartDeleteDatabaseState extends CartState{}
