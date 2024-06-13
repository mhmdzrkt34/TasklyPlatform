import 'package:flutter/material.dart';
import 'package:tasklyplatform/views/notes_view.dart';
import 'package:tasklyplatform/views/scheduale_view.dart';
import 'package:tasklyplatform/views/setting_view.dart';
import 'package:tasklyplatform/views/tasks_view.dart';

class HomeModelView extends ChangeNotifier {

  int selectedIndex=0;


  List<Widget> pages=[TasksView(),NotesView(),SchedualeView(),SettingView()];



  HomeModelView();

  void changePage(int index){


    selectedIndex=index;
    notifyListeners();
  }
}