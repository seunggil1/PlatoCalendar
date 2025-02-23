import 'package:flutter/material.dart';
import 'package:plato_calendar/etc/school_data.dart';
import 'package:plato_calendar/model/model.dart';

import 'appointment_editor_appbar.dart';
import 'appointment_editor_body.dart';

class AppointmentEditorDialog extends StatefulWidget {
  final PlatoAppointment platoAppointment;
  final bool isNewAppointment;
  final List<String> subjectCodeList;

  AppointmentEditorDialog({super.key, required this.subjectCodeList})
      : platoAppointment = PlatoAppointment()
          ..uid = UniqueKey().toString()
          ..year = year.toString()
          ..semester = semester.toString()
          ..start = DateTime.now()
          ..end = DateTime.now().add(Duration(hours: 1))
          ..dataType = DataType.etc,
        isNewAppointment = true;

  const AppointmentEditorDialog.fromPlatoAppointment(
      PlatoAppointment appointment,
      {super.key,
      required this.subjectCodeList})
      : platoAppointment = appointment,
        isNewAppointment = false;

  @override
  State<StatefulWidget> createState() => _AppointmentEditor();
}

class _AppointmentEditor extends State<AppointmentEditorDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppointmentEditorAppbar(
          showDeleteButton: !widget.isNewAppointment,
          appointment: widget.platoAppointment),
      body: AppointmentEditorBody(
        subjectCodeList: widget.subjectCodeList,
        appointment: widget.platoAppointment,
      ),
    );
  }
}
