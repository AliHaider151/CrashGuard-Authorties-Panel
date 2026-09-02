import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/models/accident.dart';
import 'package:fyp_emergency_services_pannel/repository/accident.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/snack_bar.dart';

class AccidentProvider with ChangeNotifier {
  StreamSubscription<List<AccidentModel>>? _accidentSub;
  bool isLoading = false;
  bool isUpdatingStatus = false;
  String updatingStatusId = "";
  AccidentProvider() {
    listenTodayAccidents();
  }

  DateTime? startDate;
  DateTime? endDate;

  @override
  void dispose() {
    _accidentSub?.cancel();
    super.dispose();
  }

  final todayAccident = <AccidentModel>[];
  List<AccidentModel> get submittedReported {
    return todayAccident
        .where((element) => (element.status).toLowerCase() == 'resolved')
        .toList();
  }

  List<AccidentModel> get pendingAccidets {
    return todayAccident
        .where((element) => (element.status).toLowerCase() != 'resolved')
        .toList();
  }

  final rangeAccidents = <AccidentModel>[];

  void listenTodayAccidents() {
    _accidentSub?.cancel();
    _accidentSub = AccidentRepository().streamTodayAccidents().listen((
      records,
    ) {
      todayAccident
        ..clear()
        ..addAll(records);

      notifyListeners();
    });
  }

  Future<void> getRoangeLogs(DateTime startDate, DateTime endDate) async {
    try {
      isLoading = true;
      notifyListeners();
      final logs = await AccidentRepository().getAccidentsByDateRange(
        startDate,
        endDate,
      );
      rangeAccidents
        ..clear()
        ..addAll(logs);
      notifyListeners();
    } catch (e) {
      showSnackbar(true, e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccident(String id) async {
    try {
      isLoading = true;
      notifyListeners();
      await AccidentRepository().deleteAccident(id);
      showSnackbar(false, "Accident deleted successfully");
    } catch (e) {
      showSnackbar(true, e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAccidentStatus(String id, String status) async {
    try {
      isUpdatingStatus = true;
      notifyListeners();
      await AccidentRepository().updateAccidentStatus(id, status);
      showSnackbar(false, "Accident status updated successfully");
    } catch (e) {
      showSnackbar(true, e.toString());
    } finally {
      isUpdatingStatus = false;
      notifyListeners();
    }
  }

  Future<void> updateDateRange(DateTime? start, DateTime? end) async {
    startDate = start;
    endDate = end;

    if (start != null && end != null) {
      await getRoangeLogs(start, end);
    }
    notifyListeners();
  }
}
