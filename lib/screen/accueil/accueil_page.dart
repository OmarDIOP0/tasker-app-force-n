import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/screen/detail_task/detail_task.dart';
import 'package:tasker/screen/profile/profile_page.dart';
import 'package:tasker/services/database_helper.dart';
import 'package:tasker/services/task_api.dart';
import 'package:tasker/widget/application_name.dart';
import 'package:tasker/widget/scaffold_message.dart';
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
  late DatabaseHelper _dbHelper;
  List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> _filteredTasks = [];
  bool _isLoading = true;
  late final formatDate;
  Map<String,dynamic>? _userinfo;
  Future<void> _requestPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetTasks();
    fetchProfile();
    _requestPermissions();
    _dbHelper = DatabaseHelper();
  }

  Future<void> fetchProfile() async {
    try {
      final userInfo = await getUserProfile();
      setState(() {
        _userinfo = userInfo;
        _isLoading = false;
      });
    } catch (e) {
      _isLoading = false;
      showSnackBar(context, "Erreur lors de la récupération des informations.", backgroundColor: Colors.redAccent);
    }
  }
  void fetchAndSetTasks() async {
    try{
        List <Map<String,dynamic>> tasks = await fetchTasks();
        setState(() {
            _tasks = tasks;
            _filteredTasks = _tasks;
            _isLoading = false;
        });
    }
    catch(error){
      print("Error lors du listing des taches $error");
      _isLoading =false;
    }
 }
 String formatDueDate(String dateStr){
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yyyy').format(date);
 }
  void _filterTasks() {
    setState(() {
      if (search.text.isEmpty) {
        _filteredTasks = _tasks;
      } else {
        _filteredTasks = _tasks.where((task) {
          switch (_selectedFilter) {
            case 'Nom':
              return task['title']!
                  .toLowerCase()
                  .contains(search.text.toLowerCase());
            case 'Date':
              return task['dueDate']!
                  .toLowerCase()
                  .contains(search.text.toLowerCase());
            case 'Priorité':
              return task['priority']!
                  .toLowerCase()
                  .contains(search.text.toLowerCase());
            default:
              return false;
          }
        }).toList();
      }
    });
  }

  Future<void> _navigateToDetail(int id, String nom_tache, String contenu, String date, String priorite, String couleur) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTask(
          id: id,
          nom_tache: nom_tache,
          contenu: contenu,
          date: date,
          priorite: priorite,
          couleur: couleur,
        ),
      ),
    );

    if (result == true) {
      fetchAndSetTasks();
    }

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
        title: const ApplicationName(size: 15),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/notification');
          },
              icon: const Icon(Icons.notifications_active_outlined,size: 25,)
          ),
          const SizedBox(width: 10),
        ],
        centerTitle: true,
        backgroundColor: verylightgreenColor,
      ),
      body:
      Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [verylightgreenColor, Colors.white, verylightgreenColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _tasks==null
          ? const Center(child:CircularProgressIndicator())
            : SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                  _isLoading
                    ?const Center(child: CircularProgressIndicator())
                    :Row(
                  children: [
                    const Text("Hello ! "),
                    Text("${_userinfo?['prenom']} ${_userinfo?['nom']}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                  ],
                ),
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
                  children:_filteredTasks.map((task) {
                    return GestureDetector(
                      onTap: () {
                        _navigateToDetail(
                          task['id'] ?? 'No Id',
                          task['title'] ?? 'No Title',
                          task['content'] ?? 'No Content',
                          task['dueDate'] ?? 'No Date',
                          task['priority'] ?? 'No Priority',
                          task['color'] ?? 'yellow', // Default color if null
                        );
                      },
                      child: UICustomContainer(
                        projetName: task['title'] ?? 'No Title',
                        niveau: task['priority'] ?? 'No Priority',
                        color: task['color'] == 'red'
                            ? Colors.red
                            : task['color'] == 'green'
                            ? lightgreenColor
                            : Colors.yellow,
                        dateTime: formatDueDate(task['dueDate'] ?? 'No Date') ,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouté une tache",
        elevation: 10,
        onPressed:(){
          Navigator.pushNamed(context, '/add-task');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: deepgreenColor,
              ),
              accountName: _isLoading == true ? const SingleChildScrollView(): Text("${_userinfo?['prenom']} ${_userinfo?['nom']}"),
              accountEmail: _isLoading == true ? const SingleChildScrollView():Text("${_userinfo?['email']}"),
              currentAccountPicture: const CircleAvatar(
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
              onTap: () {
                Share.share("TASKER APPLICATION");
              },
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
                logout();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
