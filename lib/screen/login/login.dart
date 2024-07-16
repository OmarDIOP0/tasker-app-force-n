import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/screen/register/register.dart';
import 'package:tasker/widget/ui_appbar_form.dart';
import 'package:tasker/widget/ui_custom_Form.dart';
import 'package:tasker/widget/ui_custom_password_field.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyForm =  GlobalKey<FormState>();
  
  TextEditingController email = TextEditingController();
  TextEditingController password  = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UIAppbarForm(text: "Connectez-vous pour acceder à vos taches"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:10),
          width: MediaQuery.of(context).size.width*1,
          decoration: BoxDecoration(
            color:Colors.white
          ),
          child: Form(
            key: _keyForm,
              child: Column(
                children: [
                  UICustomForm(
                      controller: email,
                      nameField: "Email",
                      comment: "email",
                      icon: const Icon(Icons.email)
                  ),
                  const SizedBox(height: 10),
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
                            const EdgeInsets.only(top:5,right: 50,bottom:5,left: 50)
                        ),
                      ),
                      onPressed: (){
                        if(_keyForm.currentState!.validate()){
                          print("User login Successfully");
                        }
                      },
                      child: const Text("Enregistrer",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Vous n'avez pas de compte ?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)
                            =>const RegisterPage()));
                          },
                          child:const Text("S'Authentifier",style: TextStyle(fontSize: 15,color: lightgreenColor,fontWeight: FontWeight.bold))
                      )
                    ],
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
