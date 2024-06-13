

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasklyplatform/models/NoteModel.dart';

class NotesModelView extends ChangeNotifier {

  bool noteAddVisible=false;
  bool isLoading=false;


  List<NoteModel>? notes;




  NotesModelView();


  void makeNotAddVisible(){

    noteAddVisible=true;
    notifyListeners();
  }

    void makeNotAddInVisible(){

    noteAddVisible=false;
    notifyListeners();
  }


  void returnToInitialState(){

    noteAddVisible=false;
    isLoading=false;
    notifyListeners();
  }

  Future<void> addNote(String title,String note,TextEditingController titleController,TextEditingController noteController) async{

    isLoading=true;
    notifyListeners();


    try {
    

      await FirebaseFirestore.instance.collection("notes").add({

        "title":title,
        "note":note,
        "user_id":FirebaseAuth.instance.currentUser!.uid,
      });

      titleController.clear();

      noteController.clear();






      returnToInitialState();


      




    }catch(e){
     

      isLoading=false;

      notifyListeners();
            Fluttertoast.showToast(
        msg: "Internal Server Error or No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );


    }}

    void fetchNotes(){

      


      FirebaseFirestore.instance.collection("notes").where("user_id",isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots().listen((snapshot) {
        List<NoteModel> notesList=[];

        for(var document in snapshot.docs){

          Map<String,dynamic> noteJson=document.data();

          noteJson['id']=document.id;

          notesList.add(NoteModel.fromJson(noteJson)); 







        }

        notes=List.from(notesList);
        
        notifyListeners();



       });
      


      
    }

    Future<void> deleteNote(NoteModel note) async {

      notes!.where((element) => element.id==note.id).first.isLoading=true;

      notes=List.from(notes!);
      notifyListeners();

      

      try {
        await FirebaseFirestore.instance.collection("notes").doc(note.id).delete();
       


      }catch(e){

       

              

  
            Fluttertoast.showToast(
        msg: "Internal Server Error or No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );



      }



    }






  
}