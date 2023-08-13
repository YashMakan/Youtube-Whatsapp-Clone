import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_redesign/managers/firestore_manager.dart';

class ContactProvider extends ChangeNotifier {
  bool isSearch = false;
  bool isLoadingFinished = false;
  TextEditingController controller = TextEditingController();
  List<Contact> selectedContacts = [];
  List<Contact> initialContacts = [];
  List<Contact> contacts = [];
  FirestoreManager manager = FirestoreManager();

  bool isContactSelected(Contact contact) => selectedContacts
      .any((_contact) => _contact.phones.contains(contact.phones.first.number));

  Future<List<Contact>?> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> _contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true, withThumbnail: true);
      print("_contacts: $_contacts");
      initialContacts = _contacts;
      contacts = _contacts;
      isLoadingFinished = true;
      notifyListeners();
    } else {
      print("Permission declined");
    }
    return null;
  }

  void toggleSearch() {
    isSearch = !isSearch;
    if (!isSearch) {
      contacts = initialContacts;
    }
    notifyListeners();
  }

  void onContactSearch(String value) {
    contacts = initialContacts
        .where((element) => element.displayName
        .toLowerCase()
        .contains(value))
        .toList();
    notifyListeners();
  }
}