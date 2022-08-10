import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upi_india/upi_india.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giphy_api_client/giphy_api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/getit.dart';
import 'package:whatsapp_application/models/document.dart';
import 'package:whatsapp_application/models/user.dart';
import 'package:whatsapp_application/provider/provider.dart';
import 'package:whatsapp_application/views/contact_page/contact_page.dart';
import 'package:whatsapp_application/views/message_page/components/header_section.dart';
import 'package:whatsapp_application/views/message_page/components/map_screen.dart';
import 'package:whatsapp_application/views/message_page/message_page_widgets.dart';
import 'package:whatsapp_application/widgets/common_widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:latlong2/latlong.dart';
import '../../constants/colors.dart';
import '../../helper/size_config.dart';
import '../../models/upi_payment.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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

  // final ScrollController scrollController = ScrollController();
  List<MainMenu> mainMenus = [
    MainMenu("Document", LineIcons.file, "document"),
    MainMenu("Camera", LineIcons.camera, "camera"),
    MainMenu("Gallery", LineIcons.image, "gallery"),
    MainMenu("Audio", LineIcons.audioFile, "audio"),
    MainMenu("Payment", LineIcons.indianRupeeSign, "payment"),
    MainMenu("Location", Icons.location_on_outlined, "location"),
    MainMenu("Contact", Icons.contact_page_outlined, "contact"),
  ];
  late List<Widget> messages;

  getMessages() {
    messages = [
      circularMessage(
          fromFriend: true,
          messageType: MessageType.text,
          message: "Whatcha doing bro? 🤔"),
      circularMessage(
          fromFriend: false,
          messageType: MessageType.text,
          message:
              "nah! bro, nothing much but I found a great channel on YouTube"),
      circularMessage(
          fromFriend: true,
          messageType: MessageType.imageMedia,
          gifUrl: "https://i.giphy.com/media/oOTTyHRHj0HYY/giphy.webp"),
      circularMessage(
          fromFriend: false,
          messageType: MessageType.url,
          url: "https://www.youtube.com/watch?v=yqsb3gKP_N4"),
      circularMessage(
          fromFriend: false,
          messageType: MessageType.text,
          message:
              "Yeah! You can watch this video where he is explaining about a whatsapp clone!"),
      circularMessage(
          fromFriend: true,
          messageType: MessageType.text,
          message: "Wowww! That does sound cool"),
      circularMessage(
          fromFriend: true,
          messageType: MessageType.text,
          message: "I am going to subscribe the channel right NOW!!!"),
      circularMessage(
          fromFriend: false,
          messageType: MessageType.doc,
          file: Document("arts.zip", 3258421, "zip")),
    ];
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollToBottom(jump: true);
    });
  }

  @override
  void initState() {
    getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Column(
        children: [
          HeaderSection(user: widget.user),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ScrollablePositionedList.builder(
              itemScrollController: scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) => messages[index],
            ),
          )),
          isRecordingStarted
              ? SizedBox(
                  width: SizeConfig.screenWidth,
                  height: 80,
                )
              : const SizedBox(),
          isGifClicked
              ? SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        circularIconButton(
                            iconData: Icons.gif,
                            onTap: () {
                              setState(() {
                                isGifClicked = !isGifClicked;
                              });
                            }),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                            child: circularTextField(
                                controller: gifController,
                                onChanged: (value) {
                                  if (value.length < 2) {
                                    setState(() {});
                                  }
                                },
                                hintText: "Search...")),
                        const SizedBox(
                          width: 8.0,
                        ),
                        circularIconButton(
                            iconData: LineIcons.search,
                            onTap: () {
                              setState(() {
                                FocusManager.instance.primaryFocus?.unfocus();
                              });
                            }),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        circularIconButton(
                            iconData: Icons.gif,
                            onTap: () {
                              setState(() {
                                isGifClicked = !isGifClicked;
                                if (isGifClicked) {
                                  FocusScope.of(context).unfocus();
                                }
                              });
                            }),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                            child: circularTextField(
                                controller: messageController,
                                onFieldSubmitted: (value) {
                                  Widget message =
                                      convertStringToMessage(value);
                                  messages.add(message);
                                  setState(() {});
                                  scrollToBottom();
                                },
                                onChanged: (value) {
                                  if (value.length < 2) {
                                    setState(() {});
                                  }
                                },
                                hintText: "Respond...")),
                        const SizedBox(
                          width: 8.0,
                        ),
                        messageController.text.isEmpty
                            ? Row(
                                children: [
                                  circularIconButton(
                                      iconData: LineIcons.microphone,
                                      onLongPressStart: (details) {
                                        messages.add(circularMessage(
                                            fromFriend: false,
                                            messageType: MessageType.audio));
                                        setState(() {});
                                        scrollToBottom();
                                      },
                                      onLongPressEnd: (details) {
                                        if (details.localPosition.dx > 50) {
                                          messages.removeLast();
                                        } else {
                                          isRecordingInDraft = true;
                                        }
                                        provider.stopRecording();
                                        setState(() {});
                                        scrollToBottom();
                                      }),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  circularIconButton(
                                      iconData: isRecordingStarted
                                          ? Icons.delete_outline
                                          : LineIcons.horizontalEllipsis,
                                      onTap: () {
                                        showManinMenuBottomSheet();
                                      })
                                ],
                              )
                            : Transform.rotate(
                                child: circularIconButton(
                                    iconData: Icons.send_outlined,
                                    onTap: () async {
                                      Widget message = convertStringToMessage(
                                          messageController.text);
                                      messages.add(message);
                                      messageController.clear();
                                      setState(() {});
                                      scrollToBottom();
                                    }),
                                angle: 0.01745 * -30)
                      ],
                    ),
                  ),
                ),
          isGifClicked
              ? SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.2,
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: gifController.text.isEmpty
                            ? client.trending()
                            : client.search(gifController.text),
                        builder:
                            (context, AsyncSnapshot<GiphyCollection> snapshot) {
                          List<GiphyGif?> gifs = snapshot.data?.data ?? [];
                          if (snapshot.hasData) {
                            return Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 15.0,
                                          mainAxisSpacing: 15.0,
                                          childAspectRatio: 1.4),
                                  padding: EdgeInsets.zero,
                                  itemCount: gifs.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Widget message = convertImageToMessage(
                                            gifs[index]?.images?.original?.url);
                                        messages.add(message);
                                        isGifClicked = false;
                                        setState(() {});
                                        scrollToBottom();
                                      },
                                      child: Image.network(
                                        gifs[index]?.images?.original?.url ??
                                            "",
                                        width: 50,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      )
                    ],
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }

  scrollToBottom({bool jump = false}) {
    if (jump) {
      scrollController.jumpTo(index: messages.length);
    } else {
      scrollController.scrollTo(
          index: messages.length, duration: const Duration(milliseconds: 600));
    }
  }

  showManinMenuBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 80),
            child: Container(
              width: SizeConfig.screenWidth,
              height: 340,
              decoration: const BoxDecoration(
                  color: Color(0xFF101010),
                  borderRadius: BorderRadius.all(Radius.circular(22))),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0),
                itemCount: mainMenus.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      switch (mainMenus[index].key) {
                        case "document":
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                          );
                          List<Widget> _messages =
                              convertFilesToMessages(result?.files);
                          messages.addAll(_messages);
                          setState(() {});
                          scrollToBottom();
                          break;
                        case "camera":
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (image != null) {
                            Widget message = circularMessage(
                                fromFriend: false,
                                messageType: MessageType.imageMedia,
                                gifBytes: await image.readAsBytes());
                            messages.add(message);
                            setState(() {});
                            scrollToBottom();
                          }
                          break;
                        case "gallery":
                          final ImagePicker _picker = ImagePicker();
                          final List<XFile>? images =
                              await _picker.pickMultiImage();
                          if (images != null) {
                            var _messages = images
                                .map((image) async => circularMessage(
                                    fromFriend: false,
                                    messageType: MessageType.imageMedia,
                                    gifBytes: await image.readAsBytes()))
                                .toList();
                            _messages.forEach((message) async {
                              messages.add(await message);
                            });
                            setState(() {});
                            scrollToBottom();
                          }
                          break;
                        case "audio":
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ["mp3", "wav", "flac"]);
                          List<Widget> _messages =
                              convertFilesToMessages(result?.files);
                          messages.addAll(_messages);
                          setState(() {});
                          scrollToBottom();
                          break;
                        case "payment":
                          showUpiApps();
                          break;
                        case "location":
                          LatLng latLng = await Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) => const MapScreen()));
                          Widget message = convertLocationToMessage(latLng);
                          messages.add(message);
                          setState(() {});
                          scrollToBottom();
                          break;
                        case "contact":
                          List<User>? selectedContacts =
                              await Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const ContactPage()));
                          List<Widget> _messages =
                              convertContactsToMessages(selectedContacts);
                          messages.addAll(_messages);
                          setState(() {});
                          scrollToBottom();
                          break;
                      }
                    },
                    child: gradientIconButton(
                        size: 60,
                        iconData: mainMenus[index].iconData,
                        text: mainMenus[index].text),
                  );
                },
              ),
            ),
          );
        });
  }

  showUpiApps() async {
    UpiIndia upiIndia = UpiIndia();
    List<UpiApp> apps = await upiIndia.getAllUpiApps(
        allowNonVerifiedApps: false, mandatoryTransactionId: false);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 80),
            child: Container(
              width: SizeConfig.screenWidth,
              height: 340,
              decoration: const BoxDecoration(
                  color: Color(0xFF101010),
                  borderRadius: BorderRadius.all(Radius.circular(22))),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0),
                itemCount: apps.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      UpiPayment _upiPayment = UpiPayment(
                          receiverUpiId: "9999999999@paytm",
                          receiverName: "Rajat Makan",
                          transactionRefId: "WhatsApp",
                          transactionNote: "Money sent using WhatsApp",
                          isTransactionSuccessful: true,
                          upiApp: apps[index],
                          amount: 1);
                      UpiPayment _upiPaymentWithStatus =
                          await initiateTransaction(_upiPayment);
                      if (_upiPaymentWithStatus.isTransactionSuccessful) {
                        messages.add(circularMessage(
                            fromFriend: false,
                            upiPayment: _upiPaymentWithStatus,
                            messageType: MessageType.upiPayment));
                        setState(() {});
                        scrollToBottom();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Unable to clear the Transaction",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                        );
                      }
                    },
                    child: gradientIconButton(
                        size: 60,
                        imageBytes: apps[index].icon,
                        text: apps[index].name),
                  );
                },
              ),
            ),
          );
        });
  }

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

  Future convertXFilesToMessages(List<XFile>? files) async {
    if (files != null) {
      return files
          .map((e) async => circularMessage(
              fromFriend: false,
              messageType: MessageType.doc,
              file: Document(
                  e.name, (await e.readAsBytes()).length, e.mimeType ?? "")))
          .toList();
    } else {
      return [];
    }
  }

  List<Widget> convertFilesToMessages(List<PlatformFile>? files) {
    if (files != null) {
      return files
          .map((e) => circularMessage(
              fromFriend: false,
              messageType: MessageType.doc,
              file: Document(e.name, e.size, e.extension ?? "")))
          .toList();
    } else {
      return [];
    }
  }

  List<Widget> convertContactsToMessages(List<User>? messages) {
    if (messages != null) {
      return messages
          .map((e) => circularMessage(
              fromFriend: false,
              messageType: MessageType.contact,
              contact: Contact(
                  name: Name(first: e.firstName, last: e.lastName),
                  phones: [Phone(e.phoneNumber)])))
          .toList();
    } else {
      return [];
    }
  }

  Widget convertImageToMessage(String? gifUrl) {
    return circularMessage(
        fromFriend: false, messageType: MessageType.imageMedia, gifUrl: gifUrl);
  }

  Widget convertLocationToMessage(LatLng latLng) {
    return circularMessage(
        fromFriend: false, messageType: MessageType.location, latLng: latLng);
  }

  Widget convertStringToMessage(String text) {
    return circularMessage(
        fromFriend: false, messageType: MessageType.text, message: text);
  }
}

class MainMenu {
  final String text;
  final IconData iconData;
  final String key;

  MainMenu(this.text, this.iconData, this.key);
}
