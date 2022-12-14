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
          'userImage': imagePath,
          'coins': []
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
          'userImage': imagePath,
          'coins': []
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
          'userImage': imagePath,
          'coins': []
        });
      }
      return "filedUploaded";
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  getpostList(postId) async {
    List post = [];

    try {
      if (postId != null) {
        await FirebaseFirestore.instance
            .collection('posts')
            .orderBy("postedAt", descending: true)
            .where('id', isEqualTo: postId)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((element) {
            post.add(element);
            print(post.first['userName']);
          });
        });
      } else {
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
      }

      return post;
    } catch (e) {
      return null;
    }
  }

  getSearchPostList(postId, type) async {
    List post = [];

    try {
      if (type == 'date') {
        final Timestamp now = Timestamp.fromDate(DateTime.now());
        final Timestamp yesterday = Timestamp.fromDate(
          DateTime.now().subtract(const Duration(days: 1)),
        );

        await FirebaseFirestore.instance
            .collection('posts')
            .where('postedAt', isLessThan: now, isGreaterThan: yesterday)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((element) {
            post.add(element);
          });
        });
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .where('postType', isEqualTo: postId)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((element) {
            post.add(element);
          });
        });
      }

      return post;
    } catch (e) {
      return null;
    }
  }

  getUserList(id) async {
    List user = [];

    try {
      if (id == null) {
        String? userId = await UserSecureStorage.fetchToken();
        await FirebaseFirestore.instance
            .collection('users')
            .where("uid", isNotEqualTo: userId)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((element) {
            print(element);
            user.add(element);
          });
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .where("fullName", isEqualTo: id)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((element) {
            print(element);
            user.add(element);
          });
        });
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  getCategoryList() async {
    List category = [];

    try {
      String? userId = await UserSecureStorage.fetchToken();
      await FirebaseFirestore.instance
          .collection('category')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print(element);
          category.add(element);
        });
      });

      return category;
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

  giveCoin(id, userId, postedBy) async {
    try {
      print("typed");
      ////COIN GIVER
      final equipmentCollection =
          FirebaseFirestore.instance.collection("users").doc(userId);

      final docSnap = await equipmentCollection.get();

      var queue = docSnap.get('coins');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({"coins": queue - 1});
////TAKER COINS
      final a = FirebaseFirestore.instance.collection("users").doc(postedBy);

      final b = await a.get();

      var c = b.get('coins');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(postedBy)
          .update({"coins": c + 1});

      await FirebaseFirestore.instance.collection('posts').doc(id).update({
        "coins": FieldValue.arrayUnion([userId])
      });
      return "Updated";
    } catch (e) {
      return null;
    }
  }

  giveCoinFromAd(id, userId, postedBy) async {
    try {
////TAKER COINS
      final a = FirebaseFirestore.instance.collection("users").doc(postedBy);

      final b = await a.get();

      var c = b.get('coins');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(postedBy)
          .update({"coins": c + 1});

      await FirebaseFirestore.instance.collection('posts').doc(id).update({
        "coins": FieldValue.arrayUnion([userId])
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

  getSearchUserList(region, prefecture, city, gender, userType, startingAge,
      endingAge) async {
    List user = [];

    try {
      String? userId = await UserSecureStorage.fetchToken();

      await FirebaseFirestore.instance
          .collection('users')
          .where(
            "region",
            isEqualTo: region,
          )
          .where(
            "perfecture",
            isEqualTo: prefecture,
          )
          .where(
            "city",
            isEqualTo: city,
          )
          .where(
            "gender",
            isEqualTo: gender,
          )
          .where(
            "userType",
            isEqualTo: userType,
          )
          .where("age",
              isGreaterThanOrEqualTo: startingAge,
              isLessThanOrEqualTo: endingAge)
          // .where('uid', isNotEqualTo: userId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          user.add(element);
        });
      });
      print("AFTER CALLING FUNCTION");
      print(user);

      return user;
    } catch (e) {
      return null;
    }
  }
}
