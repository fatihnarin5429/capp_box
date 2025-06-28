import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'dart:async';

mixin CapsuleViewMixin<T extends StatefulWidget> on State<T> {
  late final AnimatedMeshGradientController controller =
      AnimatedMeshGradientController();
  int selectedIndex = 0;
  int currentPage = 0;
  Timer? _popupTimer;
  String _currentTimerValue = "00:00:00";

  late final PageController pageController = PageController(
    viewportFraction: 0.9,
  );

  @override
  void initState() {
    // context.read<HomeBloc>().add(HomeGetCapsules());
    controller.start();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    controller.dispose();
    _popupTimer?.cancel();
    super.dispose();
  }

  void showCapsulePopup(
    BuildContext context, {
    required CreateCapsuleModel capsule,
  }) {
    final isReadyToOpen =
        capsule.openedDate != null &&
        int.parse(capsule.openedDate!) <= DateTime.now().millisecondsSinceEpoch;

    final openDate =
        capsule.openedDate != null
            ? DateTime.fromMillisecondsSinceEpoch(
              int.parse(capsule.openedDate!),
            )
            : null;

    // Popup için timer değerini başlat
    if (openDate != null && !isReadyToOpen) {
      _currentTimerValue = calculateTimeRemaining(openDate);
      _startPopupTimer(openDate);
    }

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: const Color(0xFF10101C),
            insetPadding: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF10101C),
                    const Color(0xFF262742).withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        isReadyToOpen
                            ? 'assets/icons/kapsul_without_bg.png'
                            : 'assets/images/kilitkapsul.png',
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.contain,
                      ),
                      if (!isReadyToOpen && openDate != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 8),
                          child: Align(
                            alignment: Alignment.center,
                            child: StatefulBuilder(
                              builder: (context, setInnerState) {
                                _popupTimer?.cancel();
                                _popupTimer = Timer.periodic(
                                  const Duration(seconds: 1),
                                  (timer) {
                                    final newValue = calculateTimeRemaining(
                                      openDate,
                                    );
                                    if (newValue != _currentTimerValue) {
                                      setInnerState(() {
                                        _currentTimerValue = newValue;
                                      });
                                    }
                                  },
                                );

                                return Text(
                                  _currentTimerValue,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    isReadyToOpen
                        ? 'Tebrikler! Kapsülünüz açılmaya hazır'
                        : 'Kapsülünüzün açılma\ntarihi henüz gelmedi.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isReadyToOpen
                        ? 'Hadi hemen ne gönderilmiş kontrol edelim!'
                        : openDate != null
                        ? '${openDate.day.toString().padLeft(2, '0')}.${openDate.month.toString().padLeft(2, '0')}.${openDate.year} tarihinde kapsülü\naçabilirsiniz.'
                        : 'Kapsülün açılma tarihi belirlenmemiş.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      _popupTimer?.cancel();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(1.00, 0.00),
                          end: const Alignment(-1, 0),
                          colors: [
                            const Color(0xFFB224EF),
                            const Color(0xFF7579FF).withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          'Kapat',
                          style: TextStyle(
                            color: Color(0xFFE5E5E5),
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _startPopupTimer(DateTime openDate) {
    _popupTimer?.cancel();
    _popupTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newValue = calculateTimeRemaining(openDate);
      if (newValue != _currentTimerValue && mounted) {
        setState(() {
          _currentTimerValue = newValue;
        });
      }
    });
  }

  String calculateTimeRemaining(DateTime openDate) {
    final Duration remaining = openDate.difference(DateTime.now());

    if (remaining.isNegative) {
      return "00:00:00";
    }

    final int hours = remaining.inHours;
    final int minutes = remaining.inMinutes.remainder(60);
    final int seconds = remaining.inSeconds.remainder(60);

    return "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
