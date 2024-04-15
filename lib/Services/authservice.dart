import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:code_u_knight/Models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create the user with email and password

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<UserCredential?> registerwithemailpassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // print(_auth.currentUser!.uid);
      await _auth.currentUser?.sendEmailVerification();
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

// Sign in with email/password
  Future<UserCredential?> signinwithemailpassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (!user!.emailVerified) {
        await _auth.signOut();
        user.sendEmailVerification();
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign out
  Future<void> signout() async {
    await _auth.signOut();
  }
}
