// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class StyleizedButton extends StatelessWidget {
  final Color color;
  final Function onTap;
  final String text;
  final double defaultElevation;
  final double hoverElevation;
  final List<MaterialState> interactions;

  //Constructs a Stylized button with the passed properties.
  const StyleizedButton(
      {required this.color,
      required this.onTap,
      required this.text,
      this.defaultElevation = 0.0,
      this.hoverElevation = 10,
      this.interactions = const [
        MaterialState.hovered,
        MaterialState.pressed,
        MaterialState.focused,
        MaterialState.dragged
      ]});

  ///Checks if the current interaction with the button is in our interaction's list,
  /// If it is, set the elevation to hover elavation (default 20),
  /// Otherwise se the elevation to default elevation (default 0)
  double buttonElevation(Set<MaterialState> state) =>
      state.any(interactions.contains) ? hoverElevation : defaultElevation;

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: () => onTap.call(),
      child: Text(text),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          elevation:
              MaterialStateProperty.resolveWith<double>(buttonElevation)));
}
