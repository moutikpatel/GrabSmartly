import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/screen/home_page/home_page.dart';
import 'package:grabsmartly/src/features/pages/screen/recipe_list/favourites_recipe_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/user_profile/update_profile_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/user_profile/widget/profile_menu_widget.dart';
import 'package:grabsmartly/src/repository/authentication/authentication_repository.dart';
import 'package:grabsmartly/src/strings/string_size.dart';
import 'package:grabsmartly/src/strings/string_text.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';

import '../../../auth/models/user_data_model.dart';
import '../../controllers/controller_profile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  File? imageXFile;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserDataModel? userData = snapshot.data as UserDataModel?;

// Check if userData is not null before accessing its properties
                  if (userData != null) {
                    return Column(
                        children: [
                                   const Stack(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: CircleAvatar(
                                          minRadius: 60.0,
                                          backgroundImage: AssetImage('assets/images_pages/main_screen/man01.png'),
                                        ),
                                      ),


                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    userData.fullName,
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  Text(
                                    userData.email,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                            thickness: 5.0,
                            color: Colors.black54,
                          ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => const UpdateProfileScreen());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: tButtonColor.withOpacity(0.6),
                                        // change button color
                                        side: BorderSide.none,
                                        shape: const StadiumBorder(),
                                      ),
                                      child:  Text(
                                        tEditProfile,
                                        style: Theme.of(context).textTheme.headlineMedium,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(
                                    thickness: 5.0,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // Menu
                                  ProfileMenuWidget(
                                    title: 'Favourite Recipes',
                                    icon: Icons.bookmark,
                                    onPress: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FavouritesRecipeScreen(),
                                          ),

                                      );
                                    },
                                    endIcon: true,
                                  ),
                                  ProfileMenuWidget(
                                    title: tMenu5,
                                    icon: Icons.settings,
                                    onPress: () {},
                                    endIcon: true,
                                  ),

                                  ProfileMenuWidget(
                                    title: tMenu4,
                                    icon: Icons.info,
                                    onPress: () {},
                                    endIcon: true,
                                  ),

                                  ProfileMenuWidget(
                                    title: tMenu1,
                                    icon: Icons.logout_sharp,
                                    onPress: () {
                                      AuthenticationRepository.instance.logout();
                                      Get.to(() => const HomePage());
                                    },
                                    endIcon: false,
                                    textColor: Colors.deepOrange,
                                  ),
                                ],
                    );
                  } else {
                    return const Center(
                      child: Text('User data is null'),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

        ),
      ),
    );
  }
}

