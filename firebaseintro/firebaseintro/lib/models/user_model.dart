import 'dart:convert';

class UserModel {
   String? email;
   String? pass;
   String? name;
   String? lname;
   String? avatarURL;

  UserModel({
    this.email,
    this.pass,
    this.name,
    this.lname,
    this.avatarURL,
  });

  get firstName => null;

  UserModel copyWith({
    String? email,
    String? pass,
    String? name,
    String? lname,
    String? avatarURL,
  }) {
    return UserModel(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      name: name ?? this.name,
      lname: lname ?? this.lname,
      avatarURL: avatarURL ?? this.avatarURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'pass': pass,
      'name': name,
      'lname': lname,
      'avatarURL': avatarURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      pass: map['pass'],
      name: map['name'],
      lname: map['lname'],
      avatarURL: map['avatarURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, pass: $pass, name: $name, lname: $lname, avatarURL: $avatarURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.pass == pass &&
      other.name == name &&
      other.lname == lname &&
      other.avatarURL == avatarURL;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      pass.hashCode ^
      name.hashCode ^
      lname.hashCode ^
      avatarURL.hashCode;
  }
}
