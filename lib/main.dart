import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tasklyplatform/firebase_options.dart';
import 'package:tasklyplatform/modelviews/home_model_view.dart';
import 'package:tasklyplatform/modelviews/login_model_view.dart';
import 'package:tasklyplatform/modelviews/note_body_model_view.dart';
import 'package:tasklyplatform/modelviews/note_model_view.dart';
import 'package:tasklyplatform/modelviews/notes_model_view.dart';
import 'package:tasklyplatform/modelviews/register_model_view.dart';
import 'package:tasklyplatform/modelviews/scheduale_model_view.dart';
import 'package:tasklyplatform/modelviews/setting_model_view.dart';
import 'package:tasklyplatform/modelviews/tasks_model_view.dart';
import 'package:tasklyplatform/views/home_view.dart';
import 'package:tasklyplatform/views/login_view.dart';
import 'package:tasklyplatform/views/note_body_view.dart';
import 'package:tasklyplatform/views/note_view.dart';
import 'package:tasklyplatform/views/register_view.dart';

Future<void>  main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);



  GetIt.instance.registerSingleton<LoginModelView>(LoginModelView());
  GetIt.instance.registerSingleton<RegisterModelView>(RegisterModelView());
  GetIt.instance.registerSingleton<HomeModelView>(HomeModelView());

  GetIt.instance.registerSingleton<TasksModelView>(TasksModelView());
  GetIt.instance.registerSingleton<NotesModelView>(NotesModelView());

  GetIt.instance.registerSingleton<SettingModelView>(SettingModelView());
  GetIt.instance.registerSingleton<SchedualeModelView>(SchedualeModelView());

  GetIt.instance.registerSingleton<NoteModelView>(NoteModelView());

  GetIt.instance.registerSingleton<NoteBodyModelView>(NoteBodyModelView());


  


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
@override
  Widget build(BuildContext context) {

    String initial=FirebaseAuth.instance.currentUser!=null?"/Home":"/";
    
    if(FirebaseAuth.instance.currentUser!=null){


      GetIt.instance.get<NotesModelView>().fetchNotes();
      GetIt.instance.get<TasksModelView>().fetchTasks();
    }
    
    


    return MaterialApp(

      title: "TASKLYPLATFORM",
      initialRoute: initial,

      

      routes: {

        "/login":(context)=>LoginView(),
        "/":(context)=>RegisterView(),
        "/Home":(context)=>HomeView(),
        "/note":(context)=>NoteView(),
        "/noteEdit":(context)=>NoteBodyView()
      },
    );

  }
}

