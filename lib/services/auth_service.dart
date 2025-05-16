import 'package:firebase_auth/firebase_auth.dart';
import 'package:practicing_firebase_authentication/services/network_client.dart';

class AuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static late final UserCredential credential;

  static Future<NetworkClient> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      print('inside try');
      credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      //print(credential);
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

  static Future<NetworkClient> verifyEmail() async{
    try{
      if(credential.user != null){
        print('inside credential');
        final user = credential.user;
        await user?.sendEmailVerification();
        return NetworkClient(isSuccess: true, errorMessage: '');
      }
      return NetworkClient(isSuccess: false, errorMessage: 'user not signed in');

    }on FirebaseAuthException catch(e){
      return NetworkClient(isSuccess: false, errorMessage: e.toString());
    }catch(e){
      return NetworkClient(isSuccess: false, errorMessage: e.toString());
    }
  }
}
