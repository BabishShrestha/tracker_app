import 'package:flutter/material.dart';
import 'widgets/legend_widget.dart';
import 'widgets/map_widget.dart';

class FullMapView extends StatelessWidget {
  const FullMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: const Stack(
        children: [
          MapsView(),
          Positioned(
            bottom: 90,
            left: 23,
            child: Opacity(opacity: 0.8, child: LegendWidget()),
          )
        ],
      ),
    );
  }
}
