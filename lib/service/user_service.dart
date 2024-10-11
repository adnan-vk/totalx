import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/model/user_model.dart';

class UserService {
  String collection = 'user';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<UserModel> user;
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String downloadUrl = "";

  UserService() {
    user = firestore.collection(collection).withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(
          snapshot.data()!,
        );
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  Future<void> adduser(UserModel data) async {
    try {
      await user.add(data);
    } catch (e) {
      log('Error adding post :$e');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await user.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future getImage({required source}) async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        return File(pickedImage.path);
      } else {
        log("no image  selected");
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      Reference storageReference = storage.child('uploads/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
      log('Image uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  List<UserModel> sortUsersByAge(List<UserModel> users, bool isDescending) {
    users.sort((a, b) =>
        isDescending ? b.age!.compareTo(a.age!) : a.age!.compareTo(b.age!));
    return users;
  }
}
