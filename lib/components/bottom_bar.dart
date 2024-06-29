import 'package:flutter/material.dart';
import 'package:tool_box_pro/utils/styles.dart';

class BottomBar extends StatefulWidget {
  final VoidCallback onMinimize;
  final VoidCallback onRestore;
  final VoidCallback onClose;

  const BottomBar({
    Key? key,
    required this.onMinimize,
    required this.onRestore,
    required this.onClose,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool _isHoveringMinimize = false;
  bool _isHoveringRestore = false;
  bool _isHoveringClose = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton(Icons.minimize, widget.onMinimize, _isHoveringMinimize,
              (hovering) {
            setState(() {
              _isHoveringMinimize = hovering;
            });
          }),
          _buildButton(Icons.aspect_ratio, widget.onRestore, _isHoveringRestore,
              (hovering) {
            setState(() {
              _isHoveringRestore = hovering;
            });
          }),
          _buildButton(Icons.close, widget.onClose, _isHoveringClose,
              (hovering) {
            setState(() {
              _isHoveringClose = hovering;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed, bool isHovering,
      ValueChanged<bool> onHover) {
    return MouseRegion(
      onEnter: (event) => onHover(true),
      onExit: (event) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: secondaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovering ? 0.2 : 0.1),
              spreadRadius: isHovering ? 2 : 1,
              blurRadius: isHovering ? 6 : 4,
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(icon, color: primaryColor),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
