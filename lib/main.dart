import 'dart:io';

import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:client_project/View/Screens/ban_ip.dart';
import 'package:client_project/View/Screens/vpn.dart';
import 'package:client_project/View/Screens/web_view.dart';
import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//>>>
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                mAction();
              },
              child: const Text("Check Vpn"),
            ),
            ElevatedButton(
                onPressed: () {
                  mAction2();
                },
                child: const Text(" Check Vpn Custom way")),
            ElevatedButton(
                onPressed: () {
                  mAction3();
                },
                child: const Text("Next Page")),
            ElevatedButton(
                onPressed: () {
                  mAction4();
                },
                child: const Text("Ban Ip")),
            ElevatedButton(
                onPressed: () {
                  mAction5();
                },
                child: const Text("Get Data from website")),
          ],
        ),
      ),
    );
  }

  void mAction() async {
    if (await CheckVpnConnection.isVpnActive()) {
      print("Vpn Connected");
    } else {
      print("Vpn is not connnected");
    }
  }

  void mAction2() async {
    bool isVpnActive;
    List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false, type: InternetAddressType.any);
    interfaces.isNotEmpty
        ? isVpnActive = interfaces.any((interface) =>
            interface.name.contains("tun") ||
            interface.name.contains("ppp") ||
            interface.name.contains("pptp"))
        : isVpnActive = false;
    if (isVpnActive) {
      print("Custom: Vpn is Connected");
    } else {
      print("Custom: Vpn is not connected");
    }
  }

  void mAction3() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const MyVpnScreen();
    }));
  }

  void mAction4() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BanIpScreen();
    }));
  }

  void mAction5() async {
    /*  final response = await http.get(Uri.parse("https//google.com/api"));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print("Response Data: ${data.toString()}");
    } else {
      throw Exception("Failed to fetch data!");
    } */
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MyWebViewScreen();
    }));
  }
}
