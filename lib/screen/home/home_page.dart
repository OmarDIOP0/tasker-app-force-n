import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(80.0),
          child: Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.redAccent,
                Colors.orangeAccent
              ])
            ),
            child: SafeArea(
                child: Center(
                  child: ListTile(
                    title: const Text('Taster'),
                    trailing: IconButton(onPressed:(){}, icon: const Icon(Icons.notifications,size: 20,),
                    color: Colors.white,
                    ),
                  ),
            )),
          )
      ),
      body:const Center( child: Text('Home Page'),),
    );
  }
}
