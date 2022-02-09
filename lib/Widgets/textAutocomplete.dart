import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'companyPrimaryButton.dart';

class TextAutocompletePage extends StatefulWidget {
  // final List<AutoCompleteClass> itemList = <AutoCompleteClass>[];
  List<AutoCompleteClass> itemList = <AutoCompleteClass>[];
  TextAutocompletePage({required this.itemList});

  @override
  State<TextAutocompletePage> createState() => _TextAutocompletePageState();
}

class _TextAutocompletePageState extends State<TextAutocompletePage> {
  bool isLoading = false;
  List<AutoCompleteClass> items = [];

  List<AutoCompleteClass> autoCompleteData = [];
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    print('item list is ${widget.itemList}');
    autoCompleteData.addAll(widget.itemList);
    autoCompleteData.forEach((element) {
      print('Name is ${element.title}');
    });
    // fetchAutoCompleteData();
  }

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    // final String stringData = await DefaultAssetBundle.of(context)
    //     .loadString("lib/Seond/sample.json");

    // final String stringData =
    //     await rootBundle.loadString('assets/images/sample.json');

    // final List<dynamic> json = jsonDecode(stringData);

    // final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = widget.itemList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: PrimaryButton(
          function: () {
            print('object');
          },
          title: 'Update',
        ),
      ),
      body: SafeArea(
        child: (isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 16,
                              child: Autocomplete<AutoCompleteClass>(
                                optionsBuilder:
                                    (TextEditingValue texteditingvalue) {
                                  if (texteditingvalue.text.isEmpty) {
                                    return Iterable<AutoCompleteClass>.empty();
                                  } else {
                                    //autocompleteData is the complete list of items
                                    return autoCompleteData.where(
                                        (AutoCompleteClass word) => word.title
                                            .toLowerCase()
                                            .contains(texteditingvalue.text
                                                .toLowerCase()));
                                  }
                                },
                                onSelected: (AutoCompleteClass value) {
                                  setState(() {
                                    items.add(value);
                                  });
                                  controller.clear();
                                },
                                optionsViewBuilder: (context,
                                    Function(AutoCompleteClass) onSelected,
                                    options) {
                                  return Material(
                                    elevation: 4,
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        // options as List<AutoCompleteClass>;
                                        final option = options.elementAt(index);

                                        return ListTile(
                                          title: Text(option.title.toString()),
                                          // title: SubstringHighlight(
                                          //   text: option.toString(),
                                          //   term: controller.text,
                                          //   textStyleHighlight:
                                          //       TextStyle(fontWeight: FontWeight.w700),
                                          // ),
                                          subtitle:
                                              Text(option.subtitle.toString()),
                                          onTap: () {
                                            onSelected(option);
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemCount: options.length,
                                    ),
                                  );
                                },
                                fieldViewBuilder: (context, controller,
                                    focusnode, onEditingComplete) {
                                  this.controller = controller;

                                  return TextField(
                                    controller: controller,
                                    focusNode: focusnode,
                                    onEditingComplete: onEditingComplete,

                                    // decoration: Style.decoration,
                                  );
                                },
                              ),
                            ),
                            ...items.map((e) {
                              return ListTile(
                                title: Text(e.title),
                                subtitle: Text(e.subtitle),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                    size: 22,
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class AutoCompleteClass {
  String title;
  String subtitle;

  AutoCompleteClass({
    required this.title,
    required this.subtitle,
  });
}
