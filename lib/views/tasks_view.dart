import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasklyplatform/models/TaskModel.dart';
import 'package:tasklyplatform/modelviews/tasks_model_view.dart';

class TasksView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return TasksViewState();

  }
}

class TasksViewState extends State<TasksView>{

  late double _deviceWidth;

  late double _deviceHeight;

  late double _deviceTopPadding;

  late BuildContext _currentContext;

  final TextEditingController titleController=TextEditingController();

  final TextEditingController taskController=TextEditingController();
    final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String title="";

  String task="";


  final GlobalKey<FormState> _key=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceTopPadding=MediaQuery.of(context).padding.top;

    _currentContext=context;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<TasksModelView>())
    ],
    child: Scaffold(

      body: SafeArea(child: Container(
       

        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(children: [

          tasksSelector(),
          
          
        
        
        
        
        
          
        
           
        
          taskAddZoneSelector()
        
        ],),
      )),

      floatingActionButton: floatingActionButtonSelector(),
    ),
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!ModalRoute.of(context)!.isCurrent){


    }
    super.didChangeDependencies();
  }


  
  Selector<TasksModelView,bool> floatingActionButtonSelector(){

    return  Selector<TasksModelView,bool>(selector: (context,provider)=>provider.taskAddVisible,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),
    
    builder: (context,value,child){

      return Visibility(
        visible: !value,
        child: FloatingActionButton(
          heroTag: "tag1",
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: (){
          GetIt.instance.get<TasksModelView>().makeTaskAddVisible();

      }));



    },
    );
  }
  Selector<TasksModelView,bool> taskAddZoneSelector(){


    return Selector<TasksModelView,bool>(selector: (context,provider)=>provider.taskAddVisible,
    shouldRebuild: (previous,next)=>!identical(previous, next),
    builder: (context,value,child){

      return  Visibility(
        visible: value,
        child:   Positioned(left: 0,right: 0,bottom: 0,top: 0, child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),

         child: ListView(
         
          children: [

        GestureDetector(
          onTap: (){ GetIt.instance.get<TasksModelView>().makeTaskAddNotVisible();},
          child:   Container(
            
            alignment: Alignment.centerLeft,
            width: _deviceWidth,
          
            child: Icon(Icons.minimize_outlined,
            size: _deviceWidth*0.1,),),),
            FormWidget(),
            AddTaskButtonSelector()
         ],),
          
        )));


    },
    );
  }

    Widget FormWidget(){

    return Form(
      
      key: _key,
      child: 
      
      Column(children: [




        
        Container(
          margin: EdgeInsets.only(top: 31),
          child: TextFormField(
            controller: titleController,
            decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
             contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
            label: Text("Title",style: TextStyle(fontSize: _deviceWidth*0.05),),enabledBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.black,
                  width: 1.0,
                  
                  
                  ),
         
                  
                ),
                     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2.0)),
                                               labelStyle: TextStyle(
            color: Colors.black, // Change label color
            fontSize: _deviceWidth*0.06,
          
          ),
                
                ),
                cursorColor: Colors.black,
        
        onSaved: (value){

          title=value!;
        },

validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'required field';
  } 
  return null;
},

        ),),

                Container(
                  margin: EdgeInsets.only(top: 31),
                  child: TextFormField(
                    controller: taskController,
                    maxLines: null,
                    
                   
                    decoration: InputDecoration(
                                                errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
                    
                     contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
                     
                    label: Text(
                      
                      "Note",style: TextStyle(fontSize: _deviceWidth*0.05)),enabledBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.black,
                  width: 1.0),
                  
         
                  
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2.0)),
                
                          labelStyle: TextStyle(
            color: Colors.black, // Change label color
            fontSize: _deviceWidth*0.06,
          
          ),
                ),
                cursorColor: Colors.black,
        
        onSaved: (value){
          task=value!;
        },

        validator: (value){
          bool result=value==null || value.trim().isEmpty?false:true;

          return result?null:"required field";

          
        },
        ),),
                        Container(
                  margin: EdgeInsets.only(top: 31),
                  child: TextFormField(
                    controller: _startDateController,
                    readOnly: true,
                    onTap: (){
                      _selectDateTime(_currentContext, _startDateController);
                    },
                    
                   
                    decoration: InputDecoration(

                      
                                                errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
                    
                     contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
                     
                    label: Text(
                      
                      "Start Date and Time",style: TextStyle(fontSize: _deviceWidth*0.05)),enabledBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.black,
                  width: 1.0),
                  
         
                  
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2.0)),
                
                          labelStyle: TextStyle(
            color: Colors.black, // Change label color
            fontSize: _deviceWidth*0.06,
          
          ),
                ),
                cursorColor: Colors.black,
        
        onSaved: (value){
          task=value!;
        },

        validator: (value){
                 if (value == null || value.isEmpty) {
                    return 'Please enter start date and time';
                  }
                  return null;

          
        },
        ),),

                                Container(
                  margin: EdgeInsets.only(top: 31),
                  child: TextFormField(
                    controller: _endDateController,
                    readOnly: true,
                    onTap: (){
                      _selectDateTime(_currentContext, _endDateController);
                    },
                    
                   
                    decoration: InputDecoration(

                      
                                                errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
                    
                     contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
                     
                    label: Text(
                      
                      "End Date and Time",style: TextStyle(fontSize: _deviceWidth*0.05)),enabledBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.black,
                  width: 1.0),
                  
         
                  
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2.0)),
                
                          labelStyle: TextStyle(
            color: Colors.black, // Change label color
            fontSize: _deviceWidth*0.06,
          
          ),
                ),
                cursorColor: Colors.black,
        
        onSaved: (value){
          task=value!;
        },

        validator: (value){
                 if (value == null || value.isEmpty) {
                    return 'Please enter end date and time';
                  }
                  return null;

          
        },
        ),)





      ],));


  }

    Selector<TasksModelView,bool> AddTaskButtonSelector(){

    return Selector<TasksModelView,bool>(selector: (context,provider)=>provider.isLoading,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,value,child){

      return AddTaskButton(value);



    },
    );
  }

  Widget AddTaskButton(bool value){

    return Container(
      margin: EdgeInsets.only(top: 31),
      width: _deviceWidth,
      child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9),
      
      ),
      onPressed: (){

        if(_key.currentState!.validate()){

          _key.currentState!.save();

                  if(value==false){
                    GetIt.instance.get<TasksModelView>().addTask(titleController, taskController, _startDateController, _endDateController);

                    
                    

                  
                    
          


        }


        }


      },
      padding: EdgeInsets.symmetric(vertical: 9,horizontal: 17),
      color: Colors.black,
      textColor: Colors.white,
      
      child: value==false?
      
      Text("Add Task",style: TextStyle(fontSize: _deviceWidth*0.05),):
      CircularProgressIndicator(color: Colors.white,)
      ),);


  }
  Future<void> _selectDateTime(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
            pickedTime.hour, pickedTime.minute);
        controller.text = finalDateTime.toString();
      }
    }}

    Selector<TasksModelView,List<TaskModel>?> tasksSelector(){


      return Selector<TasksModelView,List<TaskModel>?>(selector: (context,provider)=>provider.tasks,
      
      shouldRebuild: (previous,next)=>!identical(previous, next),

      builder: (context,value,child){

        if(value==null){


          return Center(child: CircularProgressIndicator(),);
        }

        return Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(itemCount: value.length, itemBuilder: (BuildContext context,int index){
          
          
            return TaskComponent(value[index]);
          }),
        );



      },
      );
    }

    Widget TaskComponent(TaskModel task){

      return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)), width: _deviceWidth,
    
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
              Container(
                  
                    child: Text("Title:"+task.title,style: TextStyle(fontSize: _deviceWidth*0.06),)),
              
              Container(child: Text("Start time:${formatDateTime(task.start.toDate())}",style: TextStyle(fontSize: _deviceWidth*0.06))),
              Container(child: Text("End time:${formatDateTime(task.start.toDate())}",style: TextStyle(fontSize: _deviceWidth*0.06))),
              
                 DropdownButtonHideUnderline(child:        DropdownButton<String>(
                          isExpanded: true,

                          
                          
                value: task.completed? "completed":"uncompleted",
                hint: task.isLoadingCompletedEdit?Center(child: CircularProgressIndicator(color: Colors.black,),):Text(task.completed? "completed":"uncompleted",),
                items: [DropdownMenuItem( 
                  
                  onTap: (){
                  GetIt.instance.get<TasksModelView>().updateTaskStatus(task, "completed");
              
              
                }, value: "completed", child: Container(
                  
                  
                  child: Container(
                   
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.green,
                    
                    child:Center(child:  Text( "completed",style: TextStyle(color: Colors.white, fontSize: _deviceWidth*0.04)))))),
              
              DropdownMenuItem( onTap: (){
              
                 GetIt.instance.get<TasksModelView>().updateTaskStatus(task, "uncompleted");
              
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
String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
}

}