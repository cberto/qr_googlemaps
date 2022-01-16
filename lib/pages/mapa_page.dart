import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qr_reader/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
//mover la camra, control de mapa
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition puntoInicial =
        CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50);

    // Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
              icon: Icon(Icons.location_disabled),
              onPressed: () async {
                //mover a pantalla al punto inicial
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: scan.getLatLng(),
                        zoom: 17.5,
                        //inclinacion
                        tilt: 50)));
              })
        ],
      ),
      body: GoogleMap(
        //desactivar boton
        myLocationButtonEnabled: false,

        mapType: mapType,
        //agregar un marcador
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      //boton para cambiar el tipo de mapa MayType
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.layers),
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
//para redibujar el widget
            setState(() {});
          }),
    );
  }
}
