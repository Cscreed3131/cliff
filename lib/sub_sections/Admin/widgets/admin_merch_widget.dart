import 'package:cliff/sub_sections/Admin/add_designs_screen.dart';
import 'package:flutter/material.dart';

class AdminMerchWidget extends StatefulWidget {
  const AdminMerchWidget({super.key});

  @override
  State<AdminMerchWidget> createState() => _AdminMerchWidgetState();
}

class _AdminMerchWidgetState extends State<AdminMerchWidget> {
  List<MerchItem> merchs = [
    //random image link in place on merch image
    MerchItem('T-Shirt', 'https://picsum.photos/250/300'),
    MerchItem('Hoodie', 'https://picsum.photos/220/300'),
    MerchItem('Mug', 'https://picsum.photos/200/200'),
    MerchItem('T-Shirt', 'https://picsum.photos/500/300'),
    MerchItem('Hoodie', 'https://picsum.photos/260/300'),
    MerchItem('Mug', 'https://picsum.photos/200/100'),
    MerchItem('T-Shirt', 'https://picsum.photos/250/300'),
    MerchItem('Hoodie', 'https://picsum.photos/207/300'),
    MerchItem('Mug', 'https://picsum.photos/200/370'),
    MerchItem('T-Shirt', 'https://picsum.photos/230/300'),
    MerchItem('Hoodie', 'https://picsum.photos/202/300'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '20',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          fontFamily: 'IBMPlexMono',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'total items',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'all time',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontFamily: 'IBMPlexMono',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '04',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          fontFamily: 'IBMPlexMono',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'total sales',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'this month',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontFamily: 'IBMPlexMono',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          //elevated button saying add merch
          Center(
            child: FilledButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AddDesignsScreen.routeName);
              },
              icon: Icon(Icons.add),
              label: Text(
                'Add Merch',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'IBMPlexMono',
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Text(
            'My Merch',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontFamily: 'IBMPlexMono',
            ),
          ),
          const SizedBox(height: 10),

          //gridview of merch items
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: merchs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: NetworkImage(merchs[index].imgLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      merchs[index].name,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontFamily: 'IBMPlexMono',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MerchItem {
  String name;
  String imgLink;

  MerchItem(this.name, this.imgLink);
}
