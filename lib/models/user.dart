import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String role;

  UserModel({
    required this.email,
    required this.password,
    required this.role,
    required this.name,
  });

  // Convert to Map (useful for Firebase)
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'role': role, 'name': name};
  }

  // Create from Map
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? '',
      name: map['name'] ?? map['email'].split('@').first,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }
}
