import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:notewise/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthLoginState extends AuthState {
  final AuthUser user;
  const AuthLoginState(this.user);
}

class AuthLogoutState extends AuthState {
  Exception? exception;
  AuthLogoutState(this.exception);
}

class AuthLoginExceptionState extends AuthState {
  const AuthLoginExceptionState(Exception exception);
}

class AuthLogoutExceptionState extends AuthState {
  const AuthLogoutExceptionState(Exception exception);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthStateEmailLogin extends AuthState {
  const AuthStateEmailLogin(this.credential);
  final UserCredential credential;
}
