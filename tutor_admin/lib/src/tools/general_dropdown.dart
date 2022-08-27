import 'package:flutter/material.dart';

class GeneralDropDownButton extends StatelessWidget {
  GeneralDropDownButton({
    Key? key,
    this.selectedItem,
    required this.itemsList,
    required this.valueChanged,
  }) : super(key: key);
  String? selectedItem;
  final List<String> itemsList;
  final ValueChanged<String> valueChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 101, 101, 101))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 99, 99, 99),
                    width: 2,
                  ))),
          value: selectedItem ?? itemsList.first,
          items: itemsList
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style:
                        // Style of text inside Drop Down Button
                        const TextStyle(
                      fontSize: 15,
                    ),
                  )))
              .toList(),
          onChanged: (item) {
            // setState(() {

            //     selec = item;
            //   });
            valueChanged(item!);
          }),
    );
  }
}
