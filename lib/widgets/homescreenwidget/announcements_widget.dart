import 'package:cliff/provider/announcements_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementWidget extends ConsumerWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getUpdates = ref.watch(announcementsStreamProvider);
    return getUpdates.when(
      data: (data) {
        int itemCount = data.length;
        return itemCount > 0
            ? MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemCount: itemCount,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      data[index].message,
                                    ),
                                    subtitle: data[index].link != ''
                                        ? TextButton(
                                            child: Text(
                                              data[index].link,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                decoration:
                                                    TextDecoration.underline,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            onLongPress: () async {
                                              // copy to Clipboard
                                              await Clipboard.setData(
                                                ClipboardData(
                                                  text: data[index].link,
                                                ),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .removeCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Code copied to clipboard'),
                                                ),
                                              );
                                            },
                                            onPressed: () async {
                                              // Open the link in a browser
                                              Uri url =
                                                  Uri.parse(data[index].link);
                                              try {
                                                await launchUrl(
                                                  url,
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              } catch (e) {
                                                print(e);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Could not launch $url'),
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                        : null,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          DateFormat('dd-MM-yy')
                                              .format(data[index].dateTime),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        DateFormat('hh:mm a')
                                            .format(data[index].dateTime),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nothing to update about',
                      style: TextStyle(
                        height: 0,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
      },
      error: (error, stackTrace) {
        return const Text("Can't load Announcements");
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
