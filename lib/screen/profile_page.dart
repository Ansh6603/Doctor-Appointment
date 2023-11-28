import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? imageUrl;
  bool isEditing = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    nameController.text = user?.displayName ?? "";
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    if (user != null) {
      try {
        imageUrl = await retrieveProfileImageURL(user!.uid);
        setState(() {});
      } catch (e) {
        //print("Error fetching profile image: $e");
      }
    }
  }

  Future<String?> retrieveProfileImageURL(String userId) async {
    try {
      final ref = FirebaseStorage.instance.ref('profile_images/$userId.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String imagePath = pickedFile.path;

      await uploadImage(imagePath);
    }
  }

  Future<void> uploadImage(String filePath) async {
    if (user != null) {
      try {
        File file = File(filePath);
        String userId = user!.uid;

        await FirebaseStorage.instance
            .ref('profile_images/$userId.jpg')
            .putFile(file);

        imageUrl = await retrieveProfileImageURL(userId);

        setState(() {});
      } catch (e) {
        //print("Error uploading image: $e");
      }
    }
  }

  Future<void> saveProfile() async {
    if (user != null) {
      try {
        await user!.updateDisplayName(nameController.text);
        user = FirebaseAuth.instance.currentUser;
        Navigator.pop(context, user);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile updated successfully!"),
          ),
        );

        setState(() {
          isEditing = false;
        });
      } catch (e) {
        //print("Error updating profile: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: isEditing ? pickImage : null,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : const AssetImage('images/design.png')
                              as ImageProvider<Object>,
                    ),
                  ),
                  if (isEditing)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: pickImage,
                    ),
                ],
              ),
              const SizedBox(height: 32.0),
              _buildProfileField(
                "Name",
                nameController,
                hintText: "Enter your name",
                isEnabled: isEditing,
              ),
              _buildProfileField(
                "Username",
                TextEditingController(text: user?.email),
                isEnabled: false,
              ),
              _buildProfileField(
                "Age",
                ageController,
                hintText: "Enter your age",
                isEnabled: isEditing,
              ),
              const SizedBox(height: 32.0),
              isEditing
                  ? ElevatedButton(
                      onPressed: saveProfile,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text('Save Profile'),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text('Edit Profile'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller,
      {bool isEnabled = true, String hintText = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: isEnabled
                ? TextField(
                    controller: controller,
                    enabled: isEnabled,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                  )
                : TextFormField(
                    controller: controller,
                    enabled: isEnabled,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
