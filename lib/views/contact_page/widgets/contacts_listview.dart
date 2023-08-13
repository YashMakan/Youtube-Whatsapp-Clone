import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/managers/local_db_manager/local_db.dart';
import 'package:whatsapp_redesign/provider/contact_provider.dart';
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
                            // check if user exists in the db
                            provider.manager.isUserExist(uuid: LocalDB.user.uuid).then((exists) {
                              if(exists) {
                                // fetch user and navigate to chat screen
                              } else {
                                // show a prompt that user does not have app installed
                              }
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
