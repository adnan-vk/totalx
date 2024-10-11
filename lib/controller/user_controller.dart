import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/model/user_model.dart';
import 'package:totalx/service/user_service.dart';

class UserController extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  UserService userService = UserService();
  List<UserModel> allUsers = [];
  List<UserModel> searchlist = [];
  File? pickedImage;
  String? uploadedImageUrl;
  bool isloading = false;
  final ImagePicker imagePicker = ImagePicker();
  String selectedSortOption = 'All';

  addUser(UserModel data) async {
    await userService.adduser(data);
    clearControllers();
    getProduct();
  }

  Future<void> getProduct() async {
    isloading = true;
    notifyListeners();
    try {
      allUsers = await userService.getAllUsers();
      searchlist = allUsers;
    } catch (e) {
      log("Error fetching users: $e");
    }
    isloading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      searchlist = allUsers;
    } else {
      searchlist = allUsers
          .where(
            (user) => user.name!.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
    notifyListeners();
  }

  clearControllers() {
    nameController.clear();
    ageController.clear();
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imageRef = storageRef.child("user_images/$fileName.jpg");
      final uploadTask = imageRef.putFile(pickedImage!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      uploadedImageUrl = downloadUrl;
      notifyListeners();
      log("Image uploaded successfully. Download URL: $downloadUrl");
    } catch (e) {
      log("Error uploading image: $e");
    }
  }

  void resetImage() {
    pickedImage = null;
    uploadedImageUrl = null;
    notifyListeners();
  }

  Future<void> getUsersAndSort(String sortOption) async {
    allUsers = await userService.getAllUsers();
    if (sortOption == 'Elder') {
      allUsers = userService.sortUsersByAge(allUsers, true);
    } else if (sortOption == 'Younger') {
      allUsers = userService.sortUsersByAge(allUsers, false);
    }
    searchlist = allUsers;
    selectedSortOption = sortOption;

    notifyListeners();
  }
}
