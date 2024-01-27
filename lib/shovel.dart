import 'package:flutter/material.dart';
import 'package:hackjnu_dumper/database/Apis.dart';
import 'package:hackjnu_dumper/moving.dart';
import 'package:hackjnu_dumper/startPage.dart';
import 'package:hackjnu_dumper/utils/widgets.dart';

class Dumper extends StatefulWidget {
  const Dumper({super.key});

  @override
  State<Dumper> createState() => _DumperState();
}

class _DumperState extends State<Dumper> {
  String selectedValue = 'Select Shovel';
  String status = "Fetch Data";
  bool isloading = false; // Default selected value
  ApiService apiService = ApiService();
  // Sample list of dropdown items
  List<String> dropdownItems = ['Select Shovel','Shovel 1', 'Shovel 2', 'Shovel 3'];
  void getDumperData(String value) {
    int i = 0;
    if (value == "Shovel 1") {
      i = 0;
    } else if (value == "Shovel 2") {
      i = 1;
    } else {
      i = 2;
    }
    apiService.shovels(context, i).then((value) => {
          setState(() {
            status = "Proceed";
            isloading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Shovel'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            dropdown(context),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: () {
                nextScreenReplace(context, StartPage());
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 40,
                child: Center(
                    child: isloading
                        ? CircularProgressIndicator(color: Colors.white,)
                        : Text(
                            status,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Colors.white),
                          )),
                decoration: BoxDecoration(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dropdown(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: DropdownButton<String>(
        underline: null,
        focusColor: null,
        value: selectedValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        onChanged: (newValue) {
          if(newValue!="Select Shovel"){
      setState(() {
            isloading = true;
            selectedValue = newValue!;
          });
          getDumperData(newValue!);
          }
          
        },
        items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
