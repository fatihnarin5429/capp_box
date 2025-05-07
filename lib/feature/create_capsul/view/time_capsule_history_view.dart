// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:capp_box/feature/create_capsul/view/capsule_review_view.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import '../widgets/page_title.dart';
import '../widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/step_indicator.dart';

class TimeCapsuleHistoryView extends StatefulWidget {
  final int currentStep;
  final File? videoFile;
  final File? photoFile;
  final File? audioFile;
  final MediaType? type;
  final String? email;
  final String? selectedFileName;

  const TimeCapsuleHistoryView({
    Key? key,
    this.currentStep = 2,
    this.videoFile,
    this.photoFile,
    this.audioFile,
    this.type,
    this.selectedFileName,
    this.email,
  }) : super(key: key);

  @override
  State<TimeCapsuleHistoryView> createState() => _TimeCapsuleHistoryViewState();
}

class _TimeCapsuleHistoryViewState extends State<TimeCapsuleHistoryView> {
  final TextEditingController hourController =
      TextEditingController(text: '00');
  final TextEditingController minuteController =
      TextEditingController(text: '00');
  DateTime? selectedDate;
  bool isHourActive = false;
  bool isMinuteActive = false;

  final List<String> hours =
      List.generate(24, (index) => index.toString().padLeft(2, '0'));
  final List<String> minutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  void _validateAndUpdateTime(TextEditingController controller, int maxValue) {
    String text = controller.text;
    if (text.isEmpty) {
      controller.text = '00';
      setState(() {
        if (controller == hourController) {
          isHourActive = false;
        } else {
          isMinuteActive = false;
        }
      });
      return;
    }

    int? value = int.tryParse(text);
    if (value == null || value < 0 || value >= maxValue) {
      controller.text = '00';
      setState(() {
        if (controller == hourController) {
          isHourActive = false;
        } else {
          isMinuteActive = false;
        }
      });
    } else {
      controller.text = value.toString().padLeft(2, '0');
      setState(() {
        if (controller == hourController) {
          isHourActive = value > 0;
        } else {
          isMinuteActive = value > 0;
        }
      });
    }
  }

  Widget _buildStepIndicator() {
    return StepIndicator(currentStep: widget.currentStep);
  }

  Widget _buildTimeInput(
      TextEditingController controller, bool isActive, int maxValue) {
    return Container(
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFE0AEEC), Color(0xFF445BD1)],
              )
            : null,
        borderRadius: BorderRadius.circular(30),
        border: !isActive ? Border.all(color: const Color(0xFF484E50)) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: 80,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF262742),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Poppins',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (_) {
                _validateAndUpdateTime(controller, maxValue);
                print(controller.text);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButtonWidget(),
                        Expanded(
                          child:
                              PageTitle(title: context.tr('capsule_history')),
                        ),
                      ],
                    ),
                    _buildStepIndicator(),
                    Text(
                      context.tr('capsule_history_message', args: {}),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.tr('capsule_open_date', args: {}),
                      style: const TextStyle(
                        color: Color(0xFFC4C4C4),
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDatePicker(),
                    const SizedBox(height: 32),
                    _buildTimeSection(),
                    const SizedBox(height: 32),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _buildBottomButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    final bool isSelected = selectedDate != null;
    final Color textColor = Colors.white;
    final Color borderColor =
        isSelected ? Colors.transparent : const Color(0xFF484E50);

    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          cancelText: context.tr('cancel_capsule_date'),
          confirmText: context.tr('confirm_capsule_date'),
          builder: _datePickerTheme,
        );
        if (picked != null) {
          setState(() {
            selectedDate = picked;
            print(selectedDate);
          });
        }
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF262742),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? DateFormat('dd.MM.yyyy').format(selectedDate!)
                  : context.tr('select_date', args: {}),
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: 24,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('capsule_open_time'),
          style: const TextStyle(
            color: Color(0xFFC4C4C4),
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTimeInput(hourController, isHourActive, 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF484E50),
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _buildTimeInput(minuteController, isMinuteActive, 60),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return InkWell(
      onTap: () {
        print(
          selectedDate
              ?.add(
                Duration(
                  hours: int.parse(hourController.text),
                  minutes: int.parse(minuteController.text),
                ),
              )
              .millisecondsSinceEpoch
              .toString(),
        );
        context.read<CreateCapsuleBloc>().add(
              CreateCapsuleAction(
                createCapsuleModel: context
                    .read<CreateCapsuleBloc>()
                    .state
                    .createCapsuleModel
                    .copyWith(
                      openedDate: selectedDate
                          ?.add(
                            Duration(
                              hours: int.parse(hourController.text),
                              minutes: int.parse(minuteController.text),
                            ),
                          )
                          .millisecondsSinceEpoch
                          .toString(),
                    ),
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CapsuleReview(
              currentStep: widget.currentStep,
              videoFile: widget.videoFile,
              photoFile: widget.photoFile,
              audioFile: widget.audioFile,
              type: widget.type,
              selectedFileName: widget.selectedFileName,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Center(
          child: Text(
            'Devam Et',
            style: TextStyle(
              color: Color(0xFFE5E5E5),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              height: 1.70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _datePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFA737FF),
          onPrimary: Colors.white,
          surface: Color(0xFF1F2232),
          onSurface: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (child != null)
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: child,
            ),
        ],
      ),
    );
  }
}
