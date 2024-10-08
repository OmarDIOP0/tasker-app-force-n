import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/task_api.dart';
import 'package:tasker/widget/scaffold_message.dart';
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
  
  TextEditingController username = TextEditingController();
  TextEditingController password  = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor:lightgreenColor,
        systemNavigationBarColor: Colors.white
    ));
    return Scaffold(
      appBar: const UIAppbarForm(text: "Connectez-vous pour acceder à vos taches"),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top:10),
          width: MediaQuery.of(context).size.width*1,
          decoration: const BoxDecoration(
            color:Colors.white
          ),
          child: Form(
            key: _keyForm,
              child: Column(
                children: [
                  UICustomForm(
                      controller: username,
                      nameField: "Username",
                      comment: "username",
                      icon: const Icon(Icons.account_circle)
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
                          login(context, username.text, password.text);
                        }
                        else{
                          showSnackBar(context, "Erreur lors de la validation du formulaire",backgroundColor: Colors.red);
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
                            Navigator.pushNamed(context, '/register');
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
