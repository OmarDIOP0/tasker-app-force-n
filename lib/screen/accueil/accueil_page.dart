import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/application_name.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white
    ));
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(80.0),
          child: Container(
            height: 120,
            decoration: const BoxDecoration(
                color: lightgreenColor
            ),
            child: SafeArea(
              child: ListTile(
                leading: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.menu)
                ),
                title: const ApplicationName(size: 20,),
                trailing: IconButton(onPressed:(){}, icon: const Icon(Icons.notifications,size: 30,color: Colors.black,),
                  color: Colors.white,
                ),
              ),
            ),
          )
      ),
      body:Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:[verylightgreenColor,Colors.white,verylightgreenColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: const SingleChildScrollView(
            child: Center(
              child: Text("Home Page"),
            )
        ),
      ),
    );
  }
}
