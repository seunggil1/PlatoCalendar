// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:plato_calendar/etc/subject_code_to_name.dart';

class SubjectCodeDropDownMenu extends StatelessWidget {
  final List<String> subjectCodeList;
  final String subjectCode;
  final ValueChanged<String> onChanged;
  final bool enabled;

  const SubjectCodeDropDownMenu({
    super.key,
    required this.subjectCodeList,
    required this.subjectCode,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownMenu<String>(
      initialSelection: subjectCode,
      enabled: enabled,
      onSelected: (String? value) {
        if (value != null) {
          onChanged(value);
        }
      },
      label: const Text('과목'),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dropdownMenuEntries: subjectCodeList.map((cal) {
        return DropdownMenuEntry<String>(
            value: cal, label: subjectCodeToName[cal] ?? cal);
      }).toList(),
    );
  }
}
