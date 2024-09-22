import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_application/services/database_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // ignore: non_constant_identifier_names
  Stream? EmpDetails;

  void pageFunc() async {
    EmpDetails = await DataModel().readInfo();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pageFunc();
  }

  Widget empFunc() {
    return StreamBuilder(
        stream: EmpDetails,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  // ignore: prefer_interpolation_to_compose_strings
                                  Text("Name is " + ds["name"]),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      nameController.text = ds["name"];
                                      ageController.text = ds["age"];
                                      countryController.text = ds["country"];
                                      editInfo(ds["Id"]);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await DataModel().deleteInfo(ds["Id"]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // ignore: prefer_interpolation_to_compose_strings
                              Text("Age is " + ds["age"]),
                              const SizedBox(
                                height: 5,
                              ),
                              // ignore: prefer_interpolation_to_compose_strings
                              Text("Country is " + ds["country"]),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text("Read Data!"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: empFunc(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Future editInfo(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 350,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "EDIT PAGE",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: ageController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: "Enter Age",
                        prefixIcon: const Icon(Icons.numbers),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: countryController,
                      decoration: InputDecoration(
                        hintText: "Enter Country Name",
                        prefixIcon: const Icon(Icons.map_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updatedata = {
                        "name": nameController.text,
                        "age": ageController.text,
                        "country": countryController.text,
                        "Id": id,
                      };

                      await DataModel()
                          .updateInfo(id, updatedata)
                          .then((value) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("UPDATE"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
