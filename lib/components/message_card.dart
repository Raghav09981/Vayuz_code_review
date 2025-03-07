import 'package:flutter/material.dart';
import 'letter_style.dart';

class MessageCard extends StatelessWidget {
  final bool isTrue;
  const MessageCard({super.key, required this.isTrue});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text('20 Dec 2024: 9:16 AM'),
        ),
        Card(
          color: const Color.fromRGBO(239, 239, 240, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
                16.0), // Added padding to avoid content touching card edges
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the start
              children: [
                const LetterStyle(
                  label: 'Lorem ipsum dolor sit amet ut labore im ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in.',
                ),
                SizedBox(height:size.height*0.015), // Added space between text and any other widget below
                if (isTrue)
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 204, 0, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: LetterStyle(
                          label: 'Avail Now',
                          size: size.width*0.04,
                          fw: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}