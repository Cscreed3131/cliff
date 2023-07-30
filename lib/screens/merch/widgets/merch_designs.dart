import 'package:flutter/material.dart';

class MerchDesigns extends StatefulWidget {
  const MerchDesigns({super.key});

  @override
  State<MerchDesigns> createState() => _MerchDesignsState();
}

class _MerchDesignsState extends State<MerchDesigns> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    return GridView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index){
        return InkWell(

          //navigate to merch details screen
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.18,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/shirt.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Design Name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: font20,
                    fontWeight: FontWeight.bold,
                    // color: textColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton.icon(
                  onPressed: (){
                    setState(() {
                      isLiked = true;
                    });
                  },
                  icon: isLiked ? const Icon(Icons.favorite, color: Colors.redAccent,)
                      : Icon(Icons.favorite_border),
                  label: const Text('24 Likes'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
