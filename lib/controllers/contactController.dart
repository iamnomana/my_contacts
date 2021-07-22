import 'package:intl/intl.dart';
import 'package:my_contacts/database/db_helper.dart';
import 'package:my_contacts/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  /* this function will be called as soon as you 
  navigate to screen */
  @override
  void onReady() {
    getContacts();
    // examplePageState();
    super.onReady();
  }

  //this will hold the data and update the ui
  var contactModelList = <Contact>[].obs;

  // To get the text from textformfield widget
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();

  var isEdit = false.obs;

  // Show Snack Bar
  void showSnackbar(
      String title, String message, Icon icon, Color bgColor, Color textColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      icon: icon,
      backgroundColor: bgColor,
      colorText: textColor,
    );
  }

  // Clear Input field
  void clearInputField() {
    nameTextController.clear();
    phoneNumberTextController.clear();
  }

  Widget appBarTitle = new Text('Contacts');
  var searchIcon = new Icon(Icons.search);
  final TextEditingController searchTextController =
      new TextEditingController();
  List filteredNames = [];
  var _searchText = "";

  void searchPressed() {
    if (this.searchIcon.icon == Icons.search) {
      this.searchIcon = new Icon(Icons.close);
      this.appBarTitle = new TextField(
        onChanged: (val) {
          if (val.isNotEmpty) {
            _searchText = val;
            searchContactList(_searchText);
          } else {
            _searchText = '';
            getContacts();
            // searchContactList();
          }
        },
        style: TextStyle(
          color: Colors.white,
        ),
        controller: searchTextController,
        decoration: new InputDecoration(
          focusColor: Colors.white,
          fillColor: Colors.white,
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else {
      this.searchIcon = new Icon(Icons.search);
      this.appBarTitle = new Text('Contacts');
      filteredNames = contactModelList;
      searchTextController.clear();
    }
    update(['searchbar']);
  }

  // Search through contacts
  Future<void> searchContactList(String value) async {
    if (value.isNotEmpty) {
      List<Map<String, dynamic>> searchContactList =
          await DBHelper.searchContacts(value);

      contactModelList.assignAll(searchContactList.map((data) {
        return new Contact.fromMap(data);
      }).toList());
    }
  }

  // Add Contact
  Future<void> addContact(String name, String phone) async {
    try {
      var res = await DBHelper.insert(
        Contact(
          name: name,
          phone: phone,
          createdAt: DateTime.now(),
        ),
      );
      getContacts();
      return res;
    } catch (e) {
      return e;
    }
  }

  // Update Contact
  Future<void> updateContact(String name, String phone, int id) async {
    try {
      var res = DBHelper.update(Contact(
        id: id,
        name: name,
        phone: phone,
      ));
      getContacts();
      print(res);

      return res;
    } catch (e) {
      return e;
    }
  }

  // Get Contacts
  Future<void> getContacts() async {
    List<Map<String, dynamic>> contactList = await DBHelper.getContacts();
    print(contactList);
    contactModelList.assignAll(contactList.map((data) {
      return new Contact.fromMap(data);
    }).toList());
  }

  // Delete Contact
  Future<void> deleteContact(int id) async {
    try {
      var res = await DBHelper.delete(id);

      getContacts();
      return res;
    } catch (e) {
      return e;
    }
  }
}
