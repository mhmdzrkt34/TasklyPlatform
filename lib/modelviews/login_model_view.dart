import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:tasklyplatform/models/TaskModel.dart';
import 'package:tasklyplatform/modelviews/notes_model_view.dart';
import 'package:tasklyplatform/modelviews/tasks_model_view.dart';
import 'package:tasklyplatform/services/AuthService/AuthService.dart';
import 'package:tasklyplatform/services/AuthService/IAuthService.dart';

class LoginModelView extends ChangeNotifier {

   final IAuthService authService = AuthService();
  bool isLoading=false;



  LoginModelView();

    Future<void> signInWithEmailAndPassword(String email, String password,BuildContext context) async{
      isLoading=true;
      notifyListeners();

 try {
      await authService.signInWithEmailAndPassword(email, password);
      Fluttertoast.showToast(
        msg: "Login successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      returnToInitialState();
      GetIt.instance.get<NotesModelView>().fetchNotes();
       GetIt.instance.get<TasksModelView>().fetchTasks();

      Navigator.pushReplacementNamed(context, "/Home");

    } on FirebaseAuthException catch (e) {
      isLoading=false;
      notifyListeners();
      if (e.code == 'email-not-verified') {
        Fluttertoast.showToast(
          msg: "Email not verified. Please check your inbox.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Login failed: ${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(
        msg: "No internet connection.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: ${e.toString()}",
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
  
}