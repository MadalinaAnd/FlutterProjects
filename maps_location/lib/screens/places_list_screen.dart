import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maps_location/providers/great_places.dart';
import 'package:maps_location/screens/add_place_screen.dart';
import 'package:maps_location/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlace, ch) => greatPlace.items.length <= 0
                    ? ch as Widget
                    : ListView.builder(
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlace.items[i].image as File),
                          ),
                          title: Text(greatPlace.items[i].title as String),
                          subtitle: Text(
                              greatPlace.items[i].location!.address as String),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: greatPlace.items[i].id,
                            );
                          },
                        ),
                        itemCount: greatPlace.items.length,
                      ),
              ),
      ),
    );
  }
}
