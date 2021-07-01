import 'package:flutter/material.dart';

// Import.
// Export.


class BlocProvider extends InheritedWidget {
  static BlocProvider? _instance;

  factory BlocProvider({ required Widget child }) {
    if (_instance == null) {
      _instance = new BlocProvider._internal(child: child);
    }

    return _instance as BlocProvider;
  }

  BlocProvider._internal({ required Widget child }) : super(child: child);

  //final TextCaptureBloc _textCaptureBloc = TextCaptureBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //static TextCaptureBloc textCaptureBloc(BuildContext context) => context.dependOnInheritedWidgetOfExactType<BlocProvider>()._textCaptureBloc;
}