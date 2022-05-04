import 'package:passful/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:passful/ticket_shop.dart';
import 'package:passful/passes_history.dart';
import 'package:passful/payment_history.dart';

import 'dart:async';

String validUntil = '23/01/2023 10:00';

class Payment {
  Payment(
      {required this.type,
      required this.date,
      required this.price,
      required this.remainingPasses,
      required this.icon});
  final String type, date, price, remainingPasses;
  final Icon icon;
}

Payment defaultValue = Payment(
    type: 'Monthly Ticket',
    date: '23/01/2022 10:00',
    price: '30',
    remainingPasses: 'Infinite',
    icon: const Icon(CustomIcons.calendar, color: Colors.black));

final List<Payment> paymentList = <Payment>[defaultValue];
final List<Payment> copy = <Payment>[defaultValue];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}, tooltip: 'Menu',),
            title: const Text('Passful'),
            backgroundColor: const Color.fromARGB(255, 17, 64, 240)),
        drawer: Drawer(
          child: ListView(
            children: [
              //use: UserAccountsDrawerHeader
              UserAccountsDrawerHeader(
                accountName: const Text('Passful'),
                accountEmail: const Text('Your public transport companion'),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(110),
                  child: Image.asset('assets/images/passful_circle.png'),
                ),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 17, 64, 240)),
              ),
              ListTile(
                title: const Text('Home',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Ticket Shop',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TicketShopWidget()));
                },
              ),
              ListTile(
                title: const Text('Passes History',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.train,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PassesHistoryWidget()));
                },
              ),
              ListTile(
                title: const Text('Payment History',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.payment,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PaymentHistoryWidget()));
                },
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('My Card',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 64, 240),
                        fontSize: 25))),
            Stack(alignment: Alignment.bottomCenter, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('assets/images/card.png'),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                          onPressed: () => {_showDialog(context)},
                          icon: const Icon(Icons.more_horiz),
                          color: Colors.white))),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('*** *** **13',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          )))),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Column(children: const [
                Center(
                    child:
                        Icon(Icons.nfc, color: Color.fromARGB(153, 0, 0, 0), size: 30)),
                Center(
                    child: Text('Hold near reader',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(153, 0, 0, 0),
                            fontSize: 13)))
              ]),
            ),
          ]),
        ));
  }
}

Future<void> _showDialog(context) async {
  String type = copy.last.type;
  String validSince = copy.last.date;
  String date = validSince.split(' ')[0];
  String time = validSince.split(' ')[1];
  String year = date.split('/')[2];

  String validUntil = date.split('/')[0] +
      '/' +
      date.split('/')[1] +
      '/' +
      (int.parse(year) + 1).toString() +
      ' ' +
      time;
  String remainingPasses = copy.last.remainingPasses;

  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Column(children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/images/card.png'),
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('123 589 8913',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ))))
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(children: [
                  Row(
                    children: [
                      const Text('Type: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                      Text(type,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('Valid Since: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                      Text(validSince,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('Valid Until: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                      Text(validUntil,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('Remaining Passes: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                      Text(remainingPasses,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black)),
                    ],
                  )
                ]))
          ]),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('DONE',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      });
}
