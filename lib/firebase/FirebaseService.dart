import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

// google
  static final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
  static void signInWithGoogle() {
    FirebaseAuth.instance.signInWithProvider(_googleAuthProvider);
  }

// email
  // sign up with email and password
  static Future<void> signUpWithEmailAndPassword(String email, String password,
      {String? userName}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // reload user
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(userName);

        await user.reload();

        user = _auth.currentUser;
      }
    } catch (e) {
      print(e);
    }
  }

  // sign in with email and password
  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return null;
  }

  // send email verification
  static Future<void> sendVerificationEmail(User user) async {
    await user.sendEmailVerification();
  }

  // reload user
  static Future<User?> reloadUser() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      return currentUser;
    }
    return null;
  }

  // sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
