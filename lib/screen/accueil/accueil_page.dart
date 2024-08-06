import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/screen/detail_task/detail_task.dart';
import 'package:tasker/screen/profile/profile_page.dart';
import 'package:tasker/widget/application_name.dart';
import 'package:tasker/widget/ui_custom_Form.dart';
import 'package:tasker/widget/ui_custom_container.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  TextEditingController search = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedFilter = 'Nom';
  List<Map<String, String>> _tasks = [
    {
      'nom_tache': 'Design du projet',
      'contenu': 'Design du projet',
      'date': '27 Juin 2024',
      'priorite': 'Élevé',
      'couleur': 'red',
    },
    {
      'nom_tache': 'Création projet Flutter',
      'contenu': 'Création projet Flutter',
      'date': '02 Juillet 2024',
      'priorite': 'Faible',
      'couleur': 'green',
    },
    {
      'nom_tache': 'Intégration des interfaces',
      'contenu': 'Intégration des interfaces',
      'date': '17 Juillet 2024',
      'priorite': 'Moyenne',
      'couleur': 'yellow',
    },
  ];

  List<Map<String, String>> _filteredTasks = [];

  @override
  void initState() {
    super.initState();
    _filteredTasks = _tasks;
  }

  void _filterTasks() {
    setState(() {
      if (search.text.isEmpty) {
        _filteredTasks = _tasks;
      } else {
        _filteredTasks = _tasks.where((task) {
          switch (_selectedFilter) {
            case 'Nom':
              return task['nom_tache']!
                  .toLowerCase()
                  .contains(search.text.toLowerCase());
            case 'Date':
              return task['date']!
                  .toLowerCase()
                  .contains(search.text.toLowerCase());
            case 'Priorité':
              return task['priorite']!
                  .toLowerCase()
                  .contains(search.text.toLowerCase());
            default:
              return false;
          }
        }).toList();
      }
    });
  }

  void _navigateToDetail(String nom_tache, String contenu, String date, String priorite, String couleur) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTask(
          nom_tache: nom_tache,
          contenu: contenu,
          date: date,
          priorite: priorite,
          couleur: couleur,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: verylightgreenColor,
    ));

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const ApplicationName(size: 20),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/notification');
          },
              icon: const Icon(Icons.notifications_active_outlined,size: 30,)
          ),
          const SizedBox(width: 10),
        ],
        centerTitle: true,
        backgroundColor: verylightgreenColor,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [verylightgreenColor, Colors.white, verylightgreenColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text('Hello ! '),
                const SizedBox(height: 10),
                const Text('Omar DIOP', style: TextStyle(fontSize: 15)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: search,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search_rounded),
                                  labelText: "Rechercher",
                                  hintText: "Rechercher",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Saisir quelque chose";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _filterTasks();
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            DropdownButton<String>(
                              value: _selectedFilter,
                              items: <String>['Nom', 'Date', 'Priorité']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedFilter = newValue!;
                                  _filterTasks();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'Total :'),
                      TextSpan(
                        text: ' ${_filteredTasks.length}',
                        style: const TextStyle(color: deepgreenColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: _filteredTasks.map((task) {
                    return GestureDetector(
                      onTap: () {
                        _navigateToDetail(
                          task['nom_tache']!,
                          task['contenu']!,
                          task['date']!,
                          task['priorite']!,
                          task['couleur']!,
                        );
                      },
                      child: UICustomContainer(
                        projetName: task['nom_tache']!,
                        niveau: task['priorite']!,
                        color: task['couleur'] == 'red'
                            ? Colors.red
                            : task['couleur'] == 'green'
                            ? lightgreenColor
                            : Colors.yellow,
                        dateTime: task['date']!,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
                topLeft: Radius.circular(0)
            )
        ),
        backgroundColor: verylightgreenColor,
        width: 220,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: deepgreenColor,
              ),
              accountName: Text("Omar DIOP"),
              accountEmail: Text("omardiop@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"), // Remplacez par le chemin de votre image d'avatar
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Mon compte"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("Partager"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Paramètres"),
              onTap: () {

              },
            ),
            const Divider(
              color: deepgreenColor,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Déconnexion"),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
