import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/application_name.dart';
import 'package:tasker/widget/custom_appbar_clipper.dart';
import 'package:tasker/widget/ui_appbar_form.dart';
import 'package:tasker/widget/ui_custom_Form.dart';
import 'package:tasker/widget/ui_custom_password_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:const UIAppbarForm(text: "Rejoignez-nous et simplifiez vos tâches"),
      body: SingleChildScrollView(
          child:Container(
            margin: const EdgeInsets.only(top: 50),
            width: MediaQuery.of(context).size.width*1,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:Form(
                key: _formKey,
                child: Column(

                  children: [
                    UICustomForm(
                      controller: username,
                      nameField:"Nom Utilisateur" ,
                      comment: "Nom utilisateur",
                      icon: const Icon(Icons.person),
                    ),
                    UICustomForm(
                        controller: email,
                        nameField: "Email",
                        comment: "Email",
                        icon: const Icon(Icons.email)
                    ),
                    UICustomPasswordField(
                        controller: password,
                        nameField: "Password",
                        comment: "password"
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(lightgreenColor),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(top:10,right: 70,bottom:10,left: 70)
                          ),
                        ),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            print("User add Successfully");
                          }
                        },
                        child: const Text("Enregistrer",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Vous avez deja un compte ?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                        TextButton(
                            onPressed: (){},
                            child:const Text("Se Connectez",style: TextStyle(fontSize: 15,color: lightgreenColor,fontWeight: FontWeight.bold))
                        )
                      ],
                    )
                  ],
                )
            )
        ),
      ),
    );
  }
}
