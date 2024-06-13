import 'package:flutter/material.dart';
import 'package:tasklyplatform/models/TaskModel.dart';

class SchedualeModelView extends ChangeNotifier {

  List<TaskModel>? tasks;





  SchedualeModelView();


  void fetchTasks(List<TaskModel> tasksList){

    tasks = List.from(tasksList);

    notifyListeners();
  }
}