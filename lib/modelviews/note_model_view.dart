import 'package:flutter/material.dart';
import 'package:tasklyplatform/models/NoteModel.dart';

class NoteModelView extends ChangeNotifier {

  late NoteModel note;


  NoteModelView(){



  }

  void setNote(NoteModel noteObject){
    note=noteObject;
    notifyListeners();
  }
}