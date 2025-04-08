import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption/models/chat_user.dart';

class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cloud firestore data base
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //for storing self information
  static late ChatUser me;

  //to return current user
  static get user => auth.currentUser!;

  //for checking if user exists or not?
  static Future<bool> userExists() async{
    return (await firestore
        .collection('users')
        .doc(user!.uid)
        .get())
        .exists;
  }

  //for getting current user info
  static Future<void> getSelfIndfo() async{
    return await firestore
        .collection('users')
        .doc(user!.uid)
        .get().then((value)
         async{
              if(user.exists)
                {
                   me = ChatUser.fromJson(user.data()!);
                }
              else
                {
                     await createUser().then((value) => getSelfIndfo());
                }
          });

  }
  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final chatuser = ChatUser(
      image: user.photoURL.toString(),
      about: "Hey, I'm using We Chat!",
      name: user.displayName.toString(),
      createdAt: time,
      id: user.uid,
      lastActive: time,
      email: user.email.toString(),
      pushToken: '',
      isonline: false,
    );
    return await firestore
        .collection('users')
        .doc(user.uid).set(chatuser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getallUsers()
    {
      return firestore.collection('users').where('id',isNotEqualTo: user.uid) .snapshots();
    }

}
