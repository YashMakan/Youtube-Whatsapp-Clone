import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:giphy_api_client/giphy_api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/models/document.dart';
import 'package:whatsapp_application/models/user.dart';
import 'package:whatsapp_application/views/message_page/message_page_widgets.dart';
import 'package:whatsapp_application/widgets/common_widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../constants/colors.dart';
import '../../helper/size_config.dart';

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
  bool isMenuPopupOpened = false;
  TextEditingController messageController = TextEditingController();
  TextEditingController gifController = TextEditingController();
  final client = GiphyClient(apiKey: 'NMFj5k2Slp67Tg2lSUANshwMFS9qTiB1');
  final ItemScrollController  scrollController = ItemScrollController();
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
          imageMedia: "https://i.giphy.com/media/oOTTyHRHj0HYY/giphy.webp"),
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
        file: Document("arts.zip", 3258421, "zip")
      ),
    ];
  }

  @override
  void initState() {
    getMessages();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollToBottom();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Column(
        children: [
          headerSection(context, widget.user),
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
                                        setState(() {
                                          isRecordingStarted = true;
                                        });
                                      },
                                      onLongPressEnd: (details) {
                                        if (details.localPosition.dx > 50) {
                                          print("canceled");
                                        }
                                        setState(() {
                                          isRecordingStarted = false;
                                        });
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
                                    return Image.network(
                                      gifs[index]?.images?.original?.url ?? "",
                                      width: 50,
                                      height: 30,
                                      fit: BoxFit.cover,
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

  scrollToBottom(){
    scrollController.scrollTo(index: messages.length, duration: const Duration(milliseconds: 600));
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
                            Widget message = circularMessage(fromFriend: false, messageType: MessageType.imageMedia, imageMedia: await image.readAsBytes());
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
                            var _messages = images.map((image) async => circularMessage(fromFriend: false, messageType: MessageType.imageMedia, imageMedia: await image.readAsBytes())).toList();
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
                          break;
                        case "location":
                          break;
                        case "contact":
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
