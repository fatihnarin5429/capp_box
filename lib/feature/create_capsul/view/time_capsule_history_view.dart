import 'dart:io';

import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capp_box/feature/create_capsul/view/capsule_review_view.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import '../widgets/page_title.dart';
import '../widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/step_indicator.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_time_picker.dart';
import '../model/date_time_selection.dart';

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
  DateTimeSelection dateTimeSelection = DateTimeSelection();

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
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    StepIndicator(currentStep: widget.currentStep),
                    _buildDescription(),
                    const SizedBox(height: 16),
                    _buildDateSection(),
                    const SizedBox(height: 32),
                    _buildTimeSection(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _buildContinueButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() => Row(
    children: [
      const BackButtonWidget(),
      Expanded(child: PageTitle(title: context.tr('capsule_history'))),
    ],
  );

  Widget _buildDescription() => Text(
    context.tr('capsule_history_message'),
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
      height: 1.40,
    ),
  );

  Widget _buildDateSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionLabel('capsule_open_date'),
      const SizedBox(height: 12),
      CustomDatePicker(
        selectedDate: dateTimeSelection.selectedDate,
        showPicker: dateTimeSelection.showDatePicker,
        onToggle: _toggleDatePicker,
        onDateSelected: _onDateSelected,
      ),
    ],
  );

  Widget _buildTimeSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionLabel('capsule_open_time'),
      const SizedBox(height: 12),
      CustomTimePicker(
        selectedTime: dateTimeSelection.selectedTime,
        showPicker: dateTimeSelection.showTimePicker,
        onToggle: _toggleTimePicker,
        onTimeChanged: _onTimeChanged,
        onCancel: _onTimeCancel,
        onConfirm: _onTimeConfirm,
      ),
    ],
  );

  Widget _buildSectionLabel(String key) => Text(
    context.tr(key),
    style: const TextStyle(
      color: Color(0xFFC4C4C4),
      fontSize: 14,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w400,
      height: 1.43,
    ),
  );

  Widget _buildContinueButton() => InkWell(
    onTap: _onContinuePressed,
    child: Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
          ),
        ),
      ),
    ),
  );

  void _toggleDatePicker() => setState(() {
    dateTimeSelection = dateTimeSelection.copyWith(
      showDatePicker: !dateTimeSelection.showDatePicker,
      showTimePicker: false,
    );
  });

  void _toggleTimePicker() => setState(() {
    dateTimeSelection = dateTimeSelection.copyWith(
      showTimePicker: !dateTimeSelection.showTimePicker,
      showDatePicker: false,
    );
  });

  void _onDateSelected(DateTime date) {
    setState(() {
      dateTimeSelection = dateTimeSelection.copyWith(selectedDate: date);
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          dateTimeSelection = dateTimeSelection.copyWith(showDatePicker: false);
        });
      }
    });
  }

  void _onTimeChanged(DateTime time) => setState(() {
    dateTimeSelection = dateTimeSelection.copyWith(selectedTime: time);
  });

  void _onTimeCancel() => setState(() {
    dateTimeSelection = dateTimeSelection.copyWith(
      selectedTime: DateTime(2024, 1, 1, 0, 0),
      showTimePicker: false,
    );
  });

  void _onTimeConfirm() => setState(() {
    dateTimeSelection = dateTimeSelection.copyWith(showTimePicker: false);
  });

  void _onContinuePressed() {
    final combinedDateTime = dateTimeSelection.combinedDateTime;
    if (combinedDateTime != null) {
      context.read<CreateCapsuleBloc>().add(
        CreateCapsuleAction(
          context
              .read<CreateCapsuleBloc>()
              .state
              .createCapsuleResponseModel
              .copyWith(
                openDate: combinedDateTime.millisecondsSinceEpoch.toString(),
                recipientEmail: widget.email ?? '',
                recipientPhone: '',
                price: 0,
              ),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => CapsuleReview(
                currentStep: widget.currentStep,
                videoFile: widget.videoFile,
                photoFile: widget.photoFile,
                audioFile: widget.audioFile,
                type: widget.type,
                selectedFileName: widget.selectedFileName,
              ),
        ),
      );
    }
  }
}
