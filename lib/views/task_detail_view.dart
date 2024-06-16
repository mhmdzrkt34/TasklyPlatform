import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:tasklyplatform/models/TaskModel.dart';
import 'package:tasklyplatform/modelviews/tasks_model_view.dart';

class TaskDetailView extends StatefulWidget {

  late TaskModel task;

  


  TaskDetailView({required this.task});

  @override
  State<StatefulWidget> createState() {


    return TaskDetailViewState(task: task);
  }



  
}


class TaskDetailViewState extends State<TaskDetailView> {
  
  late TaskModel task;

  late double _deviceWidth;


  TaskDetailViewState({required this.task});

  


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body:SafeArea(child: SingleChildScrollView(child: Container(
        padding: EdgeInsets.all(7),
        child: TaskComponent(task))))) ;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if(!ModalRoute.of(context)!.isCurrent){


    }
    super.didChangeDependencies();
  }

  
    Widget TaskComponent(TaskModel task){

      return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(20),
    width: _deviceWidth,
    
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
              Container(
                  
                    child: Text("Title:"+task.title,style: TextStyle(fontSize: _deviceWidth*0.06),)),
              
              Container(child: Text("Start time:${formatDateTime( task.start.toDate())}",style: TextStyle(fontSize: _deviceWidth*0.06))),
              Container(child: Text("End time:${formatDateTime( task.end.toDate())}",style: TextStyle(fontSize: _deviceWidth*0.06))),
              
                 DropdownButtonHideUnderline(child:        DropdownButton<String>(
                          isExpanded: true,

                          
                          
                value: task.completed? "completed":"uncompleted",
                hint: task.isLoadingCompletedEdit?Center(child: CircularProgressIndicator(color: Colors.black,),):Text(task.completed? "completed":"uncompleted",),
                items: [DropdownMenuItem( 
                  
                  onTap: (){
                 
                updateTask(task,"completed");
              
              
                }, value: "completed", child: Container(
                  
                  
                  child: Container(
                   
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.green,
                    
                    child:Center(child:  Text( "completed",style: TextStyle(color: Colors.white, fontSize: _deviceWidth*0.04)))))),
              
              DropdownMenuItem( onTap: (){
              
                updateTask(task,"uncompleted");
              
              }, value: "uncompleted", child: Container(
                color: Colors.red,
                 height: double.infinity,
              width: double.infinity,
               child: Center(child:Text("uncompleted",style: TextStyle(color: Colors.white, fontSize: _deviceWidth*0.04))) ))
              ], onChanged: (value){
              
              }))
              ]
              ),
              
    
              
            );
          


    }


    Future<void> updateTask(TaskModel task,String status) async {

      setState(() {

        task.isLoadingCompletedEdit=true;
        
      });

            try {

        await FirebaseFirestore.instance.collection("tasks").doc(task.id).update({

          "completed":status=="completed"?true:false




        });

             setState(() {
              task.completed=status=="completed"?true:false;

        task.isLoadingCompletedEdit=false;
        
      });



 


      }catch(e){
             setState(() {

        task.isLoadingCompletedEdit=false;
        
      });
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
String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
}