import 'package:cycle/services/coordinate.dart';
import 'package:cycle/services/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cycle/services/search_suggestions.dart';
import 'package:google_fonts/google_fonts.dart';

const kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide.none,
);

class SearchBox extends StatelessWidget {
  final TextEditingController typeAheadController;

  static const int maxLocationStringLength = 30;
  final Waypoint searchboxType;

  void onSelected(String suggestion) {
    String suggestionFullName = suggestion.toString().split('|').elementAt(0);

    if (suggestionFullName.length > maxLocationStringLength) {
      suggestionFullName =
          suggestionFullName.substring(0, maxLocationStringLength) + '...';
    }
    String longitude = suggestion.toString().split('|').elementAt(2);
    String latitude = suggestion.toString().split('|').elementAt(3);
    double long = double.parse(longitude);
    double lat = double.parse(latitude);
    Coordinate selectedLocation = Coordinate(latitude: lat, longitude: long);

    switch (searchboxType) {
      case Waypoint.START:
        myRoute.setStartingLocation(selectedLocation);
        break;
      case Waypoint.FINISH:
        myRoute.setFinishingLocation(selectedLocation);
        break;
    }

    print('A location has been picked for the $searchboxType of the journey.');
    print('Picked location coordinates: $selectedLocation');

    typeAheadController.text = suggestionFullName;
  }

  MyRoute myRoute;
  String hintText = '';

  SearchBox(
      {required this.searchboxType,
      required this.myRoute,
      required this.typeAheadController}) {
    switch (searchboxType) {
      case Waypoint.START:
        hintText = 'Starting location';
        break;
      case Waypoint.FINISH:
        hintText = 'Destination';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlue[200],
          borderRadius: BorderRadius.circular(15.0)),
      // child: Padding(
      // padding: const EdgeInsets.all(10.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: typeAheadController,
          // autofocus: true,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.bottom,
          // style: const TextStyle(fontSize: 12.0, color: Colors.black),
          style: GoogleFonts.lato(
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontSize: 14.0,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: kOutlineInputBorder,
          ),
        ),
        suggestionsCallback: (pattern) =>
            BackendService.getSuggestionsFromGeocoding(pattern),
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.location_on),
            ),
            tileColor: Colors.lightBlueAccent,
            title: Text(suggestion.toString().split('|').first,
                style: GoogleFonts.lato(
                    fontStyle: FontStyle.normal,
                    color: Colors.white)), //suggestion['name']
            subtitle: Text(suggestion.toString().split('|').elementAt(1),
                style: GoogleFonts.lato(
                    fontStyle: FontStyle.normal, color: Colors.white)),
          );
        },
        onSuggestionSelected: onSelected,
      ),
      // ),
    );
  }
}