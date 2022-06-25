import 'package:cinematix/model/payment_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> paymentType = ["DANA", "OVO"];
  int selectedIndex = -1;
  Future<List<PaymentType>> paymentTypes = PaymentType.getPayments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Pembayaran",
            style: TextStyle(color: Color.fromARGB(255, 0, 166, 232)),
          ),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black45,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Metode Pembayaran",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blueGrey[900],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              FutureBuilder<List<PaymentType>>(
                  future: paymentTypes,
                  builder: (BuildContext builder,
                      AsyncSnapshot<List<PaymentType>> snapshot) {
                    if (snapshot.hasData) {
                      List<PaymentType> payments = snapshot.data!;
                      return ListView.builder(
                        itemCount: payments.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              border: index != 0
                                  ? Border(
                                      top: BorderSide(
                                          width: 0.5, color: Colors.black),
                                    )
                                  : null,
                            ),
                            child: ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                selected: index == selectedIndex,
                                selectedColor: Colors.black,
                                selectedTileColor: Colors.blue.shade500,
                                leading: CircleAvatar(
                                  backgroundImage: payments[index].getIcon(),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_rounded),
                                  color: Colors.blue,
                                ),
                                title: Text(payments[index].getName())),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Total Pembayaran"),
                  Text("Rp 45.000"),
                ],
              ),
              SizedBox(
                width: 24,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: selectedIndex == -1 ? Colors.grey : Colors.blue),
                  onPressed: () => {},
                  child: Text("Beli Tiket")),
              SizedBox(
                width: 12.0,
              )
            ],
          ),
        ));
  }
}
