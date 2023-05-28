import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/places.dart';
import '../../../providers/places_provider.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController lng = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                const BoxShadow(blurRadius: 5, color: Colors.black12)
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  border: OutlineInputBorder(),
                  label: Text("Place name"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: lat,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return null;
                  try {
                    double temp = double.parse(value);
                  } catch (e) {
                    return e.toString();
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  border: OutlineInputBorder(),
                  label: Text("Place latitude"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: lng,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return null;
                  try {
                    double temp = double.parse(value);
                  } catch (e) {
                    return e.toString();
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  border: OutlineInputBorder(),
                  label: Text("Place longitude"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<PlacesModel>(context, listen: false).add(
                          Place(
                              name: name.text.trim(),
                              lat: double.tryParse(lat.text.trim()),
                              lng: double.tryParse(lng.text.trim())));
                      name.clear();
                      lat.clear();
                      lng.clear();
                      FocusManager.instance.primaryFocus!.unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Place added succecussfully")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    "Add",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
