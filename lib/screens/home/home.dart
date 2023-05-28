import 'package:experiment/models/places.dart';
import 'package:experiment/providers/places_provider.dart';
import 'package:experiment/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Place> filterData = [];
  double? lat, lng;
  bool isLoading = false;
  String errorText = " ";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(),
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: ElevatedButton(
              onPressed: isLoading
                  ? () {}
                  : () async {
                      print(Theme.of(context).primaryColor);
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        dynamic result = await _determinePosition();
                        if (result is String) {
                          errorText = result;
                          filterData = [];
                        } else {
                          errorText = "";
                          lat = result.latitude;
                          lng = result.longitude;
                          filterData =
                              Provider.of<PlacesModel>(context, listen: false)
                                  .filter(lat: lat!, lng: lng!);
                        }
                      } catch (e) {
                        errorText = e.toString();
                      }
                      isLoading = false;
                      setState(() {});
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ))
                  : Text(
                      "Find",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    )),
        ),
        const SizedBox(
          height: 30,
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              errorText,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        if (filterData.isEmpty && errorText.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "No nearby place found. You can add a place from settings",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        if (filterData.isNotEmpty && errorText.isEmpty)
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, i) => PlaceList(filterData),
            itemCount: filterData.length,
          ))
      ],
    );
  }

  dynamic _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }
    return await Geolocator.getCurrentPosition();
  }
}
