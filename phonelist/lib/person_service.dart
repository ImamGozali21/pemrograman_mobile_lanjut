import 'package:phonelist/person.model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class PersonService {
  Future<List<Person>> fetchPersons() async {
    String jsonString =
        await rootBundle.loadString("../assets/phone_list.json");
    Map peopleData = jsonDecode(jsonString);

    final people = <Person>[];
    peopleData['result'].forEach((v) {
      people.add(Person.fromJson(v));
    });

    return people;
  }
}
