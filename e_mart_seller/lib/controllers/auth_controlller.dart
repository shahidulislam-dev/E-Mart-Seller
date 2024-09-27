import 'package:e_mart_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  //textControllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

//login method

  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginMethod(context) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return userCredential;
  }

  //sign out method
  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
