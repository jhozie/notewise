import 'auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();

  Future<void> initialize();
}
