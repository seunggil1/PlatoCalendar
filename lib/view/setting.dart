// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:plato_calendar/util/logger.dart';
import 'widget/widget.dart';

final _logger = LoggerManager.getLogger('View - SettingPage');

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    _logger.fine('Widget build');

    final padding = const EdgeInsets.all(8.0);
    return ListView(
      children: [
        Padding(padding: padding, child: PlatoLoginSetting()),
        Padding(padding: padding, child: ThemeSettingWidget()),
        Padding(padding: padding, child: ColorSchemeSettingWidget()),
        Padding(padding: padding, child: SyncfusionCalendarSettingWidget()),
        Padding(padding: padding, child: DebugSettingWidget())
      ],
    );
    // return BlocProvider(
  }
}
