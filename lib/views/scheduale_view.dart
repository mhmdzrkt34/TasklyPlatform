import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasklyplatform/models/TaskModel.dart';

import 'package:tasklyplatform/modelviews/scheduale_model_view.dart';


class SchedualeView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return SchedualeViewState();

  }
}

class SchedualeViewState extends State<SchedualeView>{


  @override
  Widget build(BuildContext context) {
    print("scheduale is rendered");

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<SchedualeModelView>())
    ],
    child: Scaffold(
      body: CalenderSelector()



 
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
  
  Selector<SchedualeModelView,List<TaskModel>?> CalenderSelector(){

    return Selector<SchedualeModelView,List<TaskModel>?>(selector: (context,provider)=>provider.tasks,
    shouldRebuild: (previous,next)=>!identical(previous,next),

    builder: (context,value,child){

      return Calender(value);
      


    },
    );
  }

  Widget Calender(List<TaskModel>? tasks){


    if(tasks==null){
      return Center(child: CircularProgressIndicator(),);
    }

    return SfCalendar(

        view: CalendarView.week,
        
      
        dataSource: MeetingDataSource(tasks.map<Appointment>((item)=>( Appointment(startTime: item.start.toDate(), endTime: item.end.toDate(),subject: item.title,color: item.completed?Colors.green:Colors.red)
        )).toList()

        
        ),


      );
  }
  
}

class MeetingDataSource extends CalendarDataSource {

  MeetingDataSource(List<Appointment> source){

    appointments=source;
  }

}