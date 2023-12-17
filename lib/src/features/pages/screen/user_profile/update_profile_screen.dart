import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/models/user_data_model.dart';
import 'package:grabsmartly/src/features/pages/controllers/controller_profile.dart';
import 'package:grabsmartly/src/features/pages/screen/user_profile/profile_screen.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';
import 'package:grabsmartly/src/strings/string_text.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../strings/string_size.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(tEditProfile, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserDataModel userData = snapshot.data as UserDataModel;
                  return Column(
                    children: [
                      const SizedBox(height: 50),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: userData.fullName,
                              decoration: const InputDecoration(
                                labelText: tFullName,
                                prefixIcon: Icon(Icons.person_outline_rounded),
                              ),
                              onSaved: (value) {
                                // Update the user's full name
                                userData.fullName = value!;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              initialValue: userData.email,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: tEmail,
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              initialValue: userData.phoneNo,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: tPhoneNumber,
                                prefixIcon: Icon(Icons.phone_outlined),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              initialValue: userData.password,
                              obscureText: _obscurePassword, // Use a variable to toggle visibility
                              decoration: InputDecoration(
                                labelText: tPassword,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    // Toggle the visibility of the password
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              onSaved: (value) {
                                // Update the user's password
                                userData.password = value!;
                              },
                            ),

                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Save the form
                                  _formKey.currentState?.save();

                                  // Update the user profile in Firestore
                                  controller.updateUserProfile(userData);

                                  // Navigate back to the profile screen
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: tButtonColor.withOpacity(0.6),
                                  side: BorderSide.none,
                                  shape: const StadiumBorder(),
                                ),
                                child: Text(
                                  'Update Profile',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
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
