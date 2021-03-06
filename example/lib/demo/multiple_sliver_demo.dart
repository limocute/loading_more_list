import 'package:example/common/item_builder.dart';
import 'package:example/common/tu_chong_repository.dart';
import 'package:example/common/tu_chong_source.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
    name: "fluttercandies://MultipleSliverDemo",
    routeName: "MultipleSliver",
    description: "Show how to build loading more multiple sliver list quickly")
class MultipleSliverDemo extends StatefulWidget {
  @override
  _MultipleSliverDemoState createState() => _MultipleSliverDemoState();
}

class _MultipleSliverDemoState extends State<MultipleSliverDemo> {
  TuChongRepository listSourceRepository;
  TuChongRepository listSourceRepository1;
  TuChongRepository listSourceRepository2;
  @override
  void initState() {
    listSourceRepository = new TuChongRepository();
    listSourceRepository1 = new TuChongRepository();
    listSourceRepository2 = new TuChongRepository();
    super.initState();
  }

  @override
  void dispose() {
    listSourceRepository.dispose();
    listSourceRepository1.dispose();
    listSourceRepository2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LoadingMoreCustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text("MultipleSliverDemo"),
          ),

          ///SliverList
          LoadingMoreSliverList(SliverListConfig<TuChongItem>(
            itemBuilder: ItemBuilder.itemBuilder,
            sourceList: listSourceRepository,
          )),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              child: Text("Next list"),
              color: Colors.blue,
              height: 100.0,
            ),
          ),

          ///SliverGrid
          LoadingMoreSliverList(
            SliverListConfig<TuChongItem>(
              itemBuilder: ItemBuilder.itemBuilder,
              sourceList: listSourceRepository1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: CommonExtentSliverPersistentHeaderDelegate(
                Container(
                  alignment: Alignment.center,
                  child: Text("Pinned Content"),
                  color: Colors.red,
                ),
                100.0),
            pinned: true,
          ),

          ///SliverWaterfallFlow
          LoadingMoreSliverList(
            SliverListConfig<TuChongItem>(
              itemBuilder: buildWaterfallFlowItem,
              sourceList: listSourceRepository2,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              waterfallFlowDelegate: WaterfallFlowDelegate(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonExtentSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double extent;

  CommonExtentSliverPersistentHeaderDelegate(this.child, this.extent);

  @override
  double get minExtent => extent;

  @override
  double get maxExtent => extent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(CommonExtentSliverPersistentHeaderDelegate oldDelegate) {
    //print("shouldRebuild---------------");
    return oldDelegate != this;
  }
}
