import 'package:equatable/equatable.dart';

class DateTimeSelection extends Equatable {
  final DateTime? selectedDate;
  final DateTime selectedTime;
  final bool showDatePicker;
  final bool showTimePicker;

  DateTimeSelection({
    this.selectedDate,
    DateTime? selectedTime,
    this.showDatePicker = false,
    this.showTimePicker = false,
  }) : selectedTime = selectedTime ?? DateTime(2024, 1, 1, 0, 0);

  DateTimeSelection copyWith({
    DateTime? selectedDate,
    DateTime? selectedTime,
    bool? showDatePicker,
    bool? showTimePicker,
  }) {
    return DateTimeSelection(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      showDatePicker: showDatePicker ?? this.showDatePicker,
      showTimePicker: showTimePicker ?? this.showTimePicker,
    );
  }

  bool get hasDate => selectedDate != null;
  bool get hasTime => selectedTime.hour > 0 || selectedTime.minute > 0;

  DateTime? get combinedDateTime {
    if (selectedDate == null) return null;
    return selectedDate!.add(
      Duration(hours: selectedTime.hour, minutes: selectedTime.minute),
    );
  }

  String get timeDisplayString =>
      '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

  @override
  List<Object?> get props => [
    selectedDate,
    selectedTime,
    showDatePicker,
    showTimePicker,
  ];
}
