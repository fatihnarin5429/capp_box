import 'package:flutter/material.dart';
import '../model/capsule_model.dart';

class CapsuleProvider extends ChangeNotifier {
  List<Capsule> _upcomingCapsules = [];
  List<Capsule> _readyCapsules = [];

  List<Capsule> get upcomingCapsules => _upcomingCapsules;
  List<Capsule> get readyCapsules => _readyCapsules;

  void setCapsules({
    required List<Capsule> upcomingCapsules,
    required List<Capsule> readyCapsules,
  }) {
    _upcomingCapsules = upcomingCapsules;
    _readyCapsules = readyCapsules;
    notifyListeners();
  }
}
