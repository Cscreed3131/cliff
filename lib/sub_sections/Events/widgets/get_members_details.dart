import 'package:cliff/provider/club_members_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetMemberDetails extends ConsumerWidget {
  final String sic;
  const GetMemberDetails({
    super.key,
    required this.sic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubMemberdetails = ref.watch(clubMemberDetailsProvider(sic));
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final font24 = screenHeight * 0.02;

    return clubMemberdetails.when(data: (data) {
      final String imageUrl = data['image_url'];
      final String name = data['name'];
      final String phoneNumber = data['phoneNumber'];
      final String year = data['year'];
      return ListTile(
        leading: CircleAvatar(
          radius: screenWidth * 0.065,
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        isThreeLine: true,
        title: Text(
          name,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'Year: $year \nPhone Number: $phoneNumber',
          overflow: TextOverflow.ellipsis,
        ),
        titleTextStyle: TextStyle(
          fontSize: font24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      );
    }, error: (error, stackTrace) {
      print(error);
      print(stackTrace);
      return const Text('Could not load contact details');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
