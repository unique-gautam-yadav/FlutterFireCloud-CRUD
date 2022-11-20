import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/data/operations.dart';
import 'package:firebase/data/response.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> data = FirebaseCrud.readData();

  final GlobalKey sKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sKey,
      appBar: AppBar(title: const Text("Home Page")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add"),
                content: AddPage(sKey: sKey),
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: data,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListView(
                  children: snapshot.data!.docs.map((e) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9, right: 9),
                        child: ExpansionTile(
                          title: Text(e["Name"]),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(text: "Salary : ", children: [
                                  TextSpan(
                                      text: "${e["Salary"]}",
                                      style:
                                          Theme.of(context).textTheme.caption),
                                ]),
                              ),
                              RichText(
                                text: TextSpan(text: "EMP_ID : ", children: [
                                  TextSpan(
                                      text: e["EMP_ID"],
                                      style:
                                          Theme.of(context).textTheme.caption),
                                ]),
                              )
                            ],
                          ),
                          leading: Container(
                            decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: Center(
                              child: Text(
                                e["Name"][0],
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                          children: [
                            const Divider(),
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return UpdateProfile(
                                            eID: e["EMP_ID"],
                                            sKey: sKey,
                                            name: e["Name"],
                                            docID: e.id,
                                            salary: int.parse(
                                                e["Salary"].toString()),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.edit_note_rounded)),
                                IconButton(
                                    onPressed: () async {
                                      Response r =
                                          await FirebaseCrud.deleteData(
                                              docID: e.id);
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text("${r.msg}")),
                                      );
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return const Center(child: Text("Hmmm!! No Data!!"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
