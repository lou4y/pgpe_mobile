import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Constant_Data/domaine.dart';
import '../Entities/Etudiant.dart';

class EtudiantsService {
  static List<Map<String, dynamic>> etudiantsListToMap(List<Etudiant> etudiants) {
    List<Map<String, dynamic>> etudiantsMapList = [];
    for (Etudiant etudiant in etudiants) {
      etudiantsMapList.add(etudiant.toMap());
    }
    return etudiantsMapList;
  }
  Future<void> sendEtudiantsData(int matiereId,int groupId, List<Etudiant> etudiantsList) async {

    try {

      var url =
      Uri.http(domaine, '/mobile/apis/etudiants/abcence', {'q': '{http}'});
      final List<Map<String, dynamic>> etudiantsData = etudiantsListToMap(etudiantsList);

      final List<Map<String, dynamic>> requestData = etudiantsData.map((etudiantData) {
        return {
          'id': etudiantData['id'], // Replace 'id' with your Symfony entity property name
          'statut': etudiantData['status'], // Replace 'status' with your Symfony entity property name
        };
      }).toList();

      final Map<String, dynamic> requestBody = {
        'groupId': groupId,
        'matiereId': matiereId,
        'etudiants': requestData,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Request was successful, handle the response if needed
        print('Etudiants data sent successfully.');
      } else {
        // Request failed, handle the error if needed
        print('Failed to send etudiants data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred, handle the error if needed
      print('Error sending etudiants data: $e');
    }
  }

  Future<List<Etudiant>> getEtudiantBygroup_matiere(int groupId,int matiereId) async {
    try {
    var url =
    Uri.http(domaine, '/mobile/apis/etudiants/abcence/${groupId}&${matiereId}', {'q': '{http}'});
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      List<Etudiant> etudiants = [];
      for (var etudiantData in jsonData) {
        Etudiant etudiant = Etudiant(
          id: etudiantData['id'],
          nom: etudiantData['Nom'], // Update to 'Nom' as per the JSON data
          prenom: etudiantData['Prenom'], // Update to 'Prenom' as per the JSON data
          status: etudiantData['status'] == "Present" ?true:false , // Convert 'true' string to boolean
          nbAbsence: 0,
        );
        etudiants.add(etudiant);

      }
      return etudiants;
    } else {
      throw Exception('Failed to load data');
    }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
