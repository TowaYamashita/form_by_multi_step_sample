import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
  const Confirm({
    super.key,
    required this.data,
  });

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: data.entries
          .map(
            (e) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e.key),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e.value),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
