// import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

class SelectMongodbData extends StatefulWidget {
  final String title;
  final List<List<String>> items;
  // final List<String> items;
  // final Future<List<String>> items;
  final List<List<String>> selecteditems;
  // final List<String> selecteditems;
  const SelectMongodbData(
      {Key? key,
      required this.items,
      required this.selecteditems,
      required this.title})
      : super(key: key);

  @override
  _SelectMongodbData createState() => _SelectMongodbData();
}

class _SelectMongodbData extends State<SelectMongodbData> {
  TextEditingController _searchController = TextEditingController();
  List<List<String>> itemslist = [[]];
  // this variable holds the selected items
  // final List<List<String>> _selectedItems = [];// repair herere
  // final List<List<String>> _selectedItems = widget.selecteditems;// repair herere

  //  List<List<String>> _selectedItems = [];
  // final List<String> _selectedItems = [];

  // List<String> secondItems = [];
  // List<String> itemItems = [];

  @override
  void initState() {
    super.initState();
    itemslist = widget.items;
    // _selectedItems = [];
    // print(widget.selecteditems.toString());
    // final List<List<String>> _selectedItems = widget.selecteditems;

    // _itemChange(flattenList(widget.selecteditems), widget.selecteditems.contains(widget.items));

    // print(_selectedItems);
//  for (var sublist in widget.selecteditems) {
//   secondItems.add(sublist[1]); // Accessing the second item of each sublist
// }

// for (var sublist in widget.items) {
//   itemItems.add(sublist[1]); // Accessing the second item of each sublist
// }

// print(secondItems);
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(List<String> itemValue, bool isSelected) {
    setState(() {
      // print(isSelected);
      if (isSelected) {
        // _selectedItems.add(itemValue);widget.selecteditems.add(itemValue);secondItems.add(itemValue[1]);
        // _selectedItems.add(itemValue);
        widget.selecteditems.add(itemValue);
      } else {
        // _selectedItems.remove(itemValue);widget.selecteditems.remove(itemValue[1]);secondItems.remove(itemValue[1]);

        widget.selecteditems.removeWhere(
            (item) => const ListEquality().equals(item, itemValue));
      }
      print(widget.selecteditems);
      // print(_selectedItems);
      // print(widget.selecteditems);
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    // Navigator.pop(context, _selectedItems);
    Navigator.pop(context, widget.selecteditems);
  }

  void _filterItems(String query) {
    setState(() {
      itemslist = widget.items
          .where((list) => list
              .any((item) => item.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    //  print(widget.selecteditems[1]);
    // List<String> sublist = widget.items[1];

    // print(sublist);
    return AlertDialog(
      // title: const Text('Select Topics'),
      title: Text(widget.title),
      content: SingleChildScrollView(
          child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              _filterItems(value);
            },
          ),
          SizedBox(
            height: 15,
          ),
          ListBody(
            children:
                // widget.items
                itemslist
                    .map((item) => CheckboxListTile(
                          // value: widget.selecteditems.contains(item),
                          value: widget.selecteditems
                              .any((selectedd) => selectedd[0] == item[0]),
                          // value: _selectedItems.contains(item),
                          // value: secondItems.contains(item[1]),
                          title: Text(item[1]),
                          controlAffinity: ListTileControlAffinity.leading,
                          // onChanged: (isChecked) => _itemChange(item, isChecked!),
                          onChanged: (isChecked) {
                            _itemChange(item, isChecked!);
                          },
                        ))
                    .toList(),
          ),
        ],
      )),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// List<String> flattenList(List<List<String>> nestedList) {
//   return nestedList.expand((innerList) => innerList).toList();
// }
