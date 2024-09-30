import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final String USERS_COLLECTION = "users";
final String POSTS_COLLECTION = "posts";

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  FirebaseService();

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref("images/$userId/$fileName").putFile(image);
      return task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _db.collection(USERS_COLLECTION).doc(userId).set({
          "name": name,
          "email": email,
          "image": downloadUrl,
        });
        return true;
      }).catchError((e) {
        print(e);
        return false;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = await getUserData(uid: userCredential.user!.uid);
      if (userCredential.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot doc =
        await _db.collection(USERS_COLLECTION).doc(uid).get();
    return doc.data() as Map;
  }

  Future<bool> postImage(File image) async {
    try {
      String userId = _auth.currentUser!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref("images/$userId/$fileName").putFile(image);
      return task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _db.collection(POSTS_COLLECTION).add({
          "userId": userId,
          "timestamp": Timestamp.now(),
          "image": downloadUrl,
        });
        return true;
      }).catchError((e) {
        print(e);
        return false;
      });
    } catch (e) {
      print(e);
      return true;
    }
  }

  Stream<QuerySnapshot> getPostsForUser() {
    String userId = _auth.currentUser!.uid;
    return _db
        .collection(POSTS_COLLECTION)
        .where("userId", isEqualTo: userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _db
        .collection(POSTS_COLLECTION)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
