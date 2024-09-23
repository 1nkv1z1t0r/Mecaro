import 'package:flutter/material.dart';

class DecodedMessage {
  final String text;
  final IconData icon;
  final String? description;
  final String type;

  DecodedMessage({
    required this.text,
    required this.icon,
    this.description,
    required this.type,
  });
}