import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/home/widgets/capsule_card.dart';

import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'dart:async';

class CapsuleListWidget extends StatefulWidget {
  final int selectedIndex;
  final PageController pageController;
  final int currentPage;
  final void Function(int) onPageChanged;
  final CreateCapsuleState state;
  final AnimatedMeshGradientController controller;
  final void Function(BuildContext, {required CreateCapsuleModel capsule})
  onCapsuleTap;

  const CapsuleListWidget({
    Key? key,
    required this.selectedIndex,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
    required this.state,
    required this.controller,
    required this.onCapsuleTap,
  }) : super(key: key);

  @override
  State<CapsuleListWidget> createState() => _CapsuleListWidgetState();
}

class _CapsuleListWidgetState extends State<CapsuleListWidget> {
  late Timer _timer;
  Map<String, String> _timerValues = {};

  @override
  void initState() {
    super.initState();
    _updateAllTimers();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateAllTimers();
    });
  }

  void _updateAllTimers() {
    setState(() {
      final capsules =
          widget.selectedIndex == 3
              ? widget.state.myCreatedCapsules
              : widget.state.filteredCapsules;

      for (var capsule in capsules) {
        if (capsule.openedDate != null) {
          _timerValues[capsule.openedDate!] = _calculateTimeRemaining(
            capsule.openedDate,
          );
        }
      }
    });
  }

  String _calculateTimeRemaining(String? openDateStr) {
    if (openDateStr == null || openDateStr.isEmpty) {
      return "00:00:00";
    }

    try {
      final int openDateMillis = int.parse(openDateStr);
      final DateTime openDate = DateTime.fromMillisecondsSinceEpoch(
        openDateMillis,
      );
      final Duration remaining = openDate.difference(DateTime.now());

      if (remaining.isNegative) {
        return "00:00:00";
      }

      final int hours = remaining.inHours;
      final int minutes = remaining.inMinutes.remainder(60);
      final int seconds = remaining.inSeconds.remainder(60);

      return "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } catch (e) {
      return "00:00:00";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.myCreatedCapsules.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Text(
            context.tr('no_capsules_created'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else if (widget.state.filteredCapsules.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Text(
            widget.selectedIndex == 1
                ? context.tr('coming_soon_capsules_message')
                : widget.selectedIndex == 2
                ? context.tr('ready_to_open_capsules_message')
                : widget.selectedIndex == 3
                ? context.tr('no_capsules_created')
                : context.tr('no_capsules_message'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        child: PageView.builder(
          padEnds: false,
          controller: widget.pageController,
          itemCount:
              widget.selectedIndex == 3
                  ? widget.state.myCreatedCapsules.length
                  : widget.state.filteredCapsules.length,
          onPageChanged: widget.onPageChanged,
          itemBuilder: (context, index) {
            final capsule =
                widget.selectedIndex == 3
                    ? widget.state.myCreatedCapsules[index]
                    : widget.state.filteredCapsules[index];

            final isCurrent = index == widget.currentPage;

            final int? openedDateMillis = int.tryParse(
              capsule.openedDate ?? '',
            );
            final isReadyToOpen =
                openedDateMillis != null &&
                openedDateMillis <= DateTime.now().millisecondsSinceEpoch;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AnimatedScale(
                scale: isCurrent ? 1.0 : 0.9,
                duration: const Duration(milliseconds: 300),
                child: InkWell(
                  onTap: () => widget.onCapsuleTap(context, capsule: capsule),
                  child: CapsuleCard(
                    senderName: capsule.displayName ?? '',
                    imageUrl: "https://placehold.co/40x40",
                    isReadyToOpen: isReadyToOpen,
                    controller: widget.controller,
                    cardSize: CapsuleCardSize.large,
                    timerWidget: Padding(
                      padding: const EdgeInsets.only(bottom: 10, right: 8),
                      child: Text(
                        _timerValues[capsule.openedDate ?? ''] ??
                            _calculateTimeRemaining(capsule.openedDate),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
