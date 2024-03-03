import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/controllers/start_screen_controller.dart';
import 'package:task/models/user_model.dart';

class StartScreenModel {
  static String message = '';
  Future<bool> signUserIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;
      UserModel.email = email;
      UserModel.id = userId;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      StartScreenController.message = e.code;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;
      UserModel.email = email;
      UserModel.id = userId;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      UserModel.score = 0;
      await users.doc(userId).set({'score': 0, 'email': email});
      print('User created and document added successfully!');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      StartScreenController.message = e.code;
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signUserOut() async {
    try {
      FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      StartScreenController.message = e.code;
      return false;
    } catch (e) {
      return false;
    }
  }
}
