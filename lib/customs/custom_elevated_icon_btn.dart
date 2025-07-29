import 'package:flutter/material.dart';

class CustomElevatedIconBtn extends StatelessWidget {
  final int currentStep;
  final VoidCallback onPressed;
  final Color Function(int) getStepColor;

  const CustomElevatedIconBtn({
    super.key,
    required this.currentStep,
    required this.onPressed,
    required this.getStepColor,
  });

  @override
  Widget build(BuildContext context) {
    final isLastStep = currentStep >= 2;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: getStepColor(currentStep),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
      onPressed: onPressed,
      icon: Icon(
        isLastStep ? Icons.done_rounded : Icons.arrow_forward_rounded,
        size: 28,
      ),
      label: Text(
        isLastStep ? 'Submit' : 'Next Section',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
