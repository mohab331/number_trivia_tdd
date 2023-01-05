import 'package:flutter/material.dart';
import 'package:test_driven/utilities/index.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.buttonColor,
    required this.onButtonPressed,
    required this.buttonLabel,
    super.key,
    this.isLoading = false,
  })  : this.widthRatio = 0.4,
        this.heightRatio = 0.07;
  final void Function()? onButtonPressed;
  final String buttonLabel;
  final Color buttonColor;
  final bool isLoading;
  final double widthRatio;
  final double heightRatio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * widthRatio,
      height: context.height * heightRatio,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onButtonPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(
            10,
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return buttonColor;
            },
          ),
        ),
        child: Text(
          buttonLabel,
        ),
      ),
    );
  }
}
