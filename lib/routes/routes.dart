import 'package:my_contacts/views/add_contact.dart';
import 'package:my_contacts/views/contacts_list.dart';
import 'package:my_contacts/views/edit_contact.dart';
import 'package:get/get.dart';

class Routes {
  static final routes = [
    GetPage(
      name: '/contactspage',
      page: () => Contacts(),
    ),
    GetPage(
      name: '/addcontact',
      page: () => AddContact(),
    ),
    GetPage(
      name: '/editcontact',
      page: () => EditContact(),
    ),
  ];
}
