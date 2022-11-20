import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/data/response.dart';

final FirebaseFirestore _store = FirebaseFirestore.instance;
final CollectionReference _reference = _store.collection("Employees");

class FirebaseCrud {
  static Future<Response> addEmp(
    String empID,
    String name,
    int salary,
  ) async {
    Response r = Response();

    DocumentReference documentReference = _reference.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "EMP_ID": empID,
      "Name": name,
      "Salary": salary,
    };

    // ignore: unused_local_variable
    var result = await documentReference.set(data).whenComplete(() {
      r.code = 200;
      r.msg = "Record Stored successfully !!";
    }).catchError((e) {
      r.code = 500;
      r.msg = e.message;
    });

    return r;
  }

  static Stream<QuerySnapshot> readData() {
    return _reference.snapshots();
  }

  static Future<Response> updateData(
    String empID,
    String name,
    int salary,
    String docID,
  ) async {
    Response r = Response();

    DocumentReference docRef = _reference.doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "EMP_ID": empID,
      "Name": name,
      "Salary": salary,
    };

    await docRef.update(data).whenComplete(() {
      r.code = 200;
      r.msg = "Record updated successfully !!";
    }).catchError((e) {
      r.code = 500;
      r.msg = e.message;
    });

    return r;
  }

  static Future<Response> deleteData({required String docID}) async {
    Response r = Response();

    DocumentReference ref = _reference.doc(docID);

    await ref.delete().whenComplete(
      () {
        r.code = 200;
        r.msg = "Record deleted successfully !!";
      },
    ).catchError((e) {
      r.code = 500;
      r.msg = e.message;
    });
    return r;
  }
}
