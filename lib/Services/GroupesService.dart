import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:pgpe_mobile/Entities/Etudiant.dart';
import 'package:pgpe_mobile/Entities/Groupe.dart';
import 'package:pgpe_mobile/Entities/Matiere.dart';

import '../Constant_Data/domaine.dart';

class GroupService {

  Future<List<Matiere>> getAllTodayMatiereWithGroups(int professorId) async {
    try {
    var url =
    Uri.http(domaine, 'mobile/apis/groups/${professorId}', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
      if (response.statusCode == 200) {

        final jsonData = json.decode(response.body) as List<dynamic>;
        List<Matiere> matieres = [];

        for (var matiereData in jsonData) {
          Matiere matiere = Matiere(
            id: matiereData['id'],
            nom: matiereData['Nom'],
            jour: matiereData['jour'],
            debut: matiereData['debut'],
            fin: matiereData['fin'],
            groupe: _parseGroupe(matiereData['groupe'][0]), // Update to 'groupe'
          );
          matieres.add(matiere);
        }

        return matieres;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  Future<List<Matiere>> getAllMatiereWithGroups(int professorId) async {
    try {
    var url =
    Uri.http(domaine, 'mobile/apis/groups/all/${professorId}', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body) as List<dynamic>;
      List<Matiere> matieres = [];
      for (var matiereData in jsonData) {
        Matiere matiere = Matiere(
          id: matiereData['id'],
          nom: matiereData['Nom'],
          jour: matiereData['jour'],
          debut: matiereData['debut'],
          fin: matiereData['fin'],
          groupe: _parseGroupe(matiereData['groupe'][0]), // Update to 'groupe'
        );
        matieres.add(matiere);
      }

      return matieres;
    } else {
      throw Exception('Failed to load data');
    }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Groupe _parseGroupe(dynamic groupeData) {
    Groupe groupe = Groupe(
      id: groupeData['id'],
      nom: groupeData['Nom'], // Update to 'Nom' as per the JSON data
      etudiants: _parseEtudiants(groupeData['etudiants']), // Update to 'etudiants'
    );
    return groupe;
  }

  List<Etudiant> _parseEtudiants(List<dynamic> etudiantsData) {
    List<Etudiant> etudiants = [];
    for (var etudiantData in etudiantsData) {
      Etudiant etudiant = Etudiant(
        id: etudiantData['id'],
        nom: etudiantData['Nom'],
        prenom: etudiantData['Prenom'], // Update to 'Prenom' as per the JSON data
        status: etudiantData['status'] == "Elimine", // Convert 'true' string to boolean
        nbAbsence: etudiantData['nbAbsence'],
      );
      etudiants.add(etudiant);
    }
    return etudiants;
  }
}
