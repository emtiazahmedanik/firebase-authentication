import 'package:firebase_auth/firebase_auth.dart';
import 'package:practicing_firebase_authentication/services/network_client.dart';

class AuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<NetworkClient> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      print('inside try');
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      print(credential);
      return NetworkClient(isSuccess: true, errorMessage: '');

    } on FirebaseAuthException catch (e) {
      String errorMsg = "";
      if (e.code == 'weak-password') {
        errorMsg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMsg = 'The account already exists for that email.';
      }
      print(errorMsg);
      return NetworkClient(isSuccess: false, errorMessage: errorMsg);

    } catch (e) {
      print(e.toString());
      return NetworkClient(isSuccess: false, errorMessage: e.toString());

    }
  }
}
