import 'package:flutter/material.dart';

abstract class PriceRangeEvent {}

class LoadInitialRange extends PriceRangeEvent {
  final RangeValues initialRange;
  LoadInitialRange(this.initialRange);
}

class UpdatePriceRange extends PriceRangeEvent {
  final RangeValues newRange;
  UpdatePriceRange(this.newRange);
}
