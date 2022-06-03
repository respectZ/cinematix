import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import '../../model/cinema_chair.dart';
import '../../model/cinema_layout.dart';
import 'package:cinematix/model/ticket.dart';

import 'dart:math';
import 'dart:developer' as dev;

String _formatRupiah({required int price, bool decimal = false}) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: decimal ? 2 : 0,
  );
  return currencyFormatter.format(price);
}

Widget _buildSchedule() {
  return ListView(
      scrollDirection: Axis.horizontal,
      children: List<int>.generate(10, (i) => i).map((i) {
        return Container(
          width: 200.0,
          child: ListView(
              //shrinkWrap: true,
              //physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<int>.generate(Random().nextInt(20) + 1, (i) => i)
                  .map((j) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$j item of $i row")),
                );
              }).toList()),
        );
      }).toList());
}

Widget BuildChair(
    {required List<CinemaChair> chair,
    double? width,
    required List<CinemaChair> selectedChair,
    required Function(CinemaChair) callback}) {
  // Chair.add(CinemaChair(
  //     id: 9999,
  //     row: 15,
  //     column: 1,
  //     rightMargin: 0,
  //     bottomMargin: 0,
  //     code: "UB"));
  int rowSize = chair.map<int>((element) => element.getRow()).reduce(max) + 1;
  int colSize =
      chair.map<int>((element) => element.getColumn()).reduce(max) + 1;

  Row row = Row(
      children: List<Widget>.generate(
          rowSize,
          (index) => SizedBox(
                width: 10,
              )));
  Column col = Column(
    children: List<Widget>.generate(
      colSize,
      (_) => Row(
        children: List<Widget>.generate(
          rowSize,
          (index) => SizedBox(
            width: 10,
          ),
        ),
      ),
    ),
  );
  chair.forEach((element) {
    (col.children[element.getColumn()] as Row).children[element.getRow()] =
        Container(
      margin: EdgeInsets.all(2.0),
      width: 40,
      height: 40,
      child: Card(
        color: selectedChair.contains(element) ? Colors.blue : Colors.white,
        child: InkWell(
          onTap: () {
            callback(element);
          },
          splashColor: Colors.blue.withAlpha(30),
          child: Center(child: Text(element.getCode())),
        ),
      ),
    );
  });
  return Center(
    child: ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        SizedBox(
          width: (44 * rowSize).toDouble(),
          child: Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [col],
            ),
          ),
        )
      ],
    ),
  );
}

class MovieTicketPage extends StatefulWidget {
  const MovieTicketPage({Key? key}) : super(key: key);

  @override
  State<MovieTicketPage> createState() => _MovieTicketPageState();
}

class _MovieTicketPageState extends State<MovieTicketPage> {
  List<CinemaChair> selectedChair = [];

  List<CinemaChair> Chair = List<CinemaChair>.generate(100, (index) {
    var _tempCol = index % 10;
    var _tempRow = index ~/ 10;
    return CinemaChair(
        id: index,
        row: _tempRow,
        column: _tempCol,
        rightMargin: 0,
        bottomMargin: 0,
        code: "${String.fromCharCode(_tempRow + 65)}${_tempCol}");
  });
  List<Ticket> Tickets = List<Ticket>.generate(100, (index) {
    return Ticket(id: index, cinemaChairId: index, price: 25000);
  });

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final layoutHeight = 6 / 10 * screenHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "CINEMATIX",
          style: TextStyle(color: Color.fromARGB(255, 0, 166, 232)),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
              child: Text("Pilih Kursi"),
            ),
            Container(
                margin: EdgeInsets.all(12.0),
                height: layoutHeight,
                child: BuildChair(
                    chair: Chair,
                    width: screenWidth,
                    selectedChair: selectedChair,
                    callback: (CinemaChair _chair) {
                      setState(() {
                        selectedChair.contains(_chair)
                            ? selectedChair.remove(_chair)
                            : selectedChair.add(_chair);
                      });
                    })),
            Text("_" * 15),
            SizedBox(
              height: 15,
            ),
            Text("${selectedChair.map((e) => e.getCode()).join(' ')}"),
            SizedBox(
              height: 15,
            ),
            Text(_formatRupiah(
                price: Tickets.map((e) {
              return selectedChair.map((e2) => e2.getId()).contains(e.getId())
                  ? e.getPrice()
                  : 0;
            }).toList().reduce((value, element) => value + element))),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 45,
          child: ElevatedButton(
            style: selectedChair.length == 0
                ? ElevatedButton.styleFrom(primary: Colors.grey)
                : ElevatedButton.styleFrom(),
            onPressed: (() {}),
            child: Text("Beli Tiket"),
          )),
    );
  }
}
