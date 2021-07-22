import 'package:my_contacts/controllers/contactController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contacts extends StatelessWidget {
  // const Contacts({Key key}) : super(key: key);
  final ContactController _contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GetBuilder<ContactController>(
          id: "searchbar",
          builder: (_) {
            return _contactController.appBarTitle;
          },
        ),
        actions: [
          IconButton(
            icon: GetBuilder<ContactController>(
              id: "searchbar",
              builder: (_) {
                return _contactController.searchIcon;
              },
            ),
            onPressed: () {
              _contactController.searchPressed();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Obx(() {
            if (_contactController.contactModelList.length == 0) {
              return Center(
                child: Text('No Contacts'),
              );
            }
            // return _contactController.buildList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _contactController.contactModelList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue[200],
                  shadowColor: Colors.black,
                  child: ListTile(
                    onLongPress: () {
                      print("Delete");
                      Get.defaultDialog(
                        barrierDismissible: false,
                        title: "Confirm Action",
                        content: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Do you want to delete ${_contactController.contactModelList[index].name} from contacts?"),
                          ),
                        ),
                        onCancel: () {
                          Get.back();
                        },
                        textCancel: "No",
                        textConfirm: "Yes",
                        // buttonColor: Colors.white,
                        // cancelTextColor: Colors.black,
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          _contactController.deleteContact(
                              _contactController.contactModelList[index].id);
                          Get.back();
                          _contactController.showSnackbar(
                            "Success",
                            "Contact deleted successfully",
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            Colors.green,
                            Colors.white,
                          );
                        },
                      );
                    },
                    title: Text(
                      _contactController.contactModelList[index].name,
                    ),
                    subtitle: Text(
                      _contactController.contactModelList[index].phone,
                    ),
                    trailing: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Get.toNamed('/editcontact',
                            arguments:
                                _contactController.contactModelList[index]);
                      },
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _contactController.clearInputField();
          Get.toNamed('/addcontact');
        },
      ),
    );
  }
}
