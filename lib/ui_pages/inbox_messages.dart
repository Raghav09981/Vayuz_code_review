import 'package:flutter/material.dart';
import '../components/inbox_card.dart';
import '../components/letter_style.dart';

class InboxMessages extends StatefulWidget {
  const InboxMessages({super.key});

  @override
  State<StatefulWidget> createState() => _InboxMessagesState();
}

class _InboxMessagesState extends State<InboxMessages> {
  List<bool> l1 = [true, false, true, false];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.015, horizontal: size.width * 0.01),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0), // Added padding
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LetterStyle(
                    label: 'All',
                    size: size.width * 0.03,
                    fw: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8.0), // Added space between buttons
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0), // Added padding
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LetterStyle(
                    label: 'Unread',
                    size: size.width * 0.03,
                    fw: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.015),
            ListView.builder(
              shrinkWrap: true, // Added shrinkWrap
              physics:
                  const NeverScrollableScrollPhysics(), // Disabled inner scroll
              itemCount: l1.length, // Set item count
              itemBuilder: (context, index) {
                return InboxCard(isOnline: l1[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
