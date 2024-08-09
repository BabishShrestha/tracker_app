import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Legend'),
          // const LegendChildWidget(
          //   text: 'Ongoing Connection',
          //   icon: Icon(
          //     Icons.location_on,
          //     color: UIColors.statusGreen,
          //   ),
          // ),
          // const LegendChildWidget(
          //   text: 'Connections',
          //   icon: Icon(
          //     Icons.location_on,
          //     color: UIColors.statusRed,
          //   ),
          // ),
          // LegendChildWidget(
          //   text: 'Vendor Team',
          //   icon: Image.asset(
          //     UIImagePath.vendorTeam,
          //     height: 30.h,
          //     width: 25.w,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class LegendChildWidget extends StatelessWidget {
  final String text;
  final Widget icon;
  final TextStyle? style;
  const LegendChildWidget({
    super.key,
    required this.text,
    this.style,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Text(text, style: style),
      ],
    );
  }
}
