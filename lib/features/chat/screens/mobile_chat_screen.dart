import 'package:flutter/material.dart';
import 'package:talk_wave/models/user_model.dart';
import 'package:talk_wave/theme.dart';
import '../widgets/chat_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_wave/features/auth/controller/auth_controller.dart';
import 'package:talk_wave/common/widgets/loader.dart';
import 'package:talk_wave/features/chat/widgets/bottom_chat_field.dart';
import 'package:talk_wave/widgets/custom_container.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile_chat_screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const MobileChatScreen(
      {Key? key,
      required this.name,
      required this.uid,
      required this.isGroupChat,
      required this.profilePic})
      : super(key: key);

 /* void makeCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeCall(
          context,
          name,
          uid,
          profilePic,
          isGroupChat,
        );
  } */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      child: Scaffold(
        appBar:     AppBar(
           automaticallyImplyLeading: false,
      title: Row(
        children: [
          
          CircleAvatar(
            radius: 25,
            backgroundImage:  NetworkImage(profilePic),
        ),
           const SizedBox(width: kDefaultPadding * 0.75),
          isGroupChat ? 
          Text(name,style:  Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold,fontSize: 20))
            : StreamBuilder<UserModel>(
                 stream: ref.read(authControllerProvider).userDataById(uid),
                 builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    children: [
                      Text(name ,style:  Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold,fontSize: 20)),
                    const SizedBox(height: 5),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
                      ),
                    ],
                  );
                }),]),
      elevation: 0,
      actions: [
         IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPadding / 2),],
    ) ,
        backgroundColor: Colors.transparent,
      body: CustomContainer(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Expanded(
            child: ChatList(recieverUserId: uid, isGroupChat: isGroupChat),
          ),
          BottomChatField(recieverUserId: uid, isGroupChat: isGroupChat),
        ],
      ),
    ),),);
  }
} 
