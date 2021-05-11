import 'package:flutter/material.dart';
import 'dart:math' as math;

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAnimatedList(
            itemBuilder: (context, index, animation) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$index"),
              );
            },
            initialItemCount: 5,
          ),

          //
          SliverAppBar(
            title: Text("Hello Da"),
          ),
          //

          SliverPersistentHeader(
              floating: true,

              //  pinned: true,
              delegate: _SliverAppBarDelegate(
                  minHeight: 10,
                  maxHeight: 40,
                  child: Container(
                      color: Colors.pink,
                      child: Center(child: Text("Hello"))))),

          //
          SliverGrid(
              delegate: SliverChildListDelegate(List.generate(
                24,
                (index) => Container(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0)),
              )
                  //   [
                  //   Container(color: Colors.red),
                  //   Container(color: Colors.purple),
                  //   Container(color: Colors.green),
                  //   Container(color: Colors.orange),
                  //   Container(color: Colors.yellow),
                  // ]
                  ),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4)),

          //
          SliverList(
              delegate: SliverChildListDelegate(List.generate(
                  25,
                  (index) => Container(
                        width: 50,
                        height: 50,
                        child: Text("$index"),
                      )))),

          //
          SliverGrid.count(
            crossAxisCount: 6,
            children: List.generate(
              24,
              (index) => Container(
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0)),
            ),
          ),

          //
          SliverPadding(
              padding: EdgeInsets.all(25),
              sliver:
                  //
                  SliverReorderableList(
                key: UniqueKey(),
                itemBuilder: (con, index) {
                  return Container(
                      key: UniqueKey(), child: Text(" I miss you" + "$index"));
                },
                itemCount: 2,
                onReorder: (a, b) {},
              )),
        ],
      ),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
