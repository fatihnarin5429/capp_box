import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';

class TimerDisplayWidget extends StatefulWidget {
  final String? openDate;
  final bool isCompact;
  final double? fontSize;

  const TimerDisplayWidget({
    super.key,
    this.openDate,
    this.isCompact = false,
    this.fontSize,
  });

  @override
  State<TimerDisplayWidget> createState() => _TimerDisplayWidgetState();
}

class _TimerDisplayWidgetState extends State<TimerDisplayWidget> {
  int _remainingTimeInSeconds = 0;
  late Timer _timer;
  late DateTime _targetDate;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    try {
      if (widget.openDate != null) {
        // If openDate is directly provided to the widget
        int openDateMillis = int.parse(widget.openDate!);
        _targetDate = DateTime.fromMillisecondsSinceEpoch(openDateMillis);
        _calculateRemainingTime();
        _startTimer();
        _isLoaded = true;
      } else {
        // Get the current capsule model from the bloc if openDate is not provided
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final capsuleBloc = context.read<CreateCapsuleBloc>();
          final openDateStr =
              capsuleBloc
                  .state
                  .createCapsuleResponseModel
                  .data
                  ?.capsule
                  ?.openDate;

          if (openDateStr != null && openDateStr.toString().isNotEmpty) {
            int openDateMillis = int.parse(openDateStr.toString());
            _targetDate = DateTime.fromMillisecondsSinceEpoch(openDateMillis);
            _calculateRemainingTime();
            _startTimer();
            setState(() {
              _isLoaded = true;
            });
          } else {
            // Fallback to default date (1 hour from now)
            _targetDate = DateTime.now().add(const Duration(hours: 1));
            _calculateRemainingTime();
            _startTimer();
            setState(() {
              _isLoaded = true;
            });
          }
        });
      }
    } catch (e) {
      // Fallback to default date (1 hour from now) on any error
      _targetDate = DateTime.now().add(const Duration(hours: 1));
      _calculateRemainingTime();
      _startTimer();
      setState(() {
        _isLoaded = true;
      });
    }
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    final difference = _targetDate.difference(now);

    if (difference.isNegative) {
      _remainingTimeInSeconds = 0; // Already expired
    } else {
      _remainingTimeInSeconds = difference.inSeconds;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTimeInSeconds > 0) {
          _remainingTimeInSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    if (_isLoaded) {
      _timer.cancel();
    }
    super.dispose();
  }

  String get hours =>
      (_remainingTimeInSeconds ~/ 3600).toString().padLeft(1, '0');
  String get minutes =>
      ((_remainingTimeInSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
  String get seconds =>
      (_remainingTimeInSeconds % 60).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Color(0xFF80B0C4),
            strokeWidth: 2,
          ),
        ),
      );
    }

    // Compact version for capsule cards (like in the image)
    if (widget.isCompact) {
      // Get font size based on widget parameter or default
      final double textSize = widget.fontSize ?? 20;

      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF000000).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '$hours:$minutes:$seconds',
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
      );
    }

    // Original version for larger displays
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$hours:',
                  style: const TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 12.33,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: 0.12,
                  ),
                ),
                const Text(
                  'Saat',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 3,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$minutes:',
                  style: const TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 10.33,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.12,
                  ),
                ),
                const Text(
                  'Dakika',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 3,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  seconds,
                  style: const TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 10.33,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.12,
                  ),
                ),
                const Text(
                  'Saniye',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 3,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
