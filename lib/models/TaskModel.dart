import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {

  late String id;

   late bool completed;

   late String description;

   late Timestamp end;

   late Timestamp start;

   late String title;

   late String user_id;
   bool isLoadingCompletedEdit=false;


   TaskModel({required this.id,required this.completed,required this.description,required this.end,required this.start,required this.title,required this.user_id});



   static TaskModel fromJson(Map<String,dynamic> jsonData){

    return TaskModel(id: jsonData['id'], completed: jsonData['completed'], description: jsonData['description'], end: jsonData["end"], start: jsonData["start"], title: jsonData["title"],user_id: jsonData['user_id']);


    
   }




}