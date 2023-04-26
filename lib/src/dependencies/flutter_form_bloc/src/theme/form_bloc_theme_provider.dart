import 'package:flutter/widgets.dart';

import '../theme/form_bloc_theme.dart';

class FormThemeProvider extends InheritedWidget {
  final FormTheme theme;

  const FormThemeProvider({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  static FormTheme? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FormThemeProvider>()
        ?.theme;
  }

  @override
  bool updateShouldNotify(FormThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }
}
