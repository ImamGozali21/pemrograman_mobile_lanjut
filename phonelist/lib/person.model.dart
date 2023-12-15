class Person {
  String name;
  String phoneNumber;

  Person({required this.name, required this.phoneNumber});

  Person.fromJson(Map<String, dynamic> json)
      : name = "${json["first_name"]} ${json["last_name"]}",
        phoneNumber = json["number_phone"];
}
