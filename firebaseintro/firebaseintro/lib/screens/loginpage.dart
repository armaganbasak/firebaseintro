import 'package:firebaseintro/repository/auth_repository.dart';
import 'package:firebaseintro/screens/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseintro/bloc/auth_bloc.dart';
import 'package:firebaseintro/bloc/auth_event.dart';
import 'package:firebaseintro/bloc/auth_state.dart';
import 'package:firebaseintro/screens/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc _authBloc; 

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(AuthRepository());
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocProvider(
        create: (context) => _authBloc,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const Homepage(),
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? "Bir hata oluştu"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      margin: const EdgeInsets.all(24),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Text(
                                  "Giriş Yap",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: "E-posta"),
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Lütfen e-posta adresinizi girin';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => _email = newValue!,
                              ),
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: "Şifre"),
                                autocorrect: false,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Lütfen şifrenizi girin';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => _password = newValue!,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _authBloc.add(LoginEvent(
                                          _email,
                                          _password,
                                          ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text(
                                    "Giriş Yap",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Hesabın yok mu? Kayıt Ol",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
