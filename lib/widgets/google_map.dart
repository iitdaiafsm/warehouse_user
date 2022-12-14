import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:warehouse_user/screens/warehouse/controller.dart';

class GoogleMap extends StatelessWidget {
  late WarehouseController controller;
  late String htmlId;

  GoogleMap({super.key, required this.controller, required this.htmlId});

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final mapOptions = MapOptions()
        ..zoom = 5.2
        ..center = LatLng(23.4937, 77.6629);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      // Another marker
      if (controller.warehouses.isNotEmpty) {
        for (var item in controller.warehouses) {
          final marker = Marker(MarkerOptions()
            ..position = LatLng(item.latitude, item.longitude)
            ..map = map
            ..title = item.name
            ..icon = 'asset/app_icon_15p.png');
          marker.onClick.listen((event) {
            // print(jsonEncode(item));
          });
        }
      }
      // Marker(
      //   MarkerOptions()
      //     ..position = LatLng(20.5937, 78.9629)
      //     ..map = map,
      // );

      /*Marker marker = Marker();
      for (var item in controller.warehouses) {
        marker = Marker(MarkerOptions()
          ..position = LatLng(item.latitude, item.longitude)
          ..title = item.name
          ..map = map
          ..label = "HHH"
          ..icon =
              'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png');
      }*/

      return elem;
    });

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      child: HtmlElementView(viewType: htmlId),
    );
  }
}

var contentString =
    '<div id="content"><div id="siteNotice"></div><h1 id="firstHeading" class="firstHeading">Uluru</h1><div id="bodyContent"><p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large sandstone rock formation in the southern part of the Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) south west of the nearest large town, Alice Springs; 450&#160;km (280&#160;mi) by road. Kata Tjuta and Uluru are the two major features of the Uluru - Kata Tjuta National Park. Uluru is sacred to the Pitjantjatjara and Yankunytjatjara, the Aboriginal people of the area. It has many springs, waterholes, rock caves and ancient paintings. Uluru is listed as a World Heritage Site.</p><p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">https://en.wikipedia.org/w/index.php?title=Uluru</a> (last visited June 22, 2009).</p></div></div>';
