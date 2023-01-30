import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_validation_form/models/users.dart';
import 'package:sqflite/sqflite.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static getContext(context) => BlocProvider.of<AuthCubit>(context);

  Database? database;
  List<Map>? users = [];

  nameValidation(value) {
    if (value.isEmpty) {
      return 'Name field is required';
    }
  }

  emailValidation(value) {
    if (value.isEmpty) {
      return 'Email field is required';
    } else if (!value.contains('@')) {
      return 'Please provide valid email';
    }
  }

  passwordValidation(value) {
    if (value.isEmpty) {
      return 'Password field is required';
    } else if (value.length < 6) {
      return 'Password should be 6 characters long';
    }
  }

  cPasswordValidation(value, password) {
    if (value.isEmpty) {
      return 'Confirm Password field is required';
    } else if (value != password) {
      return 'Password do not match';
    }
  }

  // create database
  createDatabase() {
    openDatabase('auth.db', version: 1, onCreate: (database, version) {
      database.execute(
        'CREATE TABLE auth (id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
      );
    }, onOpen: (database) {
      getUsersData(database);
    }).then((value) {
      print('Table created');
      database = value;
      emit(AuthDatabaseCreateState());
    }).catchError((err) {
      print('Failed to create database table, Error: ${err.toString()}');
    });
  }

  // Insert data into database
  insertToDatabase(name, email, password) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO auth (name, email, password) VALUES (?, ?, ?)', [
        name,
        email,
        password,
      ]).then((value) {
        getUsersData(database!);
        print('User data added to database');
        emit(AuthDatabaseInsertState());
      }).catchError((err) {
        print('Failed to insert user data, Error: ${err.toString()}');
      });
    });
  }

  // get users data from database
  getUsersData(Database database) {
    users = [];
    database
        .rawQuery(
      'SELECT * FROM auth',
    )
        .then((value) {
      print(value);
      for (var val in value) {
        users!.add(val);
      }
      emit(AuthDatabaseGetState());
    }).catchError((err) {
      print('Failed to get user data, Error: ${err.toString()}');
    });
  }

  // authentication
  authenticateUser(email, password) {
    print(email);
    List<String> emails = [];
    List<String> passwords = [];
    var user = users!.where((user) => user['email'] == email);
    print(user);
    for (var user in users!) {
      emails.add(user['email']);
      passwords.add(user['password']);
    }
    if (emails.contains(email) && passwords.contains(password)) {
      return true;
    } else {
      return false;
    }
  }
}
