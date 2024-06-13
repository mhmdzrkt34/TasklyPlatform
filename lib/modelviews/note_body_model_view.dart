import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasklyplatform/models/NoteModel.dart';

class NoteBodyModelView extends ChangeNotifier {

  late NoteModel note;


  TextEditingController controller=TextEditingController();

  TextEditingController Titlecontroller=TextEditingController();

   BuildContext? viewContext;




  bool isLoading=false;


  NoteBodyModelView();



  void setNoteField(NoteModel noteObject){

    note=noteObject;

    controller.text=note.note;
    Titlecontroller.text=noteObject.title;



    notifyListeners();


  }

  void changeIsLoadingToTrue(){
    isLoading=true;
    notifyListeners();



  }

  
  void changeIsLoadingToFalse(){
    isLoading=false;
    notifyListeners();



  }

  Future<void> updateNote(String id,String title,String note)async{
    changeIsLoadingToTrue();




    try {
      await FirebaseFirestore.instance.collection("notes").doc(id).update({

        'title':title,
        'note':note
      });



       changeIsLoadingToFalse();
       if(viewContext==null){
        
        

       }
       else {

        Navigator.pop(viewContext!);
       }





    }catch(e){
      changeIsLoadingToFalse();

      Fluttertoast.showToast(
        msg: "Internal server error or no connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );



    }
  }


  void setViewContext(BuildContext? context){
    viewContext=context;



  }



  
}