import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tasklyplatform/models/NoteModel.dart';
import 'package:tasklyplatform/modelviews/note_body_model_view.dart';

class NoteBodyView extends StatefulWidget {

  


  @override
  State<StatefulWidget> createState() {

       
    

    return NoteBodyViewState();

  }
}


class NoteBodyViewState extends State<NoteBodyView> {

  late double _deviceWidth;
  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  late BuildContext _curentContext;

  String noteBody="";

  String noteTitle="";




  @override
  Widget build(BuildContext context) {
    GetIt.instance.get<NoteBodyModelView>().setViewContext(context);
 
    _curentContext=context;

    _deviceWidth=MediaQuery.of(context).size.width;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<NoteBodyModelView>())],
    
    child: Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: SingleChildScrollView(child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
        
        FormWidget(),
        UpdateButtonSelector()
        
            ],),
      ),)),),
    );

    


    
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    GetIt.instance.get<NoteBodyModelView>().setViewContext(null);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if(!ModalRoute.of(context)!.isCurrent){


    }
    super.didChangeDependencies();
  }

  Selector<NoteBodyModelView,NoteModel> bodyTextFieldSelector(){

    return Selector<NoteBodyModelView,NoteModel>(selector: (context,provider)=>provider.note,
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){

      return       Container(
          margin: EdgeInsets.only(top: 31),
          child: TextFormField(
            
            controller: GetIt.instance.get<NoteBodyModelView>().controller,
             maxLines: null,
            decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
             contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
            label: Text("note",style: TextStyle(fontSize: _deviceWidth*0.05),),enabledBorder: OutlineInputBorder(

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

          noteBody=value!;
        },

validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'required field';
  } 
  return null;
},

        ),);

    },
    );
  }

   Widget FormWidget(){

    return Form(
      
      key: _key,
      child: 
      
      Column(children: [
            TitleTextFieldSelector(),
        bodyTextFieldSelector(),
    

                
  
      ]));}


        Selector<NoteBodyModelView,NoteModel> TitleTextFieldSelector(){

    return Selector<NoteBodyModelView,NoteModel>(selector: (context,provider)=>provider.note,
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){

      return       Container(
          margin: EdgeInsets.only(top: 31),
          child: TextFormField(
            
            controller: GetIt.instance.get<NoteBodyModelView>().Titlecontroller,
             maxLines: null,
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

          noteTitle=value!;
        },

validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'required field';
  } 
  return null;
},

        ),);

    },
    );
  }


    Selector<NoteBodyModelView,bool>UpdateButtonSelector(){

    return Selector<NoteBodyModelView,bool>(selector: (context,provider)=>provider.isLoading,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,value,child){

      return UpdateButton(value);



    },
    );
  }

  Widget UpdateButton(bool value){

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
                    GetIt.instance.get<NoteBodyModelView>().updateNote(GetIt.instance.get<NoteBodyModelView>().note.id, noteTitle, noteBody);

                   

                  
                    
          


        }


        }


      },
      padding: EdgeInsets.symmetric(vertical: 9,horizontal: 17),
      color: Colors.black,
      textColor: Colors.white,
      
      child: value==false?
      
      Text("Update",style: TextStyle(fontSize: _deviceWidth*0.05),):
      CircularProgressIndicator(color: Colors.white,)
      ),);


  }


  


}