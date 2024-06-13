import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tasklyplatform/models/NoteModel.dart';
import 'package:tasklyplatform/modelviews/note_body_model_view.dart';
import 'package:tasklyplatform/modelviews/note_model_view.dart';
import 'package:tasklyplatform/modelviews/notes_model_view.dart';
import 'package:tasklyplatform/views/note_body_view.dart';

class NotesView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return NotesViewState();

  }
}

class NotesViewState extends State<NotesView>{
    late double _deviceWidth;

  late double _deviceHeight;

  late double _deviceTopPadding;

  late BuildContext _currentContext;
      final GlobalKey<FormState> _key=GlobalKey<FormState>();

  String title="";

  String note="";
  final TextEditingController Titlecontroller=TextEditingController();
  final TextEditingController Notecontroller=TextEditingController();



  @override
  Widget build(BuildContext context) {
    
      _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceTopPadding=MediaQuery.of(context).padding.top;

    _currentContext=context;




    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<NotesModelView>())
    ],
    child: Scaffold(

      body: SafeArea(child: Stack(children: [

        Container(
          padding: EdgeInsets.all(20),
          child: notesSelector()
        ),
        noteAddZoneSelector()

      
      ],)),

      floatingActionButton:floatingActionButtonSelector() ,
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

  Selector<NotesModelView,bool> floatingActionButtonSelector(){

    return  Selector<NotesModelView,bool>(selector: (context,provider)=>provider.noteAddVisible,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),
    
    builder: (context,value,child){

      return Visibility(
        visible: !value,
        child: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: (){
          GetIt.instance.get<NotesModelView>().makeNotAddVisible();

      }));



    },
    );
  }

  Selector<NotesModelView,bool> noteAddZoneSelector(){


    return Selector<NotesModelView,bool>(selector: (context,provider)=>provider.noteAddVisible,
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
          onTap: (){ GetIt.instance.get<NotesModelView>().makeNotAddInVisible();},
          child:   Container(
            
            alignment: Alignment.centerLeft,
            width: _deviceWidth,
          
            child: Icon(Icons.minimize_outlined,
            size: _deviceWidth*0.1,),),),
            FormWidget(),
            AddNoteButtonSelector()
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
            controller: Titlecontroller,
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
                    controller: Notecontroller,
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
          note=value!;
        },

        validator: (value){
          bool result=value==null || value.trim().isEmpty?false:true;

          return result?null:"required field";

          
        },
        ),),





      ],));


  }

    Selector<NotesModelView,bool> AddNoteButtonSelector(){

    return Selector<NotesModelView,bool>(selector: (context,provider)=>provider.isLoading,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,value,child){

      return AddNoteButton(value);



    },
    );
  }

  Widget AddNoteButton(bool value){

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

                    GetIt.instance.get<NotesModelView>().addNote(title, note, Titlecontroller, Notecontroller);

                    

                  
                    
          


        }


        }


      },
      padding: EdgeInsets.symmetric(vertical: 9,horizontal: 17),
      color: Colors.black,
      textColor: Colors.white,
      
      child: value==false?
      
      Text("Add Note",style: TextStyle(fontSize: _deviceWidth*0.05),):
      CircularProgressIndicator(color: Colors.white,)
      ),);


  }

  Widget NoteComponent(NoteModel note){

    return             Container(
              
          
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(child: Text( note.title,style: TextStyle(fontSize: _deviceWidth*0.06),)),Row(children: [deleteIcon(note),GestureDetector(
                  
                  onTap: (){
                    GetIt.instance.get<NoteBodyModelView>().setNoteField(note);
                    Navigator.pushNamed(_currentContext, "/noteEdit");
                  },
                  child: Icon(Icons.edit,color: Colors.black,size: _deviceWidth*0.08,),),GestureDetector(
                  onTap: (){

                    GetIt.instance.get<NoteModelView>().setNote(note);



                    Navigator.pushNamed(context, "/note");
                  },
                  child: Icon(Icons.visibility,color: Colors.blue,size: _deviceWidth*0.08,),)],)],),
          
            );
  }

  Selector<NotesModelView,List<NoteModel>?> notesSelector(){

    return Selector<NotesModelView,List<NoteModel>?>(selector: (context,provider)=>provider.notes,
    shouldRebuild: (previous,next)=>!identical(previous, next),
    builder: (context,value,child){

      return Notes(value);


    },


    );
  }

  Widget Notes(List<NoteModel>? notes){


    if(notes==null){
      return Center(child: CircularProgressIndicator(),);
    }

    return ListView.builder(itemCount: notes.length, itemBuilder: (BuildContext context,int index){


      return NoteComponent(notes[index]);
    });


  }

  Widget deleteIcon(NoteModel note){



    if(note.isLoading==false){

      return  
      
      GestureDetector(onTap: (){
        GetIt.instance.get<NotesModelView>().deleteNote(note);

      },child:Icon(Icons.delete,color: Colors.red,size: _deviceWidth*0.08,) );
      
    }

    return CircularProgressIndicator(color: Colors.red,);



  
  

  

}}