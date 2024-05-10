// import 'package:firebaseintro/bloc/auth_bloc.dart';
// import 'package:firebaseintro/bloc/auth_event.dart';
// import 'package:firebaseintro/bloc/auth_state.dart';
// import 'package:firebaseintro/models/user_model.dart';
// import 'package:firebaseintro/repository/auth_repository.dart';
// import 'package:firebaseintro/screens/homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({Key? key}) : super(key: key);

//   @override
//   _AuthPageState createState() => _AuthPageState();
// }

// class _AuthPageState extends State {
//   AuthBloc? _authBloc;

//   @override
//   void initState() {
//     super.initState();
//     _authBloc = AuthBloc( AuthRepository());
//   }

//   @override
//   void dispose() {
//     _authBloc?.close();
//     super.dispose();
//   }

//   bool _registerPage = true;

//   final _formKey = GlobalKey<FormState>();

//   String _email = "";
//   String _password = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: BlocProvider(
//         create: (context) => _authBloc!,
//         child: BlocConsumer(
//           bloc: _authBloc!,
//           listener: (context, state) {
//             if (state is AuthSuccess) {
//               if(!_registerPage) { // giriş sayfasında mıyım check ediyourm.
//                   Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Homepage(),

//                 ),
//               );
//               } else { // kayıt olda isem burayı yapıyorum
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text("Kayıt işlemi başarı ile tamamlandı.!"), backgroundColor: Colors.green,));
//               }

//             } else if (state is AuthError) {

//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                     content: Text(state.errorMessage ?? "Bir hata oluştu"), backgroundColor: Colors.red,),
//               );
//             }
//           },
//            builder: (context, state) {
//             return Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Card(
//                       elevation: 8,
//                       margin: const EdgeInsets.all(24),
//                       child: Padding(
//                         padding: const EdgeInsets.all(24.0),
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(24.0),
//                                 child: Text(
//                                   _registerPage ? "Kayıt Ol" : "Giriş Yap",
//                                   style: const TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                               ),
//                               TextFormField(
//                                 decoration:
//                                     const InputDecoration(labelText: "E-posta"),
//                                 autocorrect: false,
//                                 keyboardType: TextInputType.emailAddress,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Lütfen e-posta adresinizi girin';
//                                   }
//                                   return null;
//                                 },
//                                 onSaved: (newValue) => _email = newValue!,
//                               ),
//                               TextFormField(
//                                 decoration:
//                                     const InputDecoration(labelText: "Şifre"),
//                                 autocorrect: false,
//                                 obscureText: true,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Lütfen şifrenizi girin';
//                                   }
//                                   return null;
//                                 },
//                                 onSaved: (newValue) => _password = newValue!,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(24.0),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     if (_formKey.currentState!.validate()) {
//                                       _formKey.currentState!.save();
//                                       _authBloc!.add(_registerPage ? RegisterEvent(_email, _password, UserModel(email: _email, pass: _password)) : LoginEvent(_email, _password, UserModel(email: _email, pass: _password)));
//                                     }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.blue,
//                                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                                   ),
//                                   child: Text(
//                                     _registerPage ? "Kayıt Ol" : "Giriş Yap", style: const TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _formKey.currentState!.reset();
//                                     _registerPage = !_registerPage;
//                                   });
//                                 },
//                                 child: Text(
//                                   _registerPage ? "Zaten üye misiniz? Giriş yap" : "Hesabınız yok mu? Kayıt ol",
//                                   style: const TextStyle(color: Colors.blue),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:firebaseintro/screens/registerpage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebaseintro/screens/homepage.dart';
// import 'package:firebaseintro/screens/loginpage.dart';

// class AuthPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               },
//               child: Text('Giriş Yap'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => RegisterPage()),
//                 );
//               },
//               child: Text('Kayıt Ol'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
