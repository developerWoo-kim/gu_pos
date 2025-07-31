import 'package:flutter/material.dart';
import 'package:gu_pos/common/const/colors.dart';

import '../text/body_text.dart';

class HoverButton extends StatefulWidget {
  final BodyText text;
  final Color backgroundColor;
  final Color hoverColor;
  final BorderRadiusGeometry? radius;
  final Icon? icon;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final VoidCallback? onTap;

  const HoverButton({
    required this.text,
    required this.backgroundColor,
    required this.hoverColor,
    this.radius,
    this.icon,
    this.padding,
    this.mainAxisAlignment,
    this.onTap,
    super.key,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final buttonColor = _isHovered ? widget.hoverColor : widget.backgroundColor;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Material(
            color: buttonColor,
            borderRadius: widget.radius ?? BorderRadius.circular(5),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
                children: [
                  if(widget.icon != null)
                    widget.icon!,
                    const SizedBox(width: 6,),
                    widget.text
                ],
              ),
            )
        ),
      ),
    );
  }
}
