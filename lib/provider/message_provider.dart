import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giphy_api_client/giphy_api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:upi_india/upi_india.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/getit.dart';
import 'package:whatsapp_redesign/managers/firestore_manager.dart';
import 'package:whatsapp_redesign/models/document.dart';
import 'package:whatsapp_redesign/models/message.dart';
import 'package:latlong2/latlong.dart';
import 'package:whatsapp_redesign/models/upi_payment.dart';
import 'package:whatsapp_redesign/models/user.dart';
import 'package:whatsapp_redesign/provider/audio_provider.dart';
import 'package:whatsapp_redesign/views/contact_page/contact_page.dart';
import 'package:whatsapp_redesign/views/message_page/message_page.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/map_screen.dart';

class MessageProvider extends ChangeNotifier {
  bool isSearch = false;
  bool isGifClicked = false;
  bool isRecordingStarted = false;
  bool isRecordingInDraft = false;
  bool isMenuPopupOpened = false;
  TextEditingController messageController = TextEditingController();
  TextEditingController gifController = TextEditingController();
  final client = GiphyClient(apiKey: 'NMFj5k2Slp67Tg2lSUANshwMFS9qTiB1');
  final ItemScrollController scrollController = ItemScrollController();
  final AudioProvider provider = getIt<AudioProvider>();
  User? user;
  String? chatId;
  FirestoreManager manager = FirestoreManager();

  List<MainMenu> mainMenus = [
    MainMenu("Document", LineIcons.file, "document"),
    MainMenu("Camera", LineIcons.camera, "camera"),
    MainMenu("Gallery", LineIcons.image, "gallery"),
    MainMenu("Audio", LineIcons.audioFile, "audio"),
    MainMenu("Payment", LineIcons.indianRupeeSign, "payment"),
    MainMenu("Location", Icons.location_on_outlined, "location"),
    MainMenu("Contact", Icons.contact_page_outlined, "contact"),
  ];

  void initialize(User tempUser, String? tempChatId) {
    user = tempUser;
    chatId = tempChatId;
    notifyListeners();
  }

  void onGifToggle(context) {
    isGifClicked = !isGifClicked;
    if (isGifClicked) {
      FocusScope.of(context).unfocus();
    }
    notifyListeners();
  }

  void sendMessage(Message message) {
    String generateRandomHex(int length) {
      Random random = Random();
      int maxVal = (pow(16, length) - 1).toInt();
      int randomInt = random.nextInt(maxVal + 1);
      String hexString = randomInt.toRadixString(16).toUpperCase();
      return hexString.padLeft(length, '0');
    }

    chatId ??= generateRandomHex(10);
    manager.sendChatMessage(chatId!, message, user!);
    isGifClicked = false;
    notifyListeners();
  }

  void sendMultipleMessages(List<Message> messages) {
    // upload to firestore for particular user

    notifyListeners();
  }

