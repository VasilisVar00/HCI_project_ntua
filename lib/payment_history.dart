import 'package:flutter/material.dart';
import 'package:passful/main.dart';
import 'package:passful/ticket_shop.dart';
import 'package:passful/passes_history.dart';
import 'package:passful/custom_icons_icons.dart';

class PaymentHistoryWidget extends StatefulWidget {
  const PaymentHistoryWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaymentHistoryWidgetState();
}

class _PaymentHistoryWidgetState extends State<PaymentHistoryWidget> {
  bool recent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Payment History'),
          backgroundColor: const Color.fromARGB(255, 17, 64, 240),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              tooltip: 'Delete payment history',
              onPressed: () {
                setState(() {
                  paymentList.clear();
                });
              },
            ),
            IconButton(
                icon: !recent
                    ? const Icon(CustomIcons.sort_alt_down)
                    : const Icon(CustomIcons.sort_alt_up),
                tooltip:
                    recent ? 'Sort by most recent' : 'Sort by least recent',
                padding: const EdgeInsets.all(20.0),
                onPressed: () {
                  setState(() {
                    recent = !recent;
                    // print(recent);
                  });
                })
          ]),
      drawer: Drawer(
          child: ListView(children: [
        //use: UserAccountsDrawerHeader
        UserAccountsDrawerHeader(
          accountName: const Text('Passful'),
          accountEmail: const Text('Your public transport companion'),
          currentAccountPicture: ClipRRect(
            borderRadius: BorderRadius.circular(110),
            child: Image.asset('assets/images/passful_circle.png'),
          ),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 17, 64, 240)),
        ),
        ListTile(
          title:
              const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
          leading: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const MyApp()));
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
            Navigator.of(context).pop();
          },
        )
      ])),
      body: ListView(
          children: ListTile.divideTiles(
                  context: context,
                  tiles: recent
                      ? paymentList.reversed.toList().map((p) {
                          return ListTile(
                            minVerticalPadding: 15,
                            leading: p.icon,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(p.type,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            subtitle: Text('Purchased on: ${p.date}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            trailing: Text('${p.price}€',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                          );
                        })
                      : paymentList.map((p) {
                          return ListTile(
                            minVerticalPadding: 15,
                            leading: p.icon,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(p.type,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            subtitle: Text('Purchased on: ${p.date}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            trailing: Text('${p.price}€',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                          );
                        }))
              .toList()),
    );
  }
}
