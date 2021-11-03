import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var emailEditingController = TextEditingController();
  var storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Email Validation",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Validation"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: emailEditingController,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  child: const Text("Check & Write"),
                  onPressed: () {
                    if (GetUtils.isEmail(emailEditingController.text)) {
                      Get.snackbar(
                          "Success", "Email is valid and saved sucessfully",
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                          snackPosition: SnackPosition.BOTTOM);
                      storage.write("email", emailEditingController.text);
                    } else {
                      Get.snackbar(
                          "Incorrect Email", "Provide email in valid format",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                ),
              ),
              // const SizedBox(
              //   height: 3,
              // ),

              ElevatedButton(
                child: const Text("Fetch Saved Email"),
                onPressed: () {
                  // Get.snackbar("Stored data", ${storage.read("email")});

                  Get.defaultDialog(
                      title: "The save email is ${storage.read("email")}");
                },
              ),

              ElevatedButton(
                  onPressed: () {
                    storage.erase();
                  },
                  child: Text("Erase all data"))
            ],
          ),
        ),
      ),
    );
  }
}
