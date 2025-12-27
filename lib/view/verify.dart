// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:log/view/wrapper.dart';
//
//
// class Verify extends StatefulWidget {
//   const Verify({super.key});
//
//   @override
//   State<Verify> createState() => _VerifyState();
// }
//
// class _VerifyState extends State<Verify> {
//   @override
//   void initState(){
//     super.initState();
//     sendVerifyLink();
//   }
//
//   sendVerifyLink()async{
//     final user = FirebaseAuth.instance.currentUser!;
//     if (user != null && !user.emailVerified) { // make sure user exists
//       try {
//         await user.sendEmailVerification();
//         Get.snackbar(
//           'Link sent',
//           'A link has been sent to your email',
//           margin: EdgeInsets.all(30),
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } catch (e) {
//         Get.snackbar(
//           'Error',
//           e.toString(),
//           margin: EdgeInsets.all(30),
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     }
//   }
//
//   reload()async{
//     await FirebaseAuth.instance.currentUser!.reload().then((value)=> {
//       Get.offAll(Wrapper())
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Verification"),
//       ),
//       body: Padding(padding: EdgeInsets.all(28),
//       child: Center(child: Text('Open your mail and click on the link provided to verify email & reload this page'),),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() => reload()),
//       child: Icon(Icons.restart_alt_rounded),),
//     );
//   }
// }
