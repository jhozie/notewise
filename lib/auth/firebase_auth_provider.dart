import 'package:firebase_auth/firebase_auth.dart';
import 'package:notewise/auth/auth_provider.dart';
import 'package:notewise/auth/auth_user.dart';
import 'package:notewise/screens/utilities/exceptions.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw RegisterInvalidEmailException();
      } else if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        throw GenericException();
      }
    } catch (e) {
      throw GenericException();
    }
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    final user = currentUser;
    if (user != null) {
      return user;
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    final user = currentUser;
    if (user != null) {
      user;
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {}
  }
}
