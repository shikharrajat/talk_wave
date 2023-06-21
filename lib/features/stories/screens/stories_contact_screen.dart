import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_wave/common/widgets/loader.dart';
import 'package:talk_wave/features/stories/controller/stories_controller.dart';
import 'package:talk_wave/features/stories/screens/confirm_stories_screen.dart';
import 'package:talk_wave/features/stories/screens/stories_screen.dart';
import 'package:talk_wave/models/stories_model.dart';
import 'package:talk_wave/widgets/custom_container.dart';
import 'dart:io';

import '../../../common/utils/utils.dart';

class StatusContactsScreen extends ConsumerWidget {
  final double height;

  const StatusContactsScreen({Key? key, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Column(
      children: [  ListTile(
            title: Text(
              'My Story',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            subtitle: Text(
              'Tap to Add Story',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            leading:  const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
              ),
              radius: 30,
            ),
            onTap: () async {
              File? pickedImage = await pickImageFromGallery(context);
              if (pickedImage != null) {
                Navigator.pushNamed(
                  context,
                  ConfirmStatusScreen.routeName,
                  arguments: pickedImage,
                );
            }
          },
          ),
        CustomContainer(
          height: height * 0.7,
          child: 
              FutureBuilder<List<Status>>(
                future: ref.read(statusControllerProvider).getStatus(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var statusData = snapshot.data![index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                StatusScreen.routeName,
                                arguments: statusData,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                title: Text(
                                  statusData.username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    statusData.profilePic,
                                  ),
                                  radius: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
        ),
      ],
    );
  }
}
  /* ListTile(
            title: Text(
              'My Story',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            subtitle: Text(
              'Tao to Add Story',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            leading:  const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
              ),
              radius: 30,
            ),
          ),       */