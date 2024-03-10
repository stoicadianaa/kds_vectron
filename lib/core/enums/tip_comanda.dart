import 'package:flutter/material.dart';

enum TipComanda { dinein, pickup, other }

extension TipComandaExtension on TipComanda {
  String get name {
    switch (this) {
      case TipComanda.dinein:
        return 'Dine In';
      case TipComanda.pickup:
        return 'Pick Up';
      default:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case TipComanda.dinein:
        return Icons.restaurant;
      case TipComanda.pickup:
        return Icons.shopping_bag;
      default:
        return Icons.more_horiz;

    }
  }

  String get value {
    switch (this) {
      case TipComanda.dinein:
        return 'dinein';
      case TipComanda.pickup:
        return 'pickup';
      default:
        return 'other';
    }
  }
}