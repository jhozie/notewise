abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  AuthEventLogin(this.email, this.password);
}

class AuthEventLoggedOut extends AuthEvent {
  const AuthEventLoggedOut();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventEmailLogin extends AuthEvent {
  AuthEventEmailLogin();
}
