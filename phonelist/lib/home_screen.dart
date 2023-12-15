import 'package:flutter/material.dart';
import 'package:phonelist/person.model.dart';
import 'package:phonelist/person_service.dart';

class HomeScreen extends StatelessWidget {
  final PersonService personService = PersonService();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Nomor Telepon'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Person>>(
          future: personService.fetchPersons(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
            if (snapshot.hasData) {
              return Card(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var currentPerson = snapshot.data?[index];

                    return ListTile(
                      title: Text(currentPerson!.name),
                      subtitle: Text("Phone: ${currentPerson.phoneNumber}"),
                    );
                  },
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 82.0,
                ),
              );
            }

            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Loading at the moment, please hold the line."),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
