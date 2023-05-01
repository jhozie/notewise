import 'package:notewise/services/auth/auth_provider.dart';
import 'package:notewise/services/auth/auth_user.dart';
import 'package:notewise/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  AuthService(this.provider);
  final AuthProvider provider;
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser(
      {required String email, required String password, required fullName}) {
    return provider.createUser(
        email: email, password: password, fullName: fullName);
  }

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    return provider.logIn(email: email, password: password);
  }

  @override
  Future<void> logOut() {
    return provider.logOut();
  }

  @override
  Future<void> sendEmailVerification() {
    return provider.sendEmailVerification();
  }

  @override
  Future<void> initialize() {
    return provider.initialize();
  }

  @override
  Future<void> updatePassword(
      {required String email,
      required String oldPassword,
      required String newPassword}) {
    return provider.updatePassword(
      email: email,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
