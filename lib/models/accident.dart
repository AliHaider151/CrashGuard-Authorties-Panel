import 'package:cloud_firestore/cloud_firestore.dart';

class AccidentModel {
  final String id;
  final String videoUrl;
  final double longitude;
  final double latitude;
  final String address;
  final double confidence;
  final String severity;
  final String status;
  final DateTime? timestamp;

  AccidentModel({
    required this.id,
    required this.videoUrl,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.confidence,
    required this.severity,
    required this.status,
    required this.timestamp,
  });

  // --------------------------
  // FROM JSON
  // --------------------------
  factory AccidentModel.fromJson(Map<String, dynamic> json, String docId) {
    return AccidentModel(
      id: docId,
      videoUrl: json['video_url'] ?? '',
      longitude: (json['longitude'] ?? 0).toDouble(),
      latitude: (json['latitude'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      confidence: (json['confidence'] ?? 0).toDouble(),
      severity: json['severity'] ?? '',
      status: json['status'] ?? '',
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  // --------------------------
  // FROM FIRESTORE SNAPSHOT
  // --------------------------
  factory AccidentModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return AccidentModel.fromJson(data, snap.id);
  }

  // --------------------------
  // TO JSON
  // --------------------------
  Map<String, dynamic> toJson() {
    return {
      "video_url": videoUrl,
      "longitude": longitude,
      "latitude": latitude,
      "address": address,
      "confidence": confidence,
      "severity": severity,
      "status": status,
      "timestamp": timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}
