import 'package:bloc/bloc.dart';
import 'package:notewise/services/auth/auth_provider.dart';
import 'package:notewise/services/auth/bloc/auth_state.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthLoadingState()) {
    // initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();

      final user = provider.currentUser;
      if (user == null) {
        emit(AuthLogoutState(null));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthLoginState(user));
      }
    });

    // log in
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthLoadingState());
      final email = event.email;
      final password = event.password;

      try {
        final user = await provider.logIn(email: email, password: password);
        emit(AuthLoginState(user));
      } on Exception catch (e) {
        emit(AuthLoginExceptionState(e));
      }
    });

    // Log out

    on<AuthEventLoggedOut>((event, emit) async {
      try {
        emit(AuthLogoutState(null));
        await provider.logOut();
      } on Exception catch (e) {
        emit(AuthLogoutExceptionState(e));
      }
    });

    //Email Google Login
    on<AuthEventEmailLogin>(
      (event, emit) async {
        try {
          emit(const AuthLoadingState());

          final credential = await provider.googleSignIn();
          emit(AuthStateEmailLogin(credential));
        } on Exception catch (e) {
          emit(AuthLoginExceptionState(e));
        }
      },
    );
  }
}
