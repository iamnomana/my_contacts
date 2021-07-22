import 'package:my_contacts/controllers/contactController.dart';
import 'package:my_contacts/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContact extends StatelessWidget {
  final ContactController _contactController = Get.find<ContactController>();
  // Form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _contactController.nameTextController,
                  decoration: styleTextInputDecoration.copyWith(
                    labelText: 'Name',
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (val) {
                    return val.trim().isEmpty ? "This field is required" : null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _contactController.phoneNumberTextController,
                  decoration: styleTextInputDecoration.copyWith(
                    labelText: 'Phone',
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (val) {
                    return val.trim().isEmpty ? "This field is required" : null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    elevation: MaterialStateProperty.all<double>(2),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Text('Save'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await _contactController.addContact(
                          _contactController.nameTextController.text,
                          _contactController.phoneNumberTextController.text);

                      _contactController.clearInputField();
                      Get.back();
                      _contactController.showSnackbar(
                        "Success",
                        "Contact added successfully",
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        Colors.green,
                        Colors.white,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
