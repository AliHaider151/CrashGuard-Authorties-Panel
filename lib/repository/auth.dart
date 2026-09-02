import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_emergency_services_pannel/models/user.dart';

class AuthRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference get _ref => _db.collection("users");

  Future<UserModel?> login(String email, String password) async {
    final snap = await _ref.where("email", isEqualTo: email).get();
    if (snap.docs.isEmpty) {
      throw Exception("User not found");
    } else {
      // final user = snap.docs.first.data();
      final userModel = UserModel.fromSnapshot(snap.docs.first);
      if (userModel.password != password) {
        throw Exception("Invalid password");
      }
      return userModel;
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final snap = await _ref.where("email", isEqualTo: email).get();
    if (snap.docs.isNotEmpty) {
      throw Exception("User already exists");
    }
    await _ref.doc(email).set({
      "name": name,
      "email": email,
      "password": password,
      "role": role,
    });
  }

  Future<void> updateUser(UserModel user) async {
    await _ref.doc(user.email).update(user.toJson());
  }

  Future<List<UserModel>> getUsers() async {
    final snap = await _ref.get();
    return snap.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  }
}
