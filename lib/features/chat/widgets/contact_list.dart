import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:talk_wave/features/select_contacts/screens/select_contact_screen.dart';
import '/common/widgets/loader.dart';
import '/features/chat/controller/chat_controller.dart';
import '/features/chat/screens/mobile_chat_screen.dart';
import '/models/chat_contact.dart';
import 'package:talk_wave/models/group.dart';
import 'package:talk_wave/widgets/custom_container.dart';

class ContactsList extends ConsumerWidget {
  final double height;
  const ContactsList({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomContainer(
      height: height * 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<Group>>(
                stream: ref.watch(chatControllerProvider).chatGroups(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var groupData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MobileChatScreen.routeName,
                                arguments: {
                                  'name': groupData.name,
                                  'uid': groupData.groupId,
                                  'isGroupChat': true,
                                  'profilePic': groupData.groupPic,
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                title: Text(
                                  groupData.name,
                                  style: Theme.of(context)
                  .textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w400,fontSize: 20),
                  
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    groupData.lastMessage,
                                    style:Theme.of(context)
                  .textTheme
                  .bodyMedium!
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    groupData.groupPic,
                                  ),
                                  radius: 30,
                                ),
                                trailing: Text(
                                  DateFormat.Hm().format(groupData.timeSent),
                                  style:Theme.of(context)
                  .textTheme
                  .bodySmall!
                  
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      );
                    },
                  );
                }),
            StreamBuilder<List<ChatContact>>(
                stream: ref.watch(chatControllerProvider).chatContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var chatContactData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MobileChatScreen.routeName,
                                arguments: {
                                  'name': chatContactData.name,
                                  'uid': chatContactData.contactId,
                                  'isGroupChat': false,
                                  'profilePic': chatContactData.profilePic,
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                title: Text(
                                  chatContactData.name,
                                  style: Theme.of(context)
                  .textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w400,fontSize: 20),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    chatContactData.lastMessage,
                                    style: Theme.of(context)
                  .textTheme.bodyMedium!
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    chatContactData.profilePic,
                                  ),
                                  radius: 30,
                                ),
                                trailing: Text(
                                  DateFormat.Hm()
                                      .format(chatContactData.timeSent),
                                  style: Theme.of(context)
                  .textTheme.bodySmall!
                                ),
                              ),
                            ),
                          ),
                         
                        ],
                      );
                    },
                  );
                }),
                Align(
                  alignment: Alignment.bottomRight,
                 
                  child: FloatingActionButton( onPressed: () async {
                             
                              Navigator.pushNamed(context, SelectContactsScreen.routeName);    
                          },
                          elevation: 5,
                          backgroundColor:Theme.of(context).colorScheme.secondary.withAlpha(150),
                          child:  Icon(
                        size:  30 ,                            Icons.person_add_alt_1,
                            color:IconTheme.of(context).color,
                          ),),
                )
                
          ],
          
        ),
      ),
    );
  }
}
