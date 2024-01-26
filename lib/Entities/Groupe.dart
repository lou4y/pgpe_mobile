import 'Etudiant.dart';

class Groupe {
  int _id;
  String _nom;
  List<Etudiant> _etudiants;

  Groupe({
    required int id,
    required String nom,
    required List<Etudiant> etudiants,
  })  : _id = id,
        _nom = nom,
        _etudiants = etudiants;

  // Getters
  int get id => _id;
  String get nom => _nom;
  List<Etudiant> get etudiants => _etudiants;

  // Setters
  set id(int newId) => _id = newId;
  set nom(String newNom) => _nom = newNom;
  set etudiants(List<Etudiant> newEtudiants) => _etudiants = newEtudiants;
  // Methods
  void addEtudiant(Etudiant etudiant) {
    _etudiants.add(etudiant);
  }
}
