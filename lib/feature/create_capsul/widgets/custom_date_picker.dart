import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'picker_constants.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final bool showPicker;
  final VoidCallback onToggle;
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    Key? key,
    required this.selectedDate,
    required this.showPicker,
    required this.onToggle,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.selectedDate != null;
    final Color borderColor =
        isSelected ? Colors.transparent : PickerConstants.borderColor;

    return Column(
      children: [
        _buildDateButton(context, borderColor),
        if (widget.showPicker) _buildDatePickerContainer(),
      ],
    );
  }

  Widget _buildDateButton(BuildContext context, Color borderColor) {
    return InkWell(
      onTap: widget.onToggle,
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
              widget.selectedDate != null
                  ? DateFormat('dd.MM.yyyy').format(widget.selectedDate!)
                  : context.tr('select_date', args: {}),
              style: PickerConstants.displayStyle,
            ),
            Icon(
              widget.showPicker
                  ? Icons.keyboard_arrow_up
                  : Icons.calendar_today,
              size: 24,
              color: PickerConstants.textPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerContainer() {
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
      child: Stack(
        children: [
          SfDateRangePicker(
            controller: _controller,
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedDate: widget.selectedDate,
            minDate: DateTime.now(),
            maxDate: DateTime(2100),
            backgroundColor: PickerConstants.primaryBackground,
            view: DateRangePickerView.month, // Sadece ay görünümü
            allowViewNavigation: false, // View değiştirmeyi engelle
            headerStyle: const DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: PickerConstants.titleStyle,
              backgroundColor: PickerConstants.primaryBackground,
            ),
            monthViewSettings: const DateRangePickerMonthViewSettings(
              dayFormat: 'EEE',
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: PickerConstants.labelStyle,
              ),
              weekendDays: [6, 7],
            ),
            monthCellStyle: const DateRangePickerMonthCellStyle(
              textStyle: PickerConstants.unselectedItemStyle,
              weekendTextStyle: PickerConstants.unselectedItemStyle,
              disabledDatesTextStyle: TextStyle(
                color: PickerConstants.borderColor,
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
              ),
              todayTextStyle: TextStyle(
                color: PickerConstants.gradientStart,
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            selectionTextStyle: PickerConstants.selectedItemStyle,
            selectionColor: PickerConstants.gradientStart,
            todayHighlightColor: PickerConstants.gradientStart,
            yearCellStyle: const DateRangePickerYearCellStyle(
              textStyle: PickerConstants.unselectedItemStyle,
              todayTextStyle: TextStyle(
                color: PickerConstants.gradientStart,
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
              disabledDatesTextStyle: TextStyle(
                color: PickerConstants.borderColor,
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Sağ üst köşeye navigation ikonu
          Positioned(
            right: 4,
            child: IconButton(
              onPressed: _navigateForward,
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateForward() {
    final currentDate = _controller.displayDate ?? DateTime.now();
    final nextMonth = DateTime(currentDate.year, currentDate.month + 1);

    if (nextMonth.year <= 2100) {
      _controller.forward!();
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {
      widget.onDateSelected(args.value);
    }
  }
}
