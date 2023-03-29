import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BanIpScreen extends StatefulWidget {
  const BanIpScreen({super.key});

  @override
  State<BanIpScreen> createState() => _BanIpScreenState();
}

class _BanIpScreenState extends State<BanIpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ban Ip of a country")),
      body: Center(
        child: FutureBuilder<bool>(
          future: isBannedCountry(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data!) {
                return Text("Access denied.");
              } else {
                return Text("Welcome to the app!");
              }
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<bool> isBannedCountry() async {
    try {
      final response = await http.get(Uri.parse("https://freegeoip.io/json/"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["country_code"]);
        if (data["country_code"] == "CN") {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}
