class Professeur {
  final int id;
  final String nom;
  final String prenom;
  final String email;

  Professeur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  factory Professeur.fromJson(Map<String, dynamic> json) {
    print(json);
    return Professeur(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
    };
  }
}



