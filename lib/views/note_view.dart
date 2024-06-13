import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tasklyplatform/models/NoteModel.dart';
import 'package:tasklyplatform/modelviews/note_model_view.dart';

class NoteView extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {

    return NoteViewState();

  }
}


class NoteViewState extends State<NoteView> {

  late double _deviceWidth;


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<NoteModelView>())],
    
    child: Scaffold(appBar: AppBar(),
    
    body: SafeArea(child: Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(child:NoteBodySelector() ,))),
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

  Selector<NoteModelView,NoteModel> NoteBodySelector(){

    return Selector<NoteModelView,NoteModel>(selector: (context,provider)=>provider.note,
    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,value,child){

      return Container(child: Text(value.note,style: TextStyle(fontSize:_deviceWidth*0.06 ),),);



    },
    );
  }
}