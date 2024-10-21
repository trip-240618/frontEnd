import 'package:flutter/material.dart';
import '../../util/color.dart';


class SwitchButton extends StatefulWidget {
  final bool value;
  final VoidCallback onTap;

  const SwitchButton({Key? key, required this.onTap, required this.value})
      : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  final animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            height: 31,
            width: 51,
            // Increased width to accommodate the text
            duration: animationDuration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: widget.value ? gray900 : Color(0xFF787880).withOpacity(0.16),
            ),
            child: AnimatedAlign(
              duration: animationDuration,
              alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 27,
                        height: 27,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
