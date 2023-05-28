import 'package:flutter/material.dart';

import '../models/places.dart';

class PlaceList extends StatefulWidget {
  const PlaceList(this.places, {Key? key}) : super(key: key);
  final List<Place> places;
  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      interactive: true,
      thickness: 2,
      radius: const Radius.circular(6),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 5),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: DataTable(
                border: TableBorder.all(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(6)),
                headingRowColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor.withOpacity(.5)),
                dataTextStyle:
                    const TextStyle(color: Colors.black, fontSize: 14),
                headingTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                dataRowColor: MaterialStateProperty.all(Colors.white),
                columns: [
                  DataColumn(
                      label: Text(
                    "SL.",
                  )),
                  DataColumn(
                      label: Text(
                    "Name",
                  )),
                  DataColumn(
                      label: Text(
                    "Latitude",
                  )),
                  DataColumn(
                      label: Text(
                    "Logtitude",
                  )),
                ],
                rows: [
                  for (int i = 0; i < widget.places.length; i++)
                    DataRow(cells: [
                      DataCell(Text(
                        "${i + 1}",
                        style: TextStyle(fontSize: 16),
                      )),
                      DataCell(Text(
                        widget.places[i].name!,
                        style: TextStyle(fontSize: 16),
                      )),
                      DataCell(Text(
                        widget.places[i].lat.toString(),
                        style: TextStyle(fontSize: 16),
                      )),
                      DataCell(Text(
                        widget.places[i].lng.toString(),
                        style: TextStyle(fontSize: 16),
                      )),
                    ])
                ]),
          ),
        ),
      ),
    );
  }
}
