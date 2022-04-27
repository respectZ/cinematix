import 'package:cinematix/page/movie/movie_detail.dart';
import 'package:cinematix/page/profil/profil.dart';
import 'package:flutter/material.dart';
import 'cinematix_bar.dart';

import 'package:get/get.dart';

class CinematixHome extends StatefulWidget {
  CinematixHome({Key? key, required this.onGoing, required this.upComing})
      : super(key: key);
  final List<Widget> onGoing;
  final List<Widget> upComing;

  @override
  _CinematixHomeState createState() => _CinematixHomeState();
}

class _CinematixHomeState extends State<CinematixHome>
    with TickerProviderStateMixin {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500);
  // ignore: unused_field
  late final List<List<Widget>> _filmList = [widget.onGoing, widget.upComing];
  late TabController _tabController;

  int _tabIndex = 0;

  void _tabSection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabSection);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "CINEMATIX",
          style: TextStyle(color: Color.fromARGB(255, 0, 166, 232)),
        ),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Artline660",
                style: TextStyle(color: Colors.black87),
              )),
          IconButton(
            onPressed: () => Get.toNamed("/profile"),
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black87,
            ),
            iconSize: 20,
          )
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          child: Column(
            children: [
              Container(
                  width: 300,
                  height: 75,
                  alignment: Alignment.topLeft,
                  child: Column(children: [
                    Row(children: const [
                      Icon(Icons.location_on),
                      Text("CGV ROXY SQUARE JEMBER")
                    ]),
                    TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        tabs: [Tab(text: "ONGOING"), Tab(text: "UPCOMING")])
                  ])),
              Container(
                width: 300,
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(5, 10),
                          spreadRadius: -10)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3.75 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 20),
                    itemCount: _filmList[_tabIndex].length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                          onTap: () => Get.toNamed("/movie_detail"),
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            alignment: Alignment.center,
                            child: _filmList[_tabIndex][index],
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                          ));
                    }),
              )
            ],
          )),
      bottomNavigationBar: const CinematixBar(),
    );
  }
}
