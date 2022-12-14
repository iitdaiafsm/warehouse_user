import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

class FlutterMap extends StatelessWidget {
  late WarehouseController controller;
  final Completer<GoogleMapController> _mapController = Completer();

  FlutterMap({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      child: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(23.4937, 77.6629), zoom: 5.2),
        mapType: MapType.hybrid,
        onMapCreated: (controller) {
          _mapController.complete(controller);
        },
      ),
    );
  }
}
