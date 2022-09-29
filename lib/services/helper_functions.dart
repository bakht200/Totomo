import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

import '../constants/secure_storage.dart';

class HelperFunction {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // getUserInfo(String email) async {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .where("email", isEqualTo: email)
  //       .get()
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  getAllUsers() async {
    String? userId = await UserSecureStorage.fetchToken();
    print(userId);
    return FirebaseFirestore.instance
        .collection("users")
        .where('uid', isNotEqualTo: userId)
        .get();
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('fullName', isEqualTo: searchField)
        .get();
  }

  Future<bool>? addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String? chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String? chatRoomId, chatMessageData) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String? itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  getUserInformation() async {
    List userData = [];

    try {
      String? userId = await UserSecureStorage.fetchToken();

      await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: userId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          userData.add(element);
        });
      });

      return userData;
    } catch (e) {
      return null;
    }
  }

  getPost() async {
    List userData = [];

    try {
      String? userId = await UserSecureStorage.fetchToken();

      await FirebaseFirestore.instance
          .collection('posts')
          .where('postedBy', isEqualTo: userId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          userData.add(element);
        });
      });

      return userData;
    } catch (e) {
      return null;
    }
  }

  Future uploadFile(
      List<File>? file, descriptionController, postType, imagePath) async {
    try {
      print("IN UPLOAD FUNCTION");
      if (file == null) {
        print("HERE");
        User? user = FirebaseAuth.instance.currentUser;
        String? userName = await UserSecureStorage.fetchUserName();
        var uniqueId = FirebaseFirestore.instance.collection("posts").doc().id;

        await FirebaseFirestore.instance.collection("posts").doc(uniqueId).set({
          'postedBy': user!.uid,
          'userName': userName,
          'mediaUrl': '',
          'like': [],
          'comment': [],
          'report': [],
          'postedAt': DateTime.now(),
          'description': descriptionController,
          'id': uniqueId,
          'postType': postType,
          'userImage': imagePath
        });
      } else {
        print("in else condition");
        List<String> url = [];

        User? user = FirebaseAuth.instance.currentUser;

        final path = firebaseStorage.FirebaseStorage.instance
            .ref("datingApp/${user!.uid}");

        for (var i = 0; i < file.length; i++) {
          final child = path.child(DateTime.now().toString());
          await child.putFile(File(file[i].path));
          await child.getDownloadURL().then((value) => {url.add(value)});
        }

        String? userName = await UserSecureStorage.fetchUserName();
        var uniqueId = FirebaseFirestore.instance.collection("posts").doc().id;

        await FirebaseFirestore.instance.collection("posts").doc(uniqueId).set({
          'postedBy': user.uid,
          'userName': userName,
          'mediaUrl': url,
          'like': [],
          'comment': [],
          'report': [],
          'postedAt': DateTime.now(),
          'description': descriptionController,
          'id': uniqueId,
          'postType': postType,
          'userImage': imagePath
        });
      }
      return "filedUploaded";
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future cameraPost(
      File file, descriptionController, postType, imagePath) async {
    try {
      {
        print("HERE IN cAMERA");
        List<String> url = [];

        User? user = FirebaseAuth.instance.currentUser;

        final path = firebaseStorage.FirebaseStorage.instance
            .ref("datingApp/${user!.uid}");

        final child = path.child(DateTime.now().toString());
        await child.putFile(File(file.path));
        await child.getDownloadURL().then((value) => {url.add(value)});

        String? userName = await UserSecureStorage.fetchUserName();
        var uniqueId = FirebaseFirestore.instance.collection("posts").doc().id;

        await FirebaseFirestore.instance.collection("posts").doc(uniqueId).set({
          'postedBy': user.uid,
          'userName': userName,
          'mediaUrl': url,
          'like': [],
          'comment': [],
          'report': [],
          'postedAt': DateTime.now(),
          'description': descriptionController,
          'id': uniqueId,
          'postType': postType,
          'userImage': imagePath
        });
      }
      return "filedUploaded";
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  getpostList() async {
    List post = [];

    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .orderBy("postedAt", descending: true)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          post.add(element);
          print(post.first['userName']);
        });
      });

      return post;
    } catch (e) {
      return null;
    }
  }

  getUserList() async {
    List user = [];

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .orderBy("age", descending: true)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print(element);
          user.add(element);
        });
      });

      return user;
    } catch (e) {
      return null;
    }
  }

  getSearchNameList(name) async {
    List user = [];

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('fullName', isEqualTo: name)
          .orderBy("age", descending: true)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print(element);
          user.add(element);
        });
      });

      return user;
    } catch (e) {
      return null;
    }
  }

  addComment(id, commentText, userName) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(id).update({
        "comment": FieldValue.arrayUnion([
          {
            'commentedBy': userName,
            'commentText': commentText,
            'commentedAt': DateTime.now()
          }
        ])
      });
      print("HERE");
      return "Commented";
    } catch (e) {
      return null;
    }
  }

  likepost(id, userId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(id).update({
        "like": FieldValue.arrayUnion([userId])
      });
      return "Updated";
    } catch (e) {
      return null;
    }
  }

  unLikePost(id, userId) async {
    try {
      final equipmentCollection =
          FirebaseFirestore.instance.collection("posts").doc(id);

      final docSnap = await equipmentCollection.get();

      List queue = docSnap.get('like');

      if (queue.contains(userId) == true) {
        equipmentCollection.update({
          "like": FieldValue.arrayRemove([userId])
        });
      }
      return "Updated";
    } catch (e) {
      return null;
    }
  }
}
