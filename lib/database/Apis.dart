import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackjnu_dumper/map_provider.dart';
import 'package:hackjnu_dumper/startPage.dart';
import 'package:hackjnu_dumper/utils/constants.dart';
import 'package:hackjnu_dumper/utils/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<String> gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('x-auth-token');
    return "";
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      var res = await http.post(Uri.parse('$ServerUrl/frontend/authenticate'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (data['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', res.body);
        await prefs.setString('autho', data['autho']);

        return true;
      } else {
        // ignore: use_build_context_synchronously
        showSnakbar(context, Colors.red, data["message"]);
        return false;
      }
    } catch (e) {
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  Future<bool> regsiter(String name, String email, String password, String type,
      BuildContext context) async {
    try {
      var res = await http.post(Uri.parse('$ServerUrl/frontend/register'),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
            'type': type
          }),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (data['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', res.body);
        await prefs.setString('autho', data['autho']);

        return true;
      } else {
        // ignore: use_build_context_synchronously
        showSnakbar(context, Colors.red, data["message"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  Future<bool> getShovel(String id, BuildContext context) async {
    try {
      var res = await http.post(Uri.parse('$ServerUrl/getShovel'),
          body: jsonEncode({"dumpId": id}),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Provider.of<MapProvider>(context, listen: false)
            .setSelectedShovel(data);
        return true;
      } else {
        showSnakbar(context, Colors.red, data["msg"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  Future<bool> startDumping(BuildContext context, String id, List loc) async {
    try {
      var res = await http.post(Uri.parse('$ServerUrl/startDumping'),
          body: jsonEncode({"dumpId": id, "loc": loc}),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Provider.of<MapProvider>(context, listen: false)
            .setSelectedDumper(data);
        return true;
      } else {
        showSnakbar(context, Colors.red, data["msg"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  Future<bool> resetDumper(BuildContext context, String id, List loc) async {
    try {
      var res = await http.post(Uri.parse('$ServerUrl/reset'),
          body: jsonEncode({"dumpId": id, "loc": loc}),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Provider.of<MapProvider>(context, listen: false)
            .setSelectedDumper(data);
        return true;
      } else {
        showSnakbar(context, Colors.red, data["msg"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  Future<bool> shovels(BuildContext context, int i) async {
    try {
      var res = await http.get(Uri.parse('$ServerUrl/shovels'),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Provider.of<MapProvider>(context, listen: false)
            .setSelectedShovel(data[i]);

        return true;
      } else {
        showSnakbar(context, Colors.red, data["msg"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  void findDumper(String id, BuildContext context) {
    var d = Provider.of<MapProvider>(context, listen: false).dumpers;
    for (var dumper in d) {
      if (dumper["_id"] == id) {
        Provider.of<MapProvider>(context, listen: false)
            .setSelectedDumper(dumper);
      }
    }
  }

  Future<bool> shovelsById(BuildContext context, String id) async {
    try {
      var res = await http.get(Uri.parse('$ServerUrl/shovel/' + id),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Provider.of<MapProvider>(context, listen: false)
            .setSelectedShovel(data);
        if (data["dumperConn"] != "") {
          findDumper(data["dumperConn"], context);
        }

        return true;
      } else {
        showSnakbar(context, Colors.red, data["msg"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  Future<bool> getdumpers(BuildContext context) async {
    try {
      var res = await http.get(Uri.parse('$ServerUrl/dumpers'),
          headers: <String, String>{
            'content-Type': 'application/json; charset=UTF-8'
          });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Provider.of<MapProvider>(context, listen: false).setDumpers(data);

        return true;
      } else {
        showSnakbar(context, Colors.red, data["msg"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showSnakbar(context, Colors.red, e.toString());
      return false;
    }
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear().then((value) => {
            if (value)
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => StartPage()),
                    (Route route) => false)
              }
            else
              {showSnakbar(context, Colors.red, "something went wrong")}
          });
    } catch (e) {
      showSnakbar(context, Colors.red, e.toString());
    }
  }
}
