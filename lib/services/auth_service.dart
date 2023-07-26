import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Login
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      User? user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      return user != null;
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      return e.message;
    } catch (e) {
      logger.e(e);
    }
  }

  //SignUp
  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await DatabaseService(uid: user.uid).createUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return e;
    } catch (e) {
      logger.e(e);
    }
  }

  //logout
  Future logOut() async {
    try {
      HelperFunctions.clearUserLoggedInStatus();
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      return e.message;
    } catch (e) {
      return e;
    }
  }
}
