import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tasklyplatform/modelviews/register_model_view.dart';

class RegisterView extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {

    return RegisterViewState();

  }
  
}

class RegisterViewState extends State<RegisterView> {
  late double _deviceWidth;

  late double _deviceHeight;
  late double _deviceTopPadding;
  late BuildContext _currentContext;

  final GlobalKey<FormState> _key=GlobalKey<FormState>();

  String name="";

  String password="";

  String email="";

  @override
  Widget build(BuildContext context) {
    _currentContext=context;

    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    _deviceTopPadding=MediaQuery.of(context).padding.top;


    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<RegisterModelView>())],
    child: Scaffold(

      body: SafeArea(child: Container(
        height: _deviceHeight,
        padding: EdgeInsets.only(left: 21,right: 21),
        child: ListView(children: [TitleWidget(),FormWidget(),Container(
          margin: EdgeInsets.only(top: 31),
          child: Column(children: [RegisterButtonSelector(),dontHaveanAccount()],))],))),
     
    ),
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if(!ModalRoute.of(context)!.isCurrent){


    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget TitleWidget(){

    return Container(
      alignment: Alignment.center,
      child: Text("Taskly",style: TextStyle(color: Colors.black,fontSize:_deviceWidth*0.1  ),),);
  }

  Widget FormWidget(){

    return Form(
      
      key: _key,
      child: 
      
      Column(children: [


        Container(
          margin: EdgeInsets.only(top: 31),
          child: TextFormField(decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
    
            
             contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
            label: Text("Name",style: TextStyle(fontSize: _deviceWidth*0.05)),enabledBorder: OutlineInputBorder(

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

          name=value!;
        },

validator: (value) {
  if (value == null || value.isEmpty) {
    return 'The Name field is required';
  } else if (value.length < 3) {
    return 'The Name field must be at least three characters';
  } else if (value.contains(RegExp(r'\d'))) {
    return 'The Name field cannot contain digits';
  }
  return null;
},

        ),),

        
        Container(
          margin: EdgeInsets.only(top: 31),
          child: TextFormField(decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
             contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
            label: Text("Email",style: TextStyle(fontSize: _deviceWidth*0.05),),enabledBorder: OutlineInputBorder(

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

          email=value!;
        },

validator: (value) {
  if (value == null || value.isEmpty) {
    return 'The email field is required';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
},

        ),),

                Container(
                  margin: EdgeInsets.only(top: 31),
                  child: TextFormField(
                    
                    obscureText: true,
                    decoration: InputDecoration(
                                                errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
                    
                     contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 17.0),
                     
                    label: Text(
                      
                      "Password",style: TextStyle(fontSize: _deviceWidth*0.05)),enabledBorder: OutlineInputBorder(

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
          password=value!;
        },

        validator: (value){
          bool result=value!.contains(RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{10,}$'));

          return result?null:"weak password";

          
        },
        ),),





      ],));


  }

  Selector<RegisterModelView,bool> RegisterButtonSelector(){

    return Selector<RegisterModelView,bool>(selector: (context,provider)=>provider.isLoading,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,value,child){

      return RegisterButton(value);



    },
    );
  }

  Widget RegisterButton(bool value){

    return Container(
      width: _deviceWidth,
      child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9),
      
      ),
      onPressed: (){

        if(_key.currentState!.validate()){

          _key.currentState!.save();

                  if(value==false){

                    GetIt.instance.get<RegisterModelView>().registerWithEmailAndPassword(email, password, name,_currentContext);
                    
          


        }


        }


      },
      padding: EdgeInsets.symmetric(vertical: 9,horizontal: 17),
      color: Colors.black,
      textColor: Colors.white,
      
      child: value==false?
      
      Text("Register",style: TextStyle(fontSize: _deviceWidth*0.05),):
      CircularProgressIndicator(color: Colors.white,)
      ),);


  }

  Widget dontHaveanAccount(){

    return Container(
      width: _deviceWidth,
      child: GestureDetector(
        onTap: (){

          Navigator.pushReplacementNamed(_currentContext, "/login");
        },
        child: Text("Already Have An Account",style: TextStyle(fontSize: _deviceWidth*0.04, decoration: TextDecoration.underline,
        decorationThickness: 2.0,
      color: Colors.black),),),);
  }
  
}