import 'package:flutter/material.dart';
import 'package:passful/main.dart';
import 'package:passful/custom_icons_icons.dart';
import 'package:passful/ticket_shop.dart';
import 'package:passful/payment_history.dart';

class PassesHistoryWidget extends StatefulWidget {
  const PassesHistoryWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PassesHistoryWidgetState();
}

class _PassesHistoryWidgetState extends State<PassesHistoryWidget> {
  bool recent = true;

  List<List<String>> passes = [
    ['14/09/2021', 'Perissos', 'Elliniko', '18:00', '18:20'],
    ['14/09/2021', 'Elliniko', 'Perissos', '23:40', '00:00'],
    ['08/11/2021', 'Nomismatokopio', 'Katehaki', '08:20', '08:30'],
    ['08/11/2021', 'Katehaki', 'Evaggelismos', '10:30', '10:35'],
    ['08/11/2021', 'Evaggelismos', 'Nomismatokopio', '12:25', '12:40'],
    ['10/11/2021', 'Agia Paraskevi', 'Doukissis Plakentias', '12:40', '12:45'],
    ['19/11/2021', 'Nomismatokopio', 'Syntagma', '18:05', '18:10'],
    ['19/11/2021', 'Syntagma', 'Panepistimio', '18:10', '18:27'],
    ['19/11/2021', 'Panepistimio', 'Syntagma', '10:00', '10:17'],
    ['19/11/2021', 'Syntagma', 'Nomismatokopio', '13:00', '13:10'],
    ['20/11/2021', 'Nomismatokopio', 'Monastiraki', '15:00', '15:10'],
    ['20/11/2021', 'Monastiraki', 'Omonoia', '15:10', '15:30'],
    ['01/12/2021', 'Nomismatokopio', 'Ampelokipoi', '11:00', '11:12'],
    ['10/12/2021', 'Katehaki', 'Nomismatokopeio', '14:45', '15:00'],
    ['23/12/2021', 'Nomismatokopio', 'Megaro Mousikis', '12:00', '12:15'],
    ['23/12/2021', 'Megaro Mousikis', 'Holargos', '14:30', '14:45'],
    ['23/12/2021', 'Holargos', 'Nomismatokopio', '17:00', '17:05'],
    ['24/12/2021', 'Nomismatokopio', 'Keramikos', '11:30', '11:50'],
    ['12/01/2022', 'Nomismatokopio', 'Aerodromio', '07:00', '07:45']
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Scaffold(
          appBar: AppBar(
              //leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}, tooltip: 'Menu',),
              title: const Text('Passes History'),
              backgroundColor: const Color.fromARGB(255, 17, 64, 240),
              actions: <Widget>[
                IconButton(
                    icon: !recent
                        ? const Icon(CustomIcons.sort_alt_down)
                        : const Icon(CustomIcons.sort_alt_up),
                    tooltip:
                        recent ? 'Sort by most recent' : 'Sort by least recent',
                    padding:
                        const EdgeInsets.all(20.0), // tooltip: 'Hello World',
                    onPressed: () {
                      setState(() {
                        recent = !recent;
                      });
                    })
              ]),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const MyApp()));
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
                    Navigator.of(context).pop();
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
          body: ListView(
            children: ListTile.divideTiles(
                    context: context,
                    tiles: !recent
                        ? passes.map((pass) {
                            return ListTile(
                                minVerticalPadding: 15,
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(pass[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                subtitle: Column(children: [
                                  Row(children: [
                                    Text('From: ${pass[1]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    const Spacer(),
                                    Text(pass[3])
                                  ]),
                                  Row(children: [
                                    Text('From: ${pass[2]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    const Spacer(),
                                    Text(pass[4])
                                  ])
                                ]));
                          })
                        : passes.reversed.toList().map((pass) {
                            return ListTile(
                                minVerticalPadding: 15,
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(pass[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                subtitle: Column(children: [
                                  Row(children: [
                                    Text('From: ${pass[1]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    const Spacer(),
                                    Text(pass[3])
                                  ]),
                                  Row(children: [
                                    Text('From: ${pass[2]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    const Spacer(),
                                    Text(pass[4])
                                  ])
                                ]));
                          }))
                .toList(),
          ));
    });
  }
}
