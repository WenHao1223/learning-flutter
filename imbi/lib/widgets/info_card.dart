import 'package:flutter/cupertino.dart';

class InfoCard extends StatelessWidget {
  final Widget child;
  final double height, width;

  const InfoCard({
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
      ),
      child: child,
    );
  }
}
