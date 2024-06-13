import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasklyplatform/services/AuthService/IAuthService.dart';

// ignore: non_constant_identifier_names
class AuthService extends IAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
Future<void> registerWithEmailAndPassword(String name, String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email.toLowerCase(),
      password: password,
    );
    await userCredential.user?.sendEmailVerification();
      String uid = userCredential.user!.uid;
        await _auth.signInWithEmailAndPassword(email: email.toLowerCase(), password: password);


      await _firestore.collection("users").doc(uid).set({
        'name': name,
        'email': email.toLowerCase(),
      
      });
      await _auth.signOut();
      

  } on FirebaseAuthException catch (e) {
    throw e; 
  } on SocketException catch (e) {
    throw e; 
  } catch (e) {
    throw e; 
  }
}


  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.toLowerCase(),
        password: password,
      );

      if (!userCredential.user!.emailVerified) {
        // If the email is not verified, sign out the user and throw an exception
        await _auth.signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Email not verified. Please check your inbox.',
        );
      }

      // Additional sign-in logic if needed

    } on FirebaseAuthException catch (e) {
      throw e; // Re-throw the exception to handle it in the ViewModel
    } on SocketException catch (e) {
      throw e; // Re-throw the exception to handle it in the ViewModel
    } catch (e) {
      throw e; // Re-throw any other exceptions to handle them in the ViewModel
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }


  


  
}