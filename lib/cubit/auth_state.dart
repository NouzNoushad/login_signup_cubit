part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSignUpState extends AuthState{}

class AuthDatabaseCreateState extends AuthState{}

class AuthDatabaseInsertState extends AuthState{}

class AuthDatabaseGetState extends AuthState{}
