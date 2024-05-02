import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReferencePeople = db.collection('personas');

  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  for (var documento in queryPeople.docs) {
    people.add(documento.data());
  }
  return people;
}

Future<void> addPeople(String name) async {
  await db.collection('personas').add({'nombre': name});
}