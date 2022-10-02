class PersonModel {
  PersonModel({
    this.id,
    required this.firstname,
    required this.surname,
    required this.email,
  });

  String? id;
  String firstname;
  String surname;
  String email;

  PersonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstname = json['firstname'],
        surname = json['surname'],
        email = json['email'];

  static List<PersonModel> fromJsonList(List<dynamic> list) =>
      list.map((person) => PersonModel.fromJson(person)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstname': firstname,
        'surname': surname,
        'email': email,
      };
}
