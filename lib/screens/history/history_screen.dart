import 'package:cliff/screens/history/widgets/events_history.dart';
import 'package:cliff/screens/history/widgets/food_history.dart';
import 'package:cliff/screens/history/widgets/merch_history.dart';
import 'package:cliff/screens/history/widgets/order_page.dart';
import 'package:cliff/widgets/homescreenwidget/app_drawer.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history';
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin{

  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) =>[
          SliverAppBar(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
            ),
            pinned: true,
            title: Text(
              'History',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: 'IBMPlexMono',
                fontWeight: FontWeight.bold,
              ),
            ),

            /*flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                  left: innerBoxIsScrolled ? 50 : 20,
                  bottom: innerBoxIsScrolled ? screenWidth * 0.06 : screenWidth * 0.01
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'History',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'IBMPlexMono',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),*/

            //tab bar with 3 items
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Orders',
                ),
                Tab(
                  text: 'Food',
                ),
                Tab(
                  text: 'Events',
                ),
                Tab(
                  text: 'Merch',
                ),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [
            //orders tab
            OrderPage(),

            //food tab
            FoodHistory(),

            //event tab
            EventsHistoryWidget(),

            //merch tab
            MerchHistory(),
          ]
        ),
      )
    );
  }
}
