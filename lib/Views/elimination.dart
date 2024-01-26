
import 'package:flutter/material.dart';
import 'package:pgpe_mobile/Views/GroupView.dart';

import '../Entities/Matiere.dart';
import '../Entities/Professeur.dart';
import '../Services/GroupesService.dart';
import '../Constant_Data/constants.dart';
import '../session/SessionManager.dart';
import 'elimination.dart';

class Eliminationpage extends StatefulWidget {
  @override
  _EliminationpageState createState() => _EliminationpageState();
}

class _EliminationpageState extends State<Eliminationpage> {

  List<Matiere> matieres = [];
  Future<void> _fetchData() async {

    late int professorId ; // Replace with the actual professor ID
    GroupService groupService = GroupService(); // Assuming you have defined the GroupService class
    try {
      Professeur? loggedInProfessor = await SessionManager.getProfessorData();
      if (loggedInProfessor != null) {
        setState(() {
          professorId = loggedInProfessor.id;
        });
      }
      List<Matiere> fetchedMatiere = await groupService.getAllMatiereWithGroups(professorId);
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
  void initState() {
    _fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            //color: Color(0xFFD4E7FE),
              gradient: LinearGradient(
                  colors: [
                    kPrimaryColor,
                    Color(0xFFF0F0F0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Eliminations",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),),
        Positioned(
          top: 150,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child:Column(
                children: [
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




  GestureDetector buildTaskListItem( Matiere matiere) {
    return GestureDetector(
      onTap: () {
        // Add navigation logic here to redirect to the next page (CalendarPage)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroupeView( group: matiere.groupe,)),     );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1  ,
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
