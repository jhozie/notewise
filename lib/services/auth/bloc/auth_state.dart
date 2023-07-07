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

class AuthLoginExceptionState extends AuthState {
  final Exception exception;
  const AuthLoginExceptionState(this.exception);
}

class AuthLogoutState extends AuthState {
  const AuthLogoutState();
}

class AuthLogoutExceptionState extends AuthState {
  const AuthLogoutExceptionState();
}

class AuthSendVerificationState extends AuthState {
  const AuthSendVerificationState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}
