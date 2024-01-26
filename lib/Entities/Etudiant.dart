class Etudiant {
  int _id;
  String _nom;
  String _prenom;
  bool _status;
  int _nbAbsence ;

  Etudiant({
    required int id,
    required String nom,
    required String prenom,
    required bool status,
    required int nbAbsence,

  })  : _id = id,
        _nom = nom,
        _prenom = prenom,
        _status = status,
        _nbAbsence = nbAbsence;



  // Getters for private properties
  int get id => _id;
  String get nom => _nom;
  String get prenom => _prenom;
  bool get status => _status;
  int get nbAbsence => _nbAbsence;

  // Setters for private properties
  set id(int newId) => _id = newId;
  set nom(String newNom) => _nom = newNom;
  set prenom(String newPrenom) => _prenom = newPrenom;
  set status(bool newStatus) => _status = newStatus;
  set nbAbsence(int newNbAbsence) => _nbAbsence = newNbAbsence;
  // Convert Etudiant object to a Map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nom': _nom,
      'prenom': _prenom,
      'status': _status,
    };
  }

}
