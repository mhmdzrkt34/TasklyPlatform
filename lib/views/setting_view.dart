import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tasklyplatform/modelviews/setting_model_view.dart';


class SettingView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return SettingViewState();

  }
}

class SettingViewState extends State<SettingView>{


  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<SettingModelView>())
    ],
    child: Scaffold(
    
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
}