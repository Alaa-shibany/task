// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IndicatorWidget extends StatelessWidget {
  IndicatorWidget({super.key, required this.activeIndex, required this.count});
  int activeIndex;
  int count;
  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: const ScaleEffect(
          activeDotColor: Colors.amber, dotColor: Colors.white24),
    );
  }
}
