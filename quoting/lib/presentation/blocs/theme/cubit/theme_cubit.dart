import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    String? theme = json['theme'];
    ThemeMode? mode;
    switch (theme) {
      case 'ThemeMode.light':
        mode = ThemeMode.light;
        break;
      case 'ThemeMode.dark':
        mode = ThemeMode.dark;
        break;
      default:
        mode = ThemeMode.system;
    }
    return mode;
  }

  @override
  Map<String, String> toJson(ThemeMode state) {
    return {'theme': state.toString()};
  }

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
  }
}
