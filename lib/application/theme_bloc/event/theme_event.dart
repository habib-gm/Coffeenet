import 'package:equatable/equatable.dart';
import '../../../domain/undetected_leaf/undetected_leaf.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  // final bool theme;

  @override
  List<Object> get props => [];

  const ChangeThemeEvent();
}

class LoadThemeEvent extends ThemeEvent {
  // final bool theme;

  @override
  List<Object> get props => [];

  const LoadThemeEvent();
}
