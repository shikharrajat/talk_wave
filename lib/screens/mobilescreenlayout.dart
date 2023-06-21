
import 'package:flutter/material.dart';

import '../features/chat/widgets/contact_list.dart';
import 'package:talk_wave/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:talk_wave/features/stories/screens/stories_contact_screen.dart';

import 'package:talk_wave/features/group/screens/create_group_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
   
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
          title: Text(
            'TalkWave',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: false,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: IconTheme.of(context).color),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: IconTheme.of(context).color,
              ),
              onPressed: () {
                Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );
              },
            ),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: IconTheme.of(context).color,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    'Create Group',
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                  onTap: () => Future(
                    () => Navigator.pushNamed(
                        context, CreateGroupScreen.routeName),
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    'Log Out',
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
                   
                  },
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          controller: tabBarController,
          indicatorColor: IconTheme.of(context).color,
          indicatorWeight: 2,
          labelColor: IconTheme.of(context).color,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(
              icon: Icon(Icons.message),
              text: 'Chats',
            ),
            Tab(
              icon: Icon(Icons.movie_filter_rounded),
              text: 'stories',
            ),
            Tab(icon: Icon(Icons.call, size: 30), text: 'Calls'),
          ],
        ),
        body: TabBarView(
          controller: tabBarController,
          children: [
            ContactsList(height: height),
            StatusContactsScreen(height: height),
            const Text('Calls')
          ],
        ),
      ),
    );
  }
}
