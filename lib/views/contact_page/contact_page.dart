import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/models/user.dart';
import 'package:whatsapp_redesign/provider/contact_provider.dart';
import 'package:whatsapp_redesign/views/contact_page/widgets/contacts_listview.dart';
import 'package:whatsapp_redesign/views/home_page/widgets/contact_bar.dart';
import 'package:whatsapp_redesign/views/home_page/widgets/search_bar.dart';
import 'package:whatsapp_redesign/views/home_page/widgets/status_bar.dart';
import 'package:whatsapp_redesign/views/profile_page/widgets/setting_tile.dart';
import 'package:whatsapp_redesign/widgets/custom_listtile.dart';
import 'package:whatsapp_redesign/widgets/custom_loader.dart';
import 'package:whatsapp_redesign/widgets/gradient_icon_button.dart';
import 'package:whatsapp_redesign/widgets/no_data_found.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key, this.scrollController}) : super(key: key);

  final ScrollController? scrollController;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactProvider? provider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider = Provider.of<ContactProvider>(context, listen: false);
      provider!.getContacts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: Consumer<ContactProvider>(
        builder: (context, provider, child) => provider
                .selectedContacts.isNotEmpty
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context, provider.selectedContacts);
                },
                backgroundColor: Colors.transparent,
                child: const GradientIconButton(size: 55, iconData: Icons.send),
              )
            : const SizedBox(),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => SafeArea(
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
                        provider.isSearch ? "Search" : "Contacts",
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
                        icon: Icon(
                            provider.isSearch ? Icons.close : Icons.search,
                            size: 32),
                        splashRadius: 20,
                        onPressed: () {
                          provider.toggleSearch();
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
                          provider.getContacts();
                        },
                        color: greenColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                provider.isSearch
                    ? SearchBarWidget(
                        controller: provider.controller,
                        onChanged: (value) {
                          provider.onContactSearch(value);
                        })
                    : provider.selectedContacts.isNotEmpty
                        ? ContactBar(
                            contactList: provider.selectedContacts,
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
                                                color: blackColor(context)
                                                    .darkShade,
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
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                150, 30)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(greenColor)),
                                                onPressed: () {},
                                              ),
                                              ElevatedButton(
                                                child: const Text('Cancel',
                                                    style: TextStyle(
                                                        color: greenColor)),
                                                style: ButtonStyle(
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                100, 30)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                                backgroundColor(
                                                                    context)),
                                                    side: MaterialStateProperty
                                                        .all(const BorderSide(
                                                            color:
                                                                greenColor))),
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
            ContactsListView(provider: provider)
          ],
        )),
      ),
    );
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
