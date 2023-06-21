import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_wave/features/group/screens/create_group_screen.dart';
import '/common/widgets/error.dart';
import '/common/widgets/loader.dart';
import 'package:talk_wave/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';
  const SelectContactsScreen({Key? key}) : super(key: key);

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.8),
      title: Text(
        'Select Contact',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
      elevation: 0,
      actions: [
        IconButton(
              icon: Icon(Icons.search, color: IconTheme.of(context).color ),
              onPressed: () {},
            ),
        PopupMenuButton(
              icon:  Icon(
                Icons.more_vert,
                color: IconTheme.of(context).color ,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child:  Text(
                    'Create Group',
                    style: Theme.of(context)
                  .textTheme
                  .bodyLarge!,
                  ),
                  onTap: () => Future(
                    () => Navigator.pushNamed(
                        context, CreateGroupScreen.routeName),
                  ),
                )
              ],
            ),
      ],
      
    ),
      body: 
       ref.watch(getContactsProvider).when(
              data: (contactList) => ListView.builder(
                  itemCount: contactList.length,
                  itemBuilder: (context, index) {
                    final contact = contactList[index];
                    return InkWell(
                      onTap: () => selectContact(ref, contact, context),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            contact.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          leading: contact.photo == null
                              ? null
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                  radius: 30,
                                ),
                        ),
                      ),
                    );
                  }),
              error: (err, trace) => ErrorScreen(error: err.toString()),
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
