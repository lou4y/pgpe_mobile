
import 'package:flutter/material.dart';
import 'package:pgpe_mobile/Entities/Professeur.dart';

import '../Entities/Matiere.dart';
import '../Services/GroupesService.dart';
import '../Constant_Data/constants.dart';
import '../main.dart';
import '../session/SessionManager.dart';
import 'login.dart';
import 'studentview.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name = "Professeur";
  List<Matiere> matieres = [];
  Future<void> _fetchData() async {
   late int professorId ;

     // Replace with the actual professor ID
    GroupService groupService = GroupService(); // Assuming you have defined the GroupService class
    try {
      Professeur? loggedInProfessor = await SessionManager.getProfessorData();
      if (loggedInProfessor != null) {
        setState(() {
          name =name+" "+loggedInProfessor.nom+" "+loggedInProfessor.prenom;
          professorId = loggedInProfessor.id;
        });
      }
      List<Matiere> fetchedMatiere = await groupService.getAllTodayMatiereWithGroups(professorId);
      setState(() {
        matieres = fetchedMatiere;
        print("worked");
      });
    } catch (e) {
      // Handle error if necessary
      print('Error fetching data: $e');
    }
  }

  @override
  initState()  {
    _fetchData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:  BoxDecoration(
              //color: Color(0xFFD4E7FE),
              gradient: LinearGradient(
                  colors: [
                    kPrimaryColor,
                    kPrimaryLightColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        "Bienvenue,",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
        ),),
        Positioned(
          top: 185,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height - 245,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child:Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

                  child: buildTitleRow("Aujourd'hui", matieres.length),
                ),

                Container(
                  height: MediaQuery.of(context).size.height-315,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: ListView(
                    children: [
                      for (var matiere in matieres)
                        buildTaskListItem(matiere),
                    ],
                  ),
                )
              ],
            )


          ),
        )
      ],
    );
  }


  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "($number)",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
      ],
    );
  }
  GestureDetector buildTaskListItem( Matiere matiere) {
    return GestureDetector(
      onTap: () {
        // Add navigation logic here to redirect to the next page (CalendarPage)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentListPage( matiere: matiere,)),     );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: matiere.debut,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [],
                        ),
                      ),
                      RichText(
                        text:TextSpan(
                          text: matiere.fin,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(right: 10, left: 30),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.subject,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Matiere:",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            matiere.nom,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.group,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const Text(
                            "Groupe:",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            matiere.groupe.nom,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
