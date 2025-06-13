import 'package:flutter/material.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'picker_constants.dart';

class CustomTimePicker extends StatelessWidget {
  final DateTime selectedTime;
  final bool showPicker;
  final VoidCallback onToggle;
  final Function(DateTime) onTimeChanged;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CustomTimePicker({
    Key? key,
    required this.selectedTime,
    required this.showPicker,
    required this.onToggle,
    required this.onTimeChanged,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isTimeSelected =
        selectedTime.hour > 0 || selectedTime.minute > 0;
    final Color borderColor =
        isTimeSelected ? Colors.transparent : PickerConstants.borderColor;

    return Column(
      children: [
        _buildTimeButton(borderColor),
        if (showPicker) _buildTimePickerContainer(context),
      ],
    );
  }

  Widget _buildTimeButton(Color borderColor) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: PickerConstants.secondaryBackground,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
              style: PickerConstants.displayStyle,
            ),
            Icon(
              showPicker ? Icons.keyboard_arrow_up : Icons.access_time,
              size: 24,
              color: PickerConstants.textPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(PickerConstants.containerPadding),
      decoration: BoxDecoration(
        color: PickerConstants.primaryBackground,
        borderRadius: BorderRadius.circular(
          PickerConstants.containerBorderRadius,
        ),
        border: Border.all(color: PickerConstants.borderColor, width: 1),
      ),
      child: Column(
        children: [
          SizedBox(
            height: PickerConstants.pickerHeight,
            child: Row(
              children: [
                _buildHourPicker(),
                _buildSeparator(),
                _buildMinutePicker(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHourPicker() {
    return Expanded(
      child: Column(
        children: [
          Text('Saat', style: PickerConstants.labelStyle),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  PickerConstants.itemBorderRadius,
                ),
                color: PickerConstants.secondaryBackground,
              ),
              child: ListWheelScrollView.useDelegate(
                itemExtent: PickerConstants.itemHeight,
                perspective: PickerConstants.wheelPerspective,
                diameterRatio: PickerConstants.wheelDiameterRatio,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  onTimeChanged(
                    DateTime(2024, 1, 1, index, selectedTime.minute),
                  );
                },
                controller: FixedExtentScrollController(
                  initialItem: selectedTime.hour,
                ),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    if (index < 0 || index > 23) return null;
                    return _buildTimeItem(index, index == selectedTime.hour);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinutePicker() {
    return Expanded(
      child: Column(
        children: [
          Text('Dakika', style: PickerConstants.labelStyle),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  PickerConstants.itemBorderRadius,
                ),
                color: PickerConstants.secondaryBackground,
              ),
              child: ListWheelScrollView.useDelegate(
                itemExtent: PickerConstants.itemHeight,
                perspective: PickerConstants.wheelPerspective,
                diameterRatio: PickerConstants.wheelDiameterRatio,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  onTimeChanged(DateTime(2024, 1, 1, selectedTime.hour, index));
                },
                controller: FixedExtentScrollController(
                  initialItem: selectedTime.minute,
                ),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    if (index < 0 || index > 59) return null;
                    return _buildTimeItem(index, index == selectedTime.minute);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: 20,
      alignment: Alignment.center,
      child: const Text(
        ':',
        style: TextStyle(
          color: PickerConstants.gradientStart,
          fontSize: 20,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTimeItem(int value, bool isSelected) {
    return Container(
      height: PickerConstants.itemHeight,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        horizontal: PickerConstants.itemMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PickerConstants.itemBorderRadius),
        gradient: isSelected ? PickerConstants.primaryGradient : null,
      ),
      child: Text(
        value.toString().padLeft(2, '0'),
        style:
            isSelected
                ? PickerConstants.selectedItemStyle
                : PickerConstants.unselectedItemStyle,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              backgroundColor: PickerConstants.borderColor,
              foregroundColor: PickerConstants.textPrimary,
              padding: const EdgeInsets.symmetric(
                vertical: PickerConstants.buttonPadding,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  PickerConstants.buttonBorderRadius,
                ),
              ),
            ),
            child: Text(
              context.tr('cancel_capsule_date'),
              style: PickerConstants.buttonStyle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: PickerConstants.primaryGradient,
              borderRadius: BorderRadius.circular(
                PickerConstants.buttonBorderRadius,
              ),
            ),
            child: TextButton(
              onPressed: onConfirm,
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: PickerConstants.textPrimary,
                padding: const EdgeInsets.symmetric(
                  vertical: PickerConstants.buttonPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    PickerConstants.buttonBorderRadius,
                  ),
                ),
              ),
              child: Text(
                context.tr('confirm_capsule_date'),
                style: PickerConstants.buttonStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
