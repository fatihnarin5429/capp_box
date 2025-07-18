import 'package:capp_box/feature/create_capsul/model/get_capsule_response_model.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:capp_box/feature/home/widgets/timer_display_widget.dart';

/// A mixin that provides methods and properties for the HomeView2 screen.
///
/// This mixin encapsulates common functionality related to capsule management
/// and UI interactions for the home screen.
mixin HomeViewMixin<T extends StatefulWidget> on State<T> {
  // gradientController late olarak tanımlanmış, ancak bunu initState'de başlatmak gerekiyor
  late AnimatedMeshGradientController gradientController =
      AnimatedMeshGradientController();

  @override
  void initState() {
    super.initState();
    // gradientController zaten sınıf değişkeni olarak başlatıldı
  }

  @override
  void dispose() {
    gradientController.dispose();
    super.dispose();
  }

  /// Determines if a capsule is ready to be opened based on its openedDate.
  bool isCapsuleReadyToOpen(CapsuleModel capsule) {
    // Açılma tarihi geçmiş mi kontrolü
    if (capsule.openDate == null) return false;

    // openedDate bir String olduğu için DateTime'a çevirip kontrol etmemiz gerekiyor
    try {
      final openDateMillis = int.tryParse(
        capsule.openDate.toString(),
      );
      if (openDateMillis == null) return false;

      final openDate = DateTime.fromMillisecondsSinceEpoch(openDateMillis);
      return DateTime.now().isAfter(openDate);
    } catch (e) {
      return false;
    }
  }

  /// Builds a timer widget for a capsule based on its openedDate.
  Widget buildTimeWidget(CapsuleModel capsule) {
    // Kapsülün açılma tarihine kalan süreyi gösteren widget
    if (capsule.openDate == null) {
      return Center(
        child: Text(
          context.tr('Date_Unknown', args: {}),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    // Kapsülün tam ortasında zamanlayıcı
    return SizedBox(
      width: 90,
      height: 30,
      child: Center(
        child: TimerDisplayWidget(
          openDate: capsule.openDate.toString(),
          isCompact: true,
          fontSize: 10, // Küçük kapsüller için küçük font
        ),
      ),
    );
  }
}
