import 'package:flutter/material.dart';
import 'letter_style.dart';
import '../ui_pages/message_page.dart';


class InboxCard extends StatelessWidget {
  final bool isOnline;
  const InboxCard({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagePage()));
      },
      child: Card(
        color: const Color.fromRGBO(239, 239, 240, 0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/svgs/logo.png'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const LetterStyle(
                                label: 'Service available in your state',
                                clr: Colors.black87,
                                size: 20),
                            if (isOnline)
                              Container(
                                width: 12,  // Adjusted size of the dot
                                height: 12,  // Adjusted size of the dot
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 122, 255, 1),  // Set opacity to 1 (fully visible)
                                  shape: BoxShape.circle,
                                ),
                              )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.timelapse),
                            SizedBox(width: 5),
                            Text('5 hr ago'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const LetterStyle(
                  label:
                  'Lorem ipsum dolor sit amet ut labore im ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in'),
            ],
          ),
        ),
      ),
    );
  }
}
