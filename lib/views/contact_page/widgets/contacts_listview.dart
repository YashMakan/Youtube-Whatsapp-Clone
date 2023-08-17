import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/managers/local_db_manager/local_db.dart';
import 'package:whatsapp_redesign/provider/contact_provider.dart';
import 'package:whatsapp_redesign/views/message_page/message_page.dart';
import 'package:whatsapp_redesign/widgets/custom_listtile.dart';
import 'package:whatsapp_redesign/widgets/custom_loader.dart';
import 'package:whatsapp_redesign/widgets/no_data_found.dart';

class ContactsListView extends StatefulWidget {
  final ContactProvider provider;

  const ContactsListView({super.key, required this.provider});

  @override
  State<ContactsListView> createState() => _ContactsListViewState();
}

class _ContactsListViewState extends State<ContactsListView> {
  ContactProvider get provider => widget.provider;

  bool get isLoadingFinished => provider.isLoadingFinished;

  List<Contact> get contacts => provider.contacts;

  List<Contact> get selectedContacts => provider.selectedContacts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoadingFinished && contacts.isEmpty
          ? const Center(
              child: NoDataFound(),
            )
          : contacts.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.only(top: 10),
                  // controller: widget.scrollController,
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
                        participants: [],
                        imageUrl:
                            "https://raw.githubusercontent.com/pixelastic/fakeusers/master/pictures/men/38.jpg",
                        isSelected: provider.isContactSelected(contact),
                        title: contact.displayName,
                        subTitle: contact.phones.first.number,
                        showImage: false,
                        messageCounter: null,
                        onTap: () {
                          if (selectedContacts.isNotEmpty) {
                            setState(() {
                              if (provider.isContactSelected(contact)) {
                                selectedContacts.removeWhere((_contact) =>
                                    _contact.phones
                                        .contains(contact.phones.first.number));
                              } else {
                                selectedContacts.add(contact);
                              }
                            });
                          } else {
                            String phone =
                                contact.phones.first.number.split(' ')[1];
                            provider.manager.getChat(phone).then((chatAndUser) {
                              if (chatAndUser.user == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'The user does not have app installed')));
                                return;
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagePage(
                                            user: chatAndUser.user!,
                                            chatId: chatAndUser.chat?.chatId,
                                          )));
                            });
                          }
                        },
                        onLongPress: () {
                          setState(() {
                            if (provider.isContactSelected(contact)) {
                              selectedContacts.removeWhere((_contact) =>
                                  _contact.phones
                                      .contains(contact.phones.first.number));
                            } else {
                              selectedContacts.add(contact);
                            }
                          });
                        },
                        customListTileType: CustomListTileType.contact,
                        timeFrame: "");
                  })
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CustomLoader()],
                ),
    );
  }
}
