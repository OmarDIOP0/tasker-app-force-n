import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/widget/application_name.dart';

import '../../constantes/colors.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor:Colors.white,
        systemNavigationBarColor: Colors.white
    ));
    return Scaffold(
      body:Column(
            children: [
              SizedBox(
                height: 400,
                child:Image.asset('assets/images/introduction-image.png',
                  height: 400,width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30,),
              const ApplicationName(size: 25,),
              const SizedBox(height: 30,),
              Wrap(
                  children:[
                    Center(
                      child: RichText(
                          text:const TextSpan(
                              style: TextStyle(
                                  fontSize: 12,
                                color:Colors.black
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
              const SizedBox(height: 100),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  primary: lightgreenColor,
                ),
                child: const Padding(
                  padding:EdgeInsets.all(10),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Commencer ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward,color: Colors.white,size: 30,),
                        ],
                      ),
                    ],
                  )

                ),
              )
            ],
          ) ,
    );
  }
}
