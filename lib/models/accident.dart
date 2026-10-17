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
  final AccidentVerificationModel? verification;

  AccidentModel({
    required this.id,
    this.videoUrl = '',
    this.longitude = 0.0,
    this.latitude = 0.0,
    this.address = '',
    this.confidence = 0.0,
    this.severity = '',
    this.status = '',
    this.timestamp,
    this.verification,
  });

  factory AccidentModel.fromJson(Map<String, dynamic> json, String docId) {
    return AccidentModel(
      id: docId,
      videoUrl: json['video_url'] as String? ?? '',
      longitude: _toDouble(json['longitude']),
      latitude: _toDouble(json['latitude']),
      address: json['address'] as String? ?? '',
      confidence: _toDouble(json['confidence']),
      severity: json['severity'] as String? ?? '',
      status: json['status'] as String? ?? '',
      timestamp: _toDateTime(json['timestamp']),
      verification: json['verification'] is Map
          ? AccidentVerificationModel.fromJson(
              Map<String, dynamic>.from(json['verification']),
            )
          : null,
    );
  }

  factory AccidentModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();

    return AccidentModel.fromJson(
      data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
      snap.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_url': videoUrl,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'confidence': confidence,
      'severity': severity,
      'status': status,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
      if (verification != null) 'verification': verification!.toJson(),
    };
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return null;
  }
}

class AccidentVerificationModel {
  final List<String>? alternativeExplanations;
  final double? confidence;
  final List<String>? hazardsDetected;
  final List<String>? incidentTypes;
  final String? reasoningSummary;
  final String? recommendedAction;
  final bool? requiresMoreFrames;
  final String? severity;
  final String? verdict;
  final List<String>? visualEvidence;

  AccidentVerificationModel({
    this.alternativeExplanations,
    this.confidence,
    this.hazardsDetected,
    this.incidentTypes,
    this.reasoningSummary,
    this.recommendedAction,
    this.requiresMoreFrames,
    this.severity,
    this.verdict,
    this.visualEvidence,
  });

  factory AccidentVerificationModel.fromJson(Map<String, dynamic> json) {
    return AccidentVerificationModel(
      alternativeExplanations: _toStringList(json['alternative_explanations']),
      confidence: _toNullableDouble(json['confidence']),
      hazardsDetected: _toStringList(json['hazards_detected']),
      incidentTypes: _toStringList(json['incident_types']),
      reasoningSummary: json['reasoning_summary'] as String?,
      recommendedAction: json['recommended_action'] as String?,
      requiresMoreFrames: json['requires_more_frames'] is bool
          ? json['requires_more_frames'] as bool
          : null,
      severity: json['severity'] as String?,
      verdict: json['verdict'] as String?,
      visualEvidence: _toStringList(json['visual_evidence']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (alternativeExplanations != null)
        'alternative_explanations': alternativeExplanations,
      if (confidence != null) 'confidence': confidence,
      if (hazardsDetected != null) 'hazards_detected': hazardsDetected,
      if (incidentTypes != null) 'incident_types': incidentTypes,
      if (reasoningSummary != null) 'reasoning_summary': reasoningSummary,
      if (recommendedAction != null) 'recommended_action': recommendedAction,
      if (requiresMoreFrames != null)
        'requires_more_frames': requiresMoreFrames,
      if (severity != null) 'severity': severity,
      if (verdict != null) 'verdict': verdict,
      if (visualEvidence != null) 'visual_evidence': visualEvidence,
    };
  }

  static double? _toNullableDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static List<String>? _toStringList(dynamic value) {
    if (value is! List) return null;
    return value.whereType<String>().toList();
  }
}
