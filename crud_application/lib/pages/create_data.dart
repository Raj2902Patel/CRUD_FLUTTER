import 'package:crud_application/pages/read_data.dart';
import 'package:crud_application/services/database_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Create Data!"),
        ),
      ),
      body: Column(
        children: [
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
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  // ignore: non_constant_identifier_names
                  String Id = randomAlphaNumeric(10);

                  Map<String, dynamic> empInfo = {
                    "name": nameController.text,
                    "age": ageController.text,
                    "country": countryController.text,
                    "Id": Id
                  };

                  await DataModel().createInfo(empInfo, Id).then((value) {
                    Fluttertoast.showToast(
                        msg: "Data Stored!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.greenAccent,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });

                  nameController.clear();
                  ageController.clear();
                  countryController.clear();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReadData()));
                },
                child: const Text("SUBMIT")),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ReadData()));
        },
        child: const Icon(Icons.flight),
      ),
    );
  }
}
