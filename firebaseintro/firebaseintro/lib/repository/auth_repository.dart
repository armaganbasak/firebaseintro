import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      print(error.code);
      String errorMessage = "Giriş Başarısız";

      switch (error.code) {
        case "wrong-password":
          errorMessage = "Şifre hatalı";
          break;
        case "invalid-email":
          errorMessage = "Geçersiz e-posta";
          break;
        case "user-not-found":
          errorMessage = "Kullanıcı bulunamadı";
          break;
        case "invalid-credential":
          errorMessage = "Kimlik bilgileri hatalı, eksik veya süresi dolmuş";
          break;
        case "email-already-in-use":
          errorMessage = "Bu e-posta adresi zaten kullanımda";
          break;
        default:
          break;
      }
      throw errorMessage;
    }
  }

  Future<void> registerUser(String email, String password, String name, String lname) async {
    try {
     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        
      );
      if(userCredential.user != null) {
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("users").doc(userCredential.user!.uid).set({
          'email' : email,
          'name' : name,
          'lname' : lname,
          
        });
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      String errorMessage = "Kayıt başarısız";

      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "Bu e-posta adresi zaten kullanımda";
          break;
        case "invalid-email":
          errorMessage = "Geçersiz e-posta adresi";
          break;
      }
      throw errorMessage;
    }
  }

  

 
}