import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthEvent { login, logout }

class AuthBloc extends Bloc<AuthEvent, bool> {
  AuthBloc() : super(false);

  @override
  Stream<bool> mapEventToState(AuthEvent event) async* {
    switch (event) {
      case AuthEvent.login:
        yield true;
        break;
      case AuthEvent.logout:
        yield false;
        break;
    }
  }
}