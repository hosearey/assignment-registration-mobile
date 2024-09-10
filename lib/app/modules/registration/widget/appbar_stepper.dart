// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final List steps;

  CustomStepper({required this.currentStep, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          steps.length,
          (index) => Flexible(
            child: Column(
              children: [
                Container(
                  height: 8,
                  width: 62,
                  decoration: BoxDecoration(
                    color: index <= currentStep
                        ? Colors.teal
                        : Colors.teal.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
