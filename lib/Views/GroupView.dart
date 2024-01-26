
import 'package:flutter/material.dart';
import 'package:pgpe_mobile/Entities/Groupe.dart';
import 'package:pgpe_mobile/Views/GroupView.dart';

import '../Entities/Etudiant.dart';
import '../Entities/Matiere.dart';
import '../Services/GroupesService.dart';
import '../Constant_Data/constants.dart';
import 'elimination.dart';

class GroupeView extends StatefulWidget {
  final Groupe group;
  GroupeView({required this.group});
  @override
  _GroupeViewState createState() => _GroupeViewState();
}

class _GroupeViewState extends State<GroupeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
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
                        children: [
                          Text(
                            widget.group.nom,
                            style: const TextStyle(
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
                      SizedBox(
                        width: 40,
                      )
                    ],
                  )

                ),),
             Positioned(
               top: 150,
               child: Container(
                   padding:const EdgeInsets.symmetric(horizontal: 10),
                   height: MediaQuery.of(context).size.height - 100,
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(30),
                   ),
                   child:Column(
                     children: [
                       Container(
                         height: MediaQuery.of(context).size.height-150,
                         padding: const EdgeInsets.symmetric(vertical: 0),
                         child: ListView(
                           children: [
                             for (var etudiant in widget.group.etudiants)
                               buildTaskListItem(etudiant),
                           ],
                         ),
                       )
                     ],
                   )
               ),
             )
           ],
        ));

  }
  Container buildTaskListItem(Etudiant etudiant) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 185,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(right: 10, left: 30),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                        Icons.person,
                        size: 20),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nom et Prenom :",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${etudiant.nom} ${etudiant.prenom}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nombre d'absences :",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${etudiant.nbAbsence} absences",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )

                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [      Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: etudiant.status ? Colors.red:Colors.green,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            etudiant.status ? "Elimine" : "Non Elimine",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
