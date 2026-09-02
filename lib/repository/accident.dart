import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_emergency_services_pannel/models/accident.dart';

class AccidentRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference get _ref => _db.collection("accidents");

  Future<List<AccidentModel>> getAccidentsByStatus(String status) async {
    final snap = await _ref.where("status", isEqualTo: status).get();
    return snap.docs.map((e) => AccidentModel.fromSnapshot(e)).toList();
  }

  Stream<List<AccidentModel>> streamTodayAccidents() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return _ref
        .where(
          "timestamp",
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .where("timestamp", isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (query) =>
              query.docs.map((e) => AccidentModel.fromSnapshot(e)).toList(),
        );
  }

  Future<List<AccidentModel>> getAccidentsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final snap = await _ref
        .where(
          "timestamp",
          isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
        )
        .where("timestamp", isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy("timestamp", descending: true)
        .get();

    return snap.docs.map((e) => AccidentModel.fromSnapshot(e)).toList();
  }

  Future<void> updateAccidentStatus(String id, String status) async {
    await _ref.doc(id).update({"status": status});
  }

  Future<void> deleteAccident(String id) async {
    await _ref.doc(id).delete();
  }
}
