import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tasklyplatform/modelviews/home_model_view.dart';

class HomeView extends StatefulWidget {

  


  @override
  State<StatefulWidget> createState() {
    return HomeViewState();

  }
}

class HomeViewState extends State<HomeView> {


    late double _deviceWidth;

  late double _deviceHeight;
  late double _deviceTopPadding;
  late BuildContext _currentContext;



  @override
  Widget build(BuildContext context) {
        _currentContext=context;

    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    _deviceTopPadding=MediaQuery.of(context).padding.top;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<HomeModelView>())],
    child: Scaffold(
      body: currentPageSelector(),

      bottomNavigationBar: BottomBarSelector()
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

  Selector<HomeModelView,int> BottomBarSelector(){

    return Selector<HomeModelView,int>(selector: (context,provider)=>provider.selectedIndex,
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){


      return BottomNavigationBar(
        onTap: (index){
          GetIt.instance.get<HomeModelView>().changePage(index);


        },
        currentIndex: value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        
        items: [BottomNavigationBarItem(label: "Tasks", icon: Icon(Icons.task,size: _deviceWidth*0.1,)),
        
        BottomNavigationBarItem(label: "Notes", icon: Icon(Icons.note,size: _deviceWidth*0.1,)),

        BottomNavigationBarItem(
          label: "scheduale", icon: Icon(Icons.schedule,size: _deviceWidth*0.1,)),
        BottomNavigationBarItem(label: "setting", icon: Icon(Icons.settings,size: _deviceWidth*0.1,)),

        ]);
    },
    );



    
  }

  Selector<HomeModelView,int> currentPageSelector(){


    return  Selector<HomeModelView,int>(selector: (context,provider)=>provider.selectedIndex,
    shouldRebuild: (previous,next)=>!identical(previous, next),
    builder: (context,value,child){
      return IndexedStack(
        index: value,

        children: GetIt.instance.get<HomeModelView>().pages,


      );


    }


    );
  } 
}