import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maps_location/models/place.dart';
import 'package:maps_location/providers/great_places.dart';
import 'package:maps_location/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title as String),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image as File,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location!.address as String,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapSceen(
                    initalLocation: selectedPlace.location as PlaceLocation,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
