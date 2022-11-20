import 'package:firebase/data/operations.dart';
import 'package:firebase/data/response.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
    required this.sKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> sKey;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController eID = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController salary = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> processData() async {
    if (formKey.currentState!.validate()) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Response r = await FirebaseCrud.addEmp(
          eID.text, name.text, int.parse(salary.text));
      ScaffoldMessenger.of(widget.sKey.currentState!.context).showSnackBar(
        SnackBar(content: Text("${r.msg}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Please enter a value";
                  } else if (value.length < 3) {
                    return "A EID must have at least 3 char.";
                  } else if (value[0] != "E" && value[0] != "e") {
                    return "EID should be start with latter 'E' or 'e'";
                  } else {
                    return null;
                  }
                },
                controller: eID,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    label: Text("Employee ID")),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Please enter a value";
                  } else if (value.length < 3) {
                    return "A name must have at least 3 char.";
                  } else {
                    return null;
                  }
                },
                controller: name,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    label: Text("Name of employee")),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: salary,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    label: Text("Salary")),
                validator: (value) {
                  if (value == null) {
                    return "Please enter a value";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  processData();
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(left: 50, right: 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurpleAccent)),
                child: const Text(
                  "Add To List",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({
    Key? key,
    required this.sKey,
    required this.eID,
    required this.name,
    required this.salary, required this.docID,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> sKey;
  final String eID;
  final String name;
  final int salary;
  final String docID;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController eID = TextEditingController(text: widget.eID);
    TextEditingController name = TextEditingController(text: widget.name);
    TextEditingController salary =
        TextEditingController(text: widget.salary.toString());

    Future<void> processData() async {
      if (formKey.currentState!.validate()) {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Response r = await FirebaseCrud.updateData(eID.text, name.text,
            int.parse(salary.text.toString()), widget.docID);
        ScaffoldMessenger.of(widget.sKey.currentState!.context).showSnackBar(
          SnackBar(content: Text("${r.msg}")),
        );
      }
    }

    return AlertDialog(
        title: const Text("Update Profile"),
        content: SizedBox(
          height: 275,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a value";
                      } else if (value.length < 3) {
                        return "A EID must have at least 3 char.";
                      } else if (value[0] != "E" && value[0] != "e") {
                        return "EID should be start with latter 'E' or 'e'";
                      } else {
                        return null;
                      }
                    },
                    controller: eID,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        label: Text("Employee ID")),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a value";
                      } else if (value.length < 3) {
                        return "A name must have at least 3 char.";
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        label: Text("Name of employee")),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: salary,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        label: Text("Salary")),
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      processData();
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(left: 50, right: 50)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent)),
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
