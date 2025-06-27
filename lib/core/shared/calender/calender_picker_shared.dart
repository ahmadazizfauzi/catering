import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CalenderPickerShared extends StatefulWidget {
  final Function(List<DateTime?>) onDateSelected;
  final List<DateTime?> initialValue;
  final double? width;

  const CalenderPickerShared({
    super.key,
    required this.onDateSelected,
    required this.initialValue,
    this.width,
  });

  @override
  State<CalenderPickerShared> createState() => _CalenderPickerSharedState();
}

class _CalenderPickerSharedState extends State<CalenderPickerShared> {
  List<DateTime?> _selectedDates = [];

  @override
  void initState() {
    super.initState();
    _selectedDates =
        widget.initialValue.isNotEmpty ? widget.initialValue : [DateTime.now()];
  }

  String _getDisplayText() {
    if (_selectedDates.isEmpty || _selectedDates.first == null) {
      return 'Select Date';
    }

    if (_selectedDates.length == 1) {
      return DateFormat('dd MMM yyyy').format(_selectedDates.first!);
    } else {
      return '${DateFormat('dd MMM').format(_selectedDates.first!)} - ${DateFormat('dd MMM yyyy').format(_selectedDates.last!)}';
    }
  }

  Future<void> _showDatePicker() async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: AppColors.brand['default'],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: TextStyle(
        color: AppColors.brand['lgith'],
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: TextStyle(
        color: AppColors.brand['dark'],
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: TextStyle(
        color: AppColors.brand['dark'],
        fontWeight: FontWeight.normal,
      ),
      disabledDayTextStyle: TextStyle(color: AppColors.brand['light']),
      selectedDayTextStyle: TextStyle(
        color: AppColors.white['default'],
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      okButton: Text('OK', style: TextStyle(color: AppColors.brand['default'])),
      cancelButton: Text(
        'Cancel',
        style: TextStyle(color: AppColors.brand['dark']),
      ),
    );

    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
      value: _selectedDates,
      dialogBackgroundColor: AppColors.white['default'], 
    );

    if (values != null) {
      setState(() {
        _selectedDates = values;
        widget.onDateSelected(values);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 200,
      child: GestureDetector(
        onTap: _showDatePicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.brand['light'],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: AppColors.brand['light']!.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 20,
                color: AppColors.grey['dark'],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getDisplayText(),
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.brand['dark'], 
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: AppColors.grey['dark']),
            ],
          ),
        ),
      ),
    );
  }
}
