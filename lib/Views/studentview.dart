import 'package:flutter/material.dart';
import 'package:pgpe_mobile/Entities/Etudiant.dart';
import 'package:pgpe_mobile/Entities/Groupe.dart';
import 'package:pgpe_mobile/Entities/Matiere.dart';

import '../Services/EtudiantsService.dart';
import '../Services/GroupesService.dart';
import '../Constant_Data/constants.dart';

class StudentListPage extends StatefulWidget {
  final Matiere matiere;

  StudentListPage({required this.matiere});
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Etudiant> etudiants = [];
  Future<void> _fetchData() async {
    EtudiantsService etudiantsService = EtudiantsService();
    try {
      List<Etudiant> fetchedEtudiant = await etudiantsService.getEtudiantBygroup_matiere(widget.matiere.groupe.id, widget.matiere.id);
      setState(() {
        etudiants = fetchedEtudiant;
        print("worked student");
      });
    } catch (e) {
      // Handle error if necessary
      print('Error fetching data: $e');
    }
    setState(() {
      etudiants = etudiants;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Colors.transparent, // Set the color to transparent
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            onPrimary: Colors.white,
            fixedSize: Size(300, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {
                        EtudiantsService etudiantsService = EtudiantsService();
                        etudiantsService.sendEtudiantsData(widget.matiere.id,widget.matiere.groupe.id, etudiants  );
            Navigator.pop(context);
                        },
          child: Text('Sauegarder'),
        ),
      ),
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
                          widget.matiere.groupe.nom,
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: etudiants.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                etudiants[index].status = !etudiants[index].status;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              padding: EdgeInsets.all(10),
                              height: 80,
                              decoration: BoxDecoration(
                                color: etudiants[index].status ? const Color(0xFFA2C579) : const Color(0xFFED2939),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 190,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${etudiants[index].nom} ${etudiants[index].prenom} ',
                                              softWrap: false,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: SizedBox(
                                        width: 75,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: etudiants[index].status ? const Color(0xFFCECE5A) : const Color(0xFFED2939),
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${etudiants[index].status ? "Present" : "Absent"}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.black, fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ),
          )
        ],
      ));
  }
}
