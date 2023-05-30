import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/constants/enums.dart';
import 'package:whatsapp_application/models/user.dart';
import 'package:whatsapp_application/views/home_page/widgets/search_bar.dart';
import 'package:whatsapp_application/views/home_page/widgets/status_bar.dart';
import 'package:whatsapp_application/views/profile_page/widgets/setting_tile.dart';
import 'package:whatsapp_application/widgets/custom_listtile.dart';
import 'package:whatsapp_application/widgets/custom_loader.dart';
import 'package:whatsapp_application/widgets/gradient_icon_button.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key, this.scrollController}) : super(key: key);

  final ScrollController? scrollController;

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  List<User> selectedContacts = [];
  List<Contact> initialContacts = [];
  List<Contact> contacts = [];

  bool isContactSelected(Contact contact) => selectedContacts
      .any((_contact) => _contact.phoneNumber == contact.phones.first.number);

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: selectedContacts.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, selectedContacts);
              },
              backgroundColor: Colors.transparent,
              child: const GradientIconButton(size: 55, iconData: Icons.send),
            )
          : const SizedBox(),
      body: SafeArea(
          child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 26,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      isSearch ? "Search" : "Contacts",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: blackColor(context).darkShade),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon:
                          Icon(isSearch ? Icons.close : Icons.search, size: 32),
                      splashRadius: 20,
                      onPressed: () {
                        isSearch = !isSearch;
                        if (!isSearch) {
                          contacts = initialContacts;
                        }
                        setState(() {});
                      },
                      color: greenColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: const Icon(Icons.refresh, size: 32),
                      splashRadius: 20,
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Contacts Refreshed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor:
                                backgroundColor(context, invert: true),
                            textColor: backgroundColor(context));
                        getContacts();
                      },
                      color: greenColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              isSearch
                  ? SearchBar(
                      controller: controller,
                      onChanged: (value) {
                        contacts = initialContacts
                            .where((element) => element.displayName
                                .toLowerCase()
                                .contains(value))
                            .toList();
                        setState(() {});
                      })
                  : selectedContacts.isNotEmpty
                      ? StatusBar(
                          statusList: selectedContacts,
                          addWidget: false,
                          seeAllWidget: false,
                          onNewStatusClicked: () async {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 70),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: context.isDarkMode()
                                            ? Colors.black26
                                            : Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Are you sure to logout ?",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  blackColor(context).darkShade,
                                              fontSize: 19),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        ButtonBar(
                                          buttonPadding: EdgeInsets.zero,
                                          alignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            ElevatedButton(
                                              child: const Text(
                                                'Yes, log out!',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          const Size(150, 30)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          greenColor)),
                                              onPressed: () {},
                                            ),
                                            ElevatedButton(
                                              child: const Text('Cancel',
                                                  style: TextStyle(
                                                      color: greenColor)),
                                              style: ButtonStyle(
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          const Size(100, 30)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          backgroundColor(
                                                              context)),
                                                  side: MaterialStateProperty
                                                      .all(const BorderSide(
                                                          color: greenColor))),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
//                final ImagePicker _picker = ImagePicker();
//                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                          })
                      : Column(
                          children: [
                            const SettingTile(
                                title: "New Group",
                                shouldGreenGlow: true,
                                iconData: Icons.group),
                            SettingTile(
                                title: "New Contact",
                                shouldGreenGlow: true,
                                onTap: () {
                                  FlutterContacts.openExternalInsert()
                                      .then((contact) {});
                                },
                                iconData: Icons.person_add),
                          ],
                        ),
            ],
          ),
          Expanded(
            child: contacts.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    controller: widget.scrollController,
                    itemCount: contacts.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 0.3,
                      );
                    },
                    itemBuilder: (context, index) {
                      Contact contact = contacts[index];
                      return CustomListTile(
                          imageBytes: contact.photoOrThumbnail,
                          imageUrl:
                              "https://raw.githubusercontent.com/pixelastic/fakeusers/master/pictures/men/38.jpg",
                          isSelected: isContactSelected(contact),
                          title: contact.displayName,
                          subTitle: contact.phones.first.number,
                          messageCounter: null,
                          onTap: () {
                            if (selectedContacts.isNotEmpty) {
                              setState(() {
                                if (selectedContacts.any((_contact) =>
                                    _contact.phoneNumber ==
                                    contact.phones.first.number)) {
                                  selectedContacts.removeWhere((_contact) =>
                                      _contact.phoneNumber ==
                                      contact.phones.first.number);
                                } else {
                                  selectedContacts
                                      .add(convertContactToUser(contact));
                                }
                              });
                            }
                          },
                          onLongPress: () {
                            setState(() {
                              if (isContactSelected(contact)) {
                                selectedContacts.removeWhere((_contact) =>
                                    _contact.phoneNumber ==
                                    contact.phones.first.number);
                              } else {
                                selectedContacts
                                    .add(convertContactToUser(contact));
                              }
                            });
                          },
                          customListTileType: CustomListTileType.contact,
                          timeFrame: "");
                    })
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [CustomLoader()],
                  ),
          )
        ],
      )),
    );
  }

  Future<List<Contact>?> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> _contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true, withThumbnail: true);
      setState(() {
        initialContacts = _contacts;
        contacts = _contacts;
      });
    }
    return null;
  }
}

User convertContactToUser(Contact contact) {
  return User.fromJson({
    'email': 'william.david@example.com',
    'gender': 'male',
    'phone_number': contact.phones.first.number,
    'birthdate': 498456350,
    'location': {
      'street': '1507 rue abel-ferry',
      'city': 'aclens',
      'state': 'schaffhausen',
      'postcode': 4583
    },
    'username': 'orangepanda797',
    'password': 'pinkfloyd',
    'first_name': contact.name.first,
    'last_name': contact.name.last,
    'title': 'monsieur',
    'picture':
        'https://raw.githubusercontent.com/pixelastic/fakeusers/master/pictures/men/38.jpg'
  });
}
