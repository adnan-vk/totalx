import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  String? _uploadedImageUrl;
  bool isloading = false;
  String selectedSortOption = 'All';

  String? get uploadedImageUrl => _uploadedImageUrl;

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

  Future<void> pickImageFromGallery({required source}) async {
    pickedImage = await userService.getImage(source: source);
    if (pickedImage != null) {
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (pickedImage != null) {
      _uploadedImageUrl = await userService.uploadImageToFirebase(pickedImage!);
      notifyListeners();
    }
  }

  void resetImage() {
    pickedImage = null;
    _uploadedImageUrl = null;
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