  onMainMenuClicked(
      BuildContext context, String key, Function() onUpiClicked) async {
    Navigator.pop(context);
    switch (key) {
      case "document":
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
        );

        final files = result?.files;

        if (files != null) {
          sendMultipleMessages(files
              .map((e) => Message(
                  isIncomingMessage: false,
                  messageType: MessageType.doc,
                  file: Document(e.name, e.size, e.extension ?? "")))
              .toList());
        }
        break;
      case "camera":
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          Message message = Message(
              isIncomingMessage: false,
              messageType: MessageType.imageMedia,
              gifBytes: await image.readAsBytes());
          sendMessage(message);
        }
        break;
      case "gallery":
        final ImagePicker picker = ImagePicker();
        final List<XFile> images = await picker.pickMultiImage();
        List<Message> messages = [];
        for (var image in images) {
          messages.add(Message(
              isIncomingMessage: false,
              messageType: MessageType.imageMedia,
              gifBytes: await image.readAsBytes()));
        }
        sendMultipleMessages(messages);
        break;
      case "audio":
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom, allowedExtensions: ["mp3", "wav", "flac"]);
        final files = result?.files;

        if (files != null) {
          sendMultipleMessages(files
              .map((e) => Message(
                  isIncomingMessage: false,
                  messageType: MessageType.doc,
                  file: Document(e.name, e.size, e.extension ?? "")))
              .toList());
        }
        break;
      case "payment":
        onUpiClicked();
        break;
      case "location":
        LatLng latLng = await Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => const MapScreen()));
        sendMessage(Message(
            isIncomingMessage: false,
            messageType: MessageType.location,
            latLng: latLng));
        break;
      case "contact":
        List<User>? selectedContacts = await Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => const ContactPage()));
        if (selectedContacts != null) {
          sendMultipleMessages(selectedContacts
              .map((e) => Message(
                  isIncomingMessage: false,
                  messageType: MessageType.contact,
                  contact: Contact(
                      name: Name(first: e.firstName, last: e.lastName ?? ""),
                      phones: [Phone(e.phoneNumber)])))
              .toList());
        }
        break;
    }
  }

  void onUpiAppSelected(BuildContext context, UpiApp app) async {
    Future<UpiPayment> initiateTransaction(UpiPayment upiPayment) async {
      UpiIndia upiIndia = UpiIndia();
      UpiResponse upiResponse = await upiIndia.startTransaction(
        app: upiPayment.upiApp,
        receiverUpiId: upiPayment.receiverUpiId,
        receiverName: upiPayment.receiverName,
        transactionRefId: upiPayment.transactionRefId,
        transactionNote: upiPayment.transactionNote,
        amount: upiPayment.amount,
      );
      switch (upiResponse.status) {
        case UpiPaymentStatus.SUCCESS:
          upiPayment.isTransactionSuccessful = true;
          upiPayment.transactionId = upiResponse.transactionId;
          break;
        default:
          upiPayment.isTransactionSuccessful = false;
          break;
      }
      return upiPayment;
    }

    Navigator.pop(context);
    UpiPayment upiPayment = UpiPayment(
        receiverUpiId: "9999999999@paytm",
        receiverName: "Rajat Makan",
        transactionRefId: "WhatsApp",
        transactionNote: "Money sent using WhatsApp",
        isTransactionSuccessful: true,
        upiApp: app,
        amount: 1);
    UpiPayment upiPaymentWithStatus = await initiateTransaction(upiPayment);
    if (upiPaymentWithStatus.isTransactionSuccessful) {
      sendMessage(Message(
        isIncomingMessage: false,
        messageType: MessageType.upiPayment,
        upiPayment: upiPaymentWithStatus,
      ));
    } else {
      Fluttertoast.showToast(
        msg: "Unable to clear the Transaction",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

//  messages = [
//       const CircularMessage(
//           fromFriend: true,
//           messageType: MessageType.text,
//           message: "Whatcha doing bro? 🤔"),
//       const CircularMessage(
//           fromFriend: false,
//           messageType: MessageType.text,
//           message:
//               "nah! bro, nothing much but I found a great channel on YouTube"),
//       const CircularMessage(
//           fromFriend: true,
//           messageType: MessageType.imageMedia,
//           gifUrl: "https://i.giphy.com/media/oOTTyHRHj0HYY/giphy.webp"),
//       const CircularMessage(
//           fromFriend: false,
//           messageType: MessageType.url,
//           url: "https://www.youtube.com/watch?v=yqsb3gKP_N4"),
//       const CircularMessage(
//           fromFriend: false,
//           messageType: MessageType.text,
//           message:
//               "Yeah! You can watch this video where he is explaining about a whatsapp clone!"),
//       const CircularMessage(
//           fromFriend: true,
//           messageType: MessageType.text,
//           message: "Wowww! That does sound cool"),
//       const CircularMessage(
//           fromFriend: true,
//           messageType: MessageType.text,
//           message: "I am going to subscribe the channel right NOW!!!"),
//       CircularMessage(
//           fromFriend: false,
//           messageType: MessageType.doc,
//           file: Document("arts.zip", 3258421, "zip")),
//     ];
}
