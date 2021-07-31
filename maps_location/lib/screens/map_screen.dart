import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_location/helpers/location_helper.dart';
import 'package:maps_location/models/place.dart';

class MapSceen extends StatefulWidget {
  final PlaceLocation initalLocation;
  final bool isSelecting;

  MapSceen({
    this.initalLocation =
        const PlaceLocation(latitudine: 37.418, longitudine: -122.096),
    this.isSelecting = false,
  });

  @override
  _MapSceenState createState() => _MapSceenState();
}

class _MapSceenState extends State<MapSceen> {
  LatLng? _pickedLocation;

  Marker? marker;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initalLocation.latitudine as double,
            widget.initalLocation.longitudine as double,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {
                Marker(
                  markerId: MarkerId('a1'),
                  position: LatLng(37.418, -122.096),
                )
              }
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initalLocation.latitudine as double,
                        widget.initalLocation.longitudine as double,
                      ),
                ),
              },
      ),
    );
  }
}
