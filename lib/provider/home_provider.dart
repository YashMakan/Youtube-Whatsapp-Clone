import 'package:flutter/cupertino.dart';
import 'package:whatsapp_redesign/managers/firestore_manager.dart';
import 'package:whatsapp_redesign/models/user.dart';

class HomeProvider extends ChangeNotifier {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  // List<Chat> chats = [];
  List<User> statusList = [];
  FirestoreManager manager = FirestoreManager();

  double SLIDABLE_WIDGET_WIDTH_RATIO = 0.25;
  double SLIDABLE_ICON_SIZE = 30;

  // void removeChatAtIndex(int index) {
  //   chats.removeAt(index);
  //   notifyListeners();
  // }

  void toggleIsSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }
}