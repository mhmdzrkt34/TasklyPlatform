
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasklyplatform/services/AuthService/AuthService.dart';
import 'package:tasklyplatform/services/AuthService/IAuthService.dart';

class RegisterModelView extends ChangeNotifier {

  IAuthService authService=AuthService();

  bool isLoading=false;




  RegisterModelView();


  Future<void> registerWithEmailAndPassword(String email,String password,String name,BuildContext context) async {
    isLoading=true;
    notifyListeners();

    try {

      await authService.registerWithEmailAndPassword(name, email, password);

         Fluttertoast.showToast(
        msg: "Registration success confirm you email in order to Login",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );




      returnToInitialState();
      Navigator.pushReplacementNamed(context, "/login");


    }catch( e){

      isLoading=false;
      notifyListeners();
          String errorMessage = getErrorMessage(e);
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );

      
    }



  }

  void returnToInitialState(){
    isLoading=false;
    notifyListeners();
    




  }


String getErrorMessage(Object e) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return 'Registration failed: ${e.message}';
    }
  } else if (e is SocketException) {
    return 'No internet connection.';
  } else {
    return 'An unexpected error occurred: ${e.toString()}';
  }
}
}