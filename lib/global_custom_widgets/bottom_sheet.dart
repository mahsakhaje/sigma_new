import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final double initialChildSize;

  const CustomBottomSheet({
    Key? key,
    required this.child,
    this.initialChildSize = 0.5,
  }) : super(key: key);

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double initialChildSize = 0.5,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      // Add this line to enable keyboard avoidance
      enableDrag: true,
      builder: (_) => CustomBottomSheet(
        child: child,
        initialChildSize: initialChildSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get keyboard height
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Transparent background that handles tap to dismiss
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // The draggable sheet
        DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: 0.2,
          // Adjust maxChildSize based on keyboard height
          maxChildSize: keyboardHeight > 0
              ? (screenHeight - keyboardHeight - 100) / screenHeight
              : initialChildSize,
          builder: (context, scrollController) {
            return Container(
              // Remove the padding from here since we'll handle it differently
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      // Add padding here to account for keyboard
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// Alternative approach using AnimatedContainer for smoother transitions
class CustomBottomSheetAnimated extends StatelessWidget {
  final Widget child;
  final double initialChildSize;

  const CustomBottomSheetAnimated({
    Key? key,
    required this.child,
    this.initialChildSize = 0.5,
  }) : super(key: key);

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double initialChildSize = 0.5,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (_) => CustomBottomSheetAnimated(
        child: child,
        initialChildSize: initialChildSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: screenHeight,
      child: Stack(
        children: [
          // Transparent background that handles tap to dismiss
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // The draggable sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: (screenHeight * initialChildSize) + keyboardHeight,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: keyboardHeight > 0 ? 20 : 0,
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
