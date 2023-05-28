import 'package:experiment/providers/places_provider.dart';
import 'package:experiment/screens/settings/components/add_form.dart';
import 'package:experiment/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      Provider.of<PlacesModel>(context, listen: false).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: EdgeInsets.zero,
            collapsedBackgroundColor:
                Theme.of(context).primaryColor.withOpacity(.9),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            title: Text(
              "Add a place",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
            children: [AddForm()],
          ),
          Flexible(
            child: Consumer<PlacesModel>(
              builder: (context, model, child) {
                return model.places.places!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        child: Text(
                          "No places added yet",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    : PlaceList(model.places.places!);
              },
            ),
          )
        ],
      ),
    );
  }
}
