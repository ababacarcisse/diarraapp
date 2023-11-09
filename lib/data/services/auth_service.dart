import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
  final authServiceProvider = Provider((ref) => AuthService());

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   Future<User?> getCurrentUser() {
    return Future.value(_auth.currentUser);
  }
bool isLogged=false;
  Future<bool> signInWithEmailAndPassword({required String email,required String password}) async {
   
    await Future.delayed(const Duration(seconds: 3),() async{
          await _auth.signInWithEmailAndPassword(email: email, 
          password: password);

isLogged=true;
    });
    return isLogged;    
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
  // Ajoutez d'autres méthodes liées à l'authentification ici.
