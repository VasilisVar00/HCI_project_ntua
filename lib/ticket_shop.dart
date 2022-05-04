import 'package:flutter/material.dart';
import 'package:passful/custom_icons_icons.dart';
import 'package:passful/main.dart';
import 'package:passful/passes_history.dart';
import 'package:passful/payment_history.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class TicketShopWidget extends StatefulWidget {
  const TicketShopWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TicketShopWidgetState();
}

class _TicketShopWidgetState extends State<TicketShopWidget> {
  // Method that displays purchase information dialog
  Future<void> _showPurchase(
      context, choice, price, remainingPasses, icon) async {
    bool notifs = false;

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Column(children: const [
                Text('Your selection'),
                Divider(color: Colors.black)
              ]),
              content: SizedBox(
                  height: 60,
                  child: Column(children: [
                    Text(choice,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black)),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(price,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black)),
                        const Text('€ - Pay with Google Pay',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ],
                    )
                  ])),
              actions: <Widget>[
                // Switch(value: state, onChanged: _onSwitch),
                IconButton(
                    icon: notifs
                        ? const Icon(Icons.notifications)
                        : const Icon(Icons.notifications_off),
                    onPressed: () {
                      setState(() {
                        notifs = !notifs;
                        // print(notifs);
                      });
                    }),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('NO',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    pushPayment(choice, price, remainingPasses, icon),
                    _showSuccess(context)
                  },
                  child: const Text('YES',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          });
        });
  }

  void pushPayment(type, price, remainingPasses, icon) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(now);
    Payment temp = Payment(
        type: type,
        date: formattedDate,
        price: price,
        remainingPasses: remainingPasses,
        icon: icon);
    paymentList.add(temp);
    copy.add(temp);
  }

  // Method that displays successful payment dialog
  Future<void> _showSuccess(context) async {
    late Timer _timer;
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          _timer = Timer(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            content: SizedBox(
                height: 60,
                child: Column(children: const [
                  Icon(Icons.check_circle_rounded, color: Colors.cyanAccent),
                  SizedBox(height: 15),
                  Text('Your payment was succesful!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black)),
                ])),
          );
        }).then((val) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}, tooltip: 'Menu',),
            title: const Text('Ticket Shop'),
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
                  Navigator.of(context).pop();
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
        body: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: const Text('Single Ticket',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  CustomIcons.ticket,
                  color: Colors.black,
                ),
                onTap: () {
                  _showPurchase(context, 'Single Ticket', '1.2', '1',
                      const Icon(CustomIcons.ticket, color: Colors.black));
                },
              ),
              ListTile(
                title: const Text('Single Ticket (Student)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  CustomIcons.graduation_cap,
                  color: Colors.black,
                ),
                onTap: () {
                  _showPurchase(
                      context,
                      'Single Ticket (Student)',
                      '0.5',
                      '1',
                      const Icon(CustomIcons.graduation_cap,
                          color: Colors.black));
                },
              ),
              ListTile(
                title: const Text('5 Tickets',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  CustomIcons.ticket,
                  color: Colors.black,
                ),
                onTap: () {
                  _showPurchase(context, '5 Tickets', '5', '5',
                      const Icon(CustomIcons.ticket, color: Colors.black));
                },
              ),
              ListTile(
                title: const Text('10 Tickets',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  CustomIcons.ticket,
                  color: Colors.black,
                ),
                onTap: () {
                  _showPurchase(context, '10 Tickets', '10', '10',
                      const Icon(CustomIcons.ticket, color: Colors.black));
                },
              ),
              ListTile(
                title: const Text('Monthly Ticket',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  CustomIcons.calendar,
                  color: Colors.black,
                ),
                onTap: () {
                  _showPurchase(context, 'Monthly Ticket', '30', 'Infinite',
                      const Icon(CustomIcons.calendar, color: Colors.black));
                },
              ),
              ListTile(
                title: const Text('Monthly Ticket (Student)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  CustomIcons.graduation_cap,
                  color: Colors.black,
                ),
                onTap: () {
                  _showPurchase(
                      context,
                      'Monthly Ticket (Student)',
                      '15',
                      'Infinite',
                      const Icon(CustomIcons.graduation_cap,
                          color: Colors.black));
                },
              ),
              ListTile(
                title: const Text('Airport',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(
                  CustomIcons.flight,
                  color: Colors.black,
                ),
                onTap: () {
                  _showPurchase(context, 'Airport', '4', '1',
                      const Icon(CustomIcons.flight, color: Colors.black));
                },
              ),
            ],
          ).toList(),
        ));
  }
}
