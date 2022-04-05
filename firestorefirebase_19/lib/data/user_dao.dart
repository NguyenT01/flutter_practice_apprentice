import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserDao extends ChangeNotifier{
  final auth = FirebaseAuth.instance;
  //TODO: Add helper methods
  //1
  bool isLoggedIn() => auth.currentUser!=null;
  //2
  String? userId()=> auth.currentUser?.uid;
  //3
  String? email()=> auth.currentUser?.email;

  //TODO: Add signUp
  void signup(String email, String password) async{
    try{
      //2
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    }
    on FirebaseAuthException catch(e){
      //4
      if(e.code=='weak-password')
        print('The password provided is too weak');
      else if (e.code=='email-already-in-use')
        print('The account already exists for that email');
    }
    catch(e){
      print(e);
    }
  }

  //TODO: Add login
  void login(String email, String password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    }
    on FirebaseAuthException catch(e){
      if(e.code=='weak-password')
        print('The password provided is too weak');
      else if (e.code=='email-already-in-use')
        print('The account already exists for that email');
    }
    catch(e){
      print(e);
    }
  }

  //TODO: Add logout
  void logout() async{
    await auth.signOut();
    notifyListeners();
  }
}
