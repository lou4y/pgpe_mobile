import 'package:pgpe_mobile/Entities/Groupe.dart';

class Matiere {
  int _id;
  String _nom;
  String _jour;
  String _debut;
  String _fin;
  Groupe _groupe;
  Matiere({
    required int id,
    required String nom,
    required String jour,
    required String debut,
    required String fin,
    required Groupe groupe,
  })  : _id = id,
        _nom = nom,
        _jour = jour,
        _debut = debut,
        _fin = fin,
        _groupe = groupe;


  // Getters
  int get id => _id;
  String get nom => _nom;
  String get jour => _jour;
  String get debut => _debut;
  String get fin => _fin;
  Groupe get groupe => _groupe;
  // Setters
  set id(int newId) => _id = newId;
  set nom(String newNom) => _nom = newNom;
  set jour(String newJour) => _jour = newJour;
  set debut(String newDebut) => _debut = newDebut;
  set fin(String newFin) => _fin = newFin;
  set groupe(Groupe newGroupe) => _groupe = newGroupe;
  
}