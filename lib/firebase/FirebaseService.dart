import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

// google
  static void signInWithGoogle() {
    FirebaseAuth.instance.signInWithProvider(_googleAuthProvider);
  }

// email
  static void signUpWithEmailAndPassword(String email, String password,
      {Function? onSuccess, Function? onError}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess?.call();
      // await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        onError?.call();
      } else if (e.code == 'email-already-in-use') {
        onError?.call();
      }
    } catch (e) {
      print(e);
    }
  }
}
