import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_state.dart';


class AuthCubit extends Cubit<AuthenticationState> {
  AuthCubit() : super(EmailInitial());

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // final user = FirebaseAuth.instance.currentUser;
  //
  // Future<void> sendEmailVerification() async {
  //   emit(EmailSending());
  //   try {
  //     await user?.sendEmailVerification();
  //     emit(EmailSent());
  //   } catch (_) {
  //     emit(EmailError());
  //   }
  // }




  final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  );

  void emitError(String message) {
  emit(EmailError(message));
  }

  Future<void> signInWithGoogle() async {
  try {
  emit(EmailSending());

  final googleUser = await _googleSignIn.signIn();

  if (googleUser == null) {
  emitError("Google sign-in cancelled");
  return;
  }

  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);

  emit(EmailVerified());
  } on FirebaseAuthException catch (e) {
  emitError(e.message ?? e.code);
  } catch (e) {
  emitError(e.toString());
  }
  }





  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.code ?? 'auth_error';
    } catch (e) {
      return e.toString();
    }
  }


  Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
  }

  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.code ?? 'signup_failed';
    } catch (e, s) {
      print('SIGNUP ERROR: $e');
      print('STACKTRACE: $s');
      return e.toString();
    }
  }


  Future<String?> reset({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return 'unknown_error';
    }
  }

}
