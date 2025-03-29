import 'package:flutter/material.dart';
import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/etc/school_data.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/widget_util/widget_util.dart';

import 'select_color.dart';
import 'subject_code_drop_down_menu.dart';

class AppointmentEditorDialog extends StatefulWidget {
  final List<String> subjectCodeList;
  final PlatoAppointment platoAppointment;
  final bool isEditing;

  AppointmentEditorDialog({super.key, required this.subjectCodeList})
      : platoAppointment = PlatoAppointment()
          ..uid = UniqueKey().toString()
          ..year = year.toString()
          ..semester = semester.toString()
          ..start = DateTime.now()
          ..end = DateTime.now().add(Duration(hours: 1))
          ..dataType = DataType.etc,
        isEditing = false;

  const AppointmentEditorDialog.fromPlatoAppointment(
      PlatoAppointment appointment,
      {super.key,
      required this.subjectCodeList})
      : platoAppointment = appointment,
        isEditing = true;

  @override
  State<StatefulWidget> createState() => _AppointmentEditor();
}

class _AppointmentEditor extends State<AppointmentEditorDialog> {
  late final List<String> subjectCodeList;
  late final PlatoAppointment appointment;
  late final bool isEditing;

  late String subjectCode;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  late DateTime _startDateTime;
  late DateTime _endDateTime;

  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subjectCodeList = widget.subjectCodeList.sublist(1);

    appointment = widget.platoAppointment;
    isEditing = widget.isEditing;

    subjectCode = appointment.subjectCode;
    titleController.text = appointment.title;
    bodyController.text = appointment.body;
    commentController.text = appointment.comment;

    _startDateTime = appointment.start;
    _endDateTime = appointment.end;
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    commentController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  // Format and update the date/time text fields
  void _updateDateTimeControllers() {
    final locale = MaterialLocalizations.of(context);
    final startDate = locale.formatMediumDate(_startDateTime);
    final startTime = TimeOfDay.fromDateTime(_startDateTime).format(context);
    _startTimeController.text = '$startDate, $startTime';
    final endDate = locale.formatMediumDate(_endDateTime);
    final endTime = TimeOfDay.fromDateTime(_endDateTime).format(context);
    _endTimeController.text = '$endDate, $endTime';
  }

  Future<void> _selectStartDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null || !mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startDateTime),
    );
    if (pickedTime == null) return;
    final newStart = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute);
    setState(() {
      _startDateTime = newStart;
      // Adjust end time if it's before the new start time
      if (_endDateTime.isBefore(newStart)) {
        _endDateTime = newStart.add(const Duration(hours: 1));
      }
      _updateDateTimeControllers();
    });
  }

  Future<void> _selectEndDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null || !mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_endDateTime),
    );
    if (pickedTime == null) return;
    final newEnd = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute);

    setState(() {
      _endDateTime = newEnd;
      if (newEnd.isBefore(_startDateTime)) {
        _startDateTime = newEnd.subtract(const Duration(hours: 1));
      }
      _updateDateTimeControllers();
    });
  }

  void _saveAppointment() {
    appointment.title = titleController.text;
    appointment.body = bodyController.text;
    appointment.comment = commentController.text;

    appointment.start = _startDateTime;
    appointment.end = _endDateTime;

    Navigator.pop(context, appointment);
  }

  void _deleteAppointment() {
    appointment.status = Status.disable;
    Navigator.pop(context, appointment);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    _updateDateTimeControllers();
    return Scaffold(
      appBar: AppBar(
          title: Text(isEditing ? '일정 편집' : '새로운 일정'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Back',
          ),
          actions: [
            if (isEditing)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  confirmDialog(context,
                          title: '삭제 확인',
                          content: '해당 정보를 삭제합니다.\n(되돌릴 수 없습니다)',
                          yesLabel: '삭제',
                          noLabel: '취소')
                      .then((value) {
                    if (value == true) {
                      _deleteAppointment();
                    }
                  });
                },
                tooltip: 'Delete',
              ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveAppointment,
              tooltip: 'Save',
            ),
          ],
          backgroundColor: calendarColor[appointment.color]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SubjectCodeDropDownMenu(
                subjectCodeList: subjectCodeList,
                subjectCode: appointment.subjectCode,
                onChanged: (cal) {
                  setState(() {
                    appointment.subjectCode = cal;
                  });
                },
                enabled: appointment.dataType != DataType.school,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  prefixIcon: IconButton(
                    icon: Icon(Icons.circle,
                        color: calendarColor[appointment.color]),
                    onPressed: () async {
                      final color = await selectColor(context, appointment);
                      if (color == null) return;
                      setState(() {
                        appointment.color = color;
                      });
                    },
                    tooltip: 'Event color',
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                textCapitalization: TextCapitalization.sentences,
                readOnly: appointment.dataType == DataType.school,
              ),
              const SizedBox(height: 16),
              TextField(
                  controller: _startTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: '시작 시간',
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onTap: _selectStartDateTime,
                  enabled: appointment.dataType != DataType.school),
              const SizedBox(height: 12),
              TextField(
                  controller: _endTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: '종료 시간',
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onTap: _selectEndDateTime,
                  enabled: appointment.dataType != DataType.school),
              const SizedBox(height: 16),
              bodyController.text == ''
                  ? Container()
                  : TextField(
                      controller: bodyController,
                      decoration: InputDecoration(
                        hintText: 'Notes',
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 4,
                      enabled: appointment.dataType != DataType.school,
                    ),
              const SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: '메모',
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
