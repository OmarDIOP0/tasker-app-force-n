import 'package:flutter/material.dart';
import 'package:tasker/screen/home/home_page.dart';
import 'package:tasker/widget/application_name.dart';

import '../../constantes/colors.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
          child:Column(
            children: [
              SizedBox(
                height: 500,
                child:Image.asset('assets/images/introduction-image.png',
                  height: 500,width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 60,),
              const ApplicationName(),
              const SizedBox(height: 40,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Center(
                      child: RichText(
                          text:const TextSpan(
                              style: TextStyle(
                                  fontSize: 20
                              ),
                              children: <TextSpan>[
                                TextSpan(text: 'Facilitez la gestion de vos'),
                                TextSpan(text: ' taches ',style: TextStyle(color: deepgreenColor,fontWeight: FontWeight.bold)),
                                TextSpan(text: 'du projet')
                              ]
                          )
                      ),
                    ),
                  ]
              ),
              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: lightgreenColor,
                ),
                child: const Padding(
                  padding:EdgeInsets.all(10),
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Commencer ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward,color: Colors.white,size: 30,),
                    ],
                  ),
                ),
              )
            ],
          ) ,
      ) ,
    );
  }
}
