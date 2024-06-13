import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:tasklyplatform/models/TaskModel.dart';
import 'package:tasklyplatform/modelviews/scheduale_model_view.dart';

class TasksModelView extends ChangeNotifier {

  bool taskAddVisible=false;


    bool isLoading=false;
  List<TaskModel>? tasks;

  TasksModelView();



  void makeTaskAddVisible(){

    taskAddVisible=true;
    notifyListeners();
  }

  void makeTaskAddNotVisible(){

    taskAddVisible=false;
    notifyListeners();
  }

    Future<void> addTask(TextEditingController titleController,TextEditingController taskController,TextEditingController startDateController,TextEditingController endDateController) async{

    isLoading=true;
    notifyListeners();


    try {
    

      await FirebaseFirestore.instance.collection("tasks").add({

        "title":titleController.text,
        "description":taskController.text,
        "start":DateTime.parse(startDateController.text),
        "end":DateTime.parse(endDateController.text),
        "user_id":FirebaseAuth.instance.currentUser!.uid,
        "completed":false
      });

      titleController.clear();

      taskController.clear();
      startDateController.clear();
      endDateController.clear();







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


        void fetchTasks(){

      


      FirebaseFirestore.instance.collection("tasks").where("user_id",isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots().listen((snapshot) {
        List<TaskModel> tasksList=[];

        for(var document in snapshot.docs){

          Map<String,dynamic> taskJson=document.data();

          taskJson['id']=document.id;

          tasksList.add(TaskModel.fromJson(taskJson)); 







        }

        tasks=List.from(tasksList);
        GetIt.instance.get<SchedualeModelView>().fetchTasks(tasksList);
  
        notifyListeners();



       });
      


      
    }

    Future<void> updateTaskStatus(TaskModel task,String status) async{

      tasks!.where((element) => element.id==task.id).first.isLoadingCompletedEdit=true;

      tasks=List.from(tasks!);

      notifyListeners();

      try {

        await FirebaseFirestore.instance.collection("tasks").doc(task.id).update({

          "completed":status=="completed"?true:false




        });


           tasks!.where((element) => element.id==task.id).first.isLoadingCompletedEdit=false;
         tasks=List.from(tasks!);

         notifyListeners();



      }catch(e){
        tasks!.where((element) => element.id==task.id).first.isLoadingCompletedEdit=false;
         tasks=List.from(tasks!);

      notifyListeners();
                  Fluttertoast.showToast(
        msg: "Internal Server Error or No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );



      }




    }

      void returnToInitialState(){

taskAddVisible=false;
    isLoading=false;
    notifyListeners();
  }


}