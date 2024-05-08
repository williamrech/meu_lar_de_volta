import 'package:flutter/material.dart';

enum Sizes {
  s10(10.0),
  s12(12.0),
  s14(14.0),
  s16(16.0),
  s50(40.0);

  const Sizes(this.value);

  final double value;
}

class AppStyles {
  static const _color = Colors.black;
  static const _boldF = 'Bold';
  static const _regularF = 'Regular';
  static const _semiBoldF = 'SemiBold';

  static const _bold = TextStyle(fontFamily: _boldF);
  static const _regular = TextStyle(fontFamily: _regularF);
  static const _semiBold = TextStyle(fontFamily: _semiBoldF);

  static TextStyle regular(Sizes size, [Color color = _color]) =>
      _regular.copyWith(fontSize: size.value, color: color, height: 1.3);

  static TextStyle semiBold(Sizes size, [Color color = _color]) =>
      _semiBold.copyWith(fontSize: size.value, color: color, height: 1.3);

  static TextStyle bold(Sizes size, [Color color = _color]) => _bold.copyWith(fontSize: size.value, color: color, height: 1.3);
}

class AppDecorations {
  static input(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppStyles.regular(Sizes.s12, Colors.grey),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      fillColor: Colors.white,
      hoverColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.all(10),
      isDense: true,
    );
  }
}
