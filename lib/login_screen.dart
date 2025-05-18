import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_adoption/menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login_screen extends StatefulWidget {
  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  Future<void> addUserUidToFirestore(User user) async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    final doc = usersRef.doc(user.uid);

    final snapshot = await doc.get();
    if (!snapshot.exists) {
      await doc.set({
        'uid': user.uid,
      });
    }
  }
  Future<void> signInWithGoogle() async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Start Google sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Navigator.of(context).pop(); // Close loading
        return; // User cancelled sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // Save only UID to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
        }, SetOptions(merge: true));

        Navigator.of(context).pop(); // Close loading

        // Navigate to menu screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => menu_page(
              user.displayName ?? 'User',
              user.photoURL ?? '',
              user.uid,
            ),
          ),
        );
      } else {
        Navigator.of(context).pop(); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-in failed. User is null.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e, stack) {
      Navigator.of(context).pop(); // Ensure dialog closes

      print('Sign-in error: $e');
      print(stack);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-in failed: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // I assume 'nq' is your custom size helper object; make sure it's imported and available
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to Pet adoption',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'gabarito',
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Container(
        color: Colors.teal.shade100,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              top: MediaQuery.of(context).size.height * .15,
              right: _isAnimate ? MediaQuery.of(context).size.width * .15 : -MediaQuery.of(context).size.width * .7,
              width: MediaQuery.of(context).size.width * .7,
              child: Image.asset('assets/images/icon.png'),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .12,
              left: MediaQuery.of(context).size.width * .05,
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .06,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  signInWithGoogle();
                },
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/google.png'),
                ),
                label: Text(
                  'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 17,
                    fontFamily: 'gabarito',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
