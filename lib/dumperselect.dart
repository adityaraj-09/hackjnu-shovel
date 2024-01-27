import 'package:flutter/material.dart';

class DumperSelectionPage extends StatefulWidget {
  @override
  _DumperSelectionPageState createState() => _DumperSelectionPageState();
}

class _DumperSelectionPageState extends State<DumperSelectionPage> {
  String? selectedDumper;
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Dumper'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (var i = 1; i <= 3; i++)
            ListTile(
              title: Text('Dumper $i'),
              leading: Radio<String>(
                value: 'Dumper $i',
                groupValue: selectedDumper,
                onChanged: (String? value) {
                  setState(() {
                    selectedDumper = value;
                  });
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}
