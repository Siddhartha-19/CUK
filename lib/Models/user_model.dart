import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User_model {
  late String user_id;
  User_model({required this.user_id});
  CollectionReference users_db = FirebaseFirestore.instance.collection("Users");
  Future<void> Create_user(String name, String email, String user_name) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await users_db
          .doc(uid)
          .set({"user_name": user_name, "name": name, "email": email});
      final DocumentSnapshot user_names_snapshot =
          await users_db.doc('usernames').get();
      Map user_names_map =
          ((user_names_snapshot.data() as Map)["user_names"] as Map);
      user_names_map[user_name] = 1;
      await users_db.doc('usernames').update({"user_names": user_names_map});
    }
    return;
  }

  Future Get_user_data(String uid) async {
    try {
      DocumentSnapshot usersdata_snapshot = await users_db.doc(uid).get();
      Map data_map = usersdata_snapshot.data as Map;
      String name = data_map["name"];
      String email = data_map["email"];
      String username = data_map["user_name"];
      String profile_url = data_map["profile_image"];
      return [name, email, username, email, profile_url];
    } catch (e) {
      return null;
    }
  }
}
