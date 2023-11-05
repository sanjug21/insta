
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/resources/Storagemethods.dart';

class AuthMethod{
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String username,
    required String password,
    required String bio,
    required String email,
    required Uint8List? file,
  })async {
    String res="Some error occurred";
    try{
      if(username.isNotEmpty || password.isNotEmpty || bio.isNotEmpty || email.isNotEmpty)
        {
         UserCredential cred=await auth.createUserWithEmailAndPassword(email: email, password: password);

        String photoURL=await StorageMethod().uploadImageToStorage('profilepics', file!, false);

       await firestore.collection('users').doc(cred.user!.uid).set({
        'username':username,
         'uid':cred.user!.uid,
         'email':email,
         'bio':bio,
         'followers':[],
         'following':[],
         'photoURL':photoURL,
       });
       // await firestore.collection('users').add(
       //   {
       //     'username':username,
       //     'uid':cred.user!.uid,
       //     'email':email,
       //     'bio':bio,
       //     'followers':[],
       //     'following':[],
       //   }
       // );
         res='Success!';

        }
    }on FirebaseAuthException catch(err){
      if(err.code=='invalid-email'){
        res='You enter a wrong Email';
      }
      else if (err.code=='weak-password'){
        res='Your password at least of 6 words';
      }
    }
    catch(err){
      res=err.toString();
    }
    return res;
  }

  Future<String> loginUser({required String email,required String password})async{
    String res="Some error occurred";
    try{
     if(email.isNotEmpty||password.isNotEmpty){
       await auth.signInWithEmailAndPassword(email: email, password: password);
       res='Success';
     }
     else{
       res='Please, Enter all the fields.';
     }
    }
    catch(err){
      res=err.toString();
    }
    return res;
  }
}