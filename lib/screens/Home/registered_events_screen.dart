import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisteredEventsScreen extends StatefulWidget {
  const RegisteredEventsScreen({super.key});
  // static const routeName = 'registered-events';

  @override
  State<RegisteredEventsScreen> createState() => _RegisteredEventsScreenState();
}

class _RegisteredEventsScreenState extends State<RegisteredEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase ListView Builder')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          // Extract the documents from the snapshot
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              // Get the array from the document
              List<dynamic> arrayData = documents[index]['events_registered'];

              // Use the array to build the list items
              return Card(
                child: ListTile(
                  title: Text(
                      'Document ${index + 1}'), // Replace with your desired title
                  subtitle: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: arrayData.length,
                    itemBuilder: (context, subIndex) {
                      // Create a separate tile for each array element
                      return ListTile(
                        title: Text(
                            'Array Item ${subIndex + 1}: ${arrayData[subIndex]}'),
                        // Customize the tile based on array element
                        // For example, you can use arrayData[subIndex] to access the element.
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
