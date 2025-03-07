import 'package:flutter/material.dart';
import 'package:ui_design/components/letter_style.dart';
import 'package:ui_design/components/message_card.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.black87,
        ),
        title: LetterStyle(
          label: 'Message',
          fw: FontWeight.w700,
          size: size.width * 0.04,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(232, 232, 232, 0.3),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.center, // Distribute icons evenly
              children: [
                GestureDetector(
                  child:
                  const Icon(Icons.search_rounded, color: Colors.black87),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  child:
                  const Icon(Icons.favorite_outline, color: Colors.black87),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  child: const Icon(Icons.menu, color: Colors.black87),
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.01, vertical: size.height * 0.015),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: size.width * 0.08,
                  backgroundImage: const AssetImage('assets/svgs/logo.png'),
                ),
                SizedBox(width: size.width*0.015),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LetterStyle(label: 'Name',size: size.width*0.045),
                    LetterStyle(label: 'name@gmail.com',
                        clr: const Color.fromRGBO(60, 60, 67, 0.7), size: size.width*0.035)
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height*0.02), // Space between contact info and card
            // Use CardStyle widget here
            const MessageCard(isTrue: true), // You can set `isTrue` to true or false based on your needs
            SizedBox(height:size.height*0.02), // Space between multiple CardStyle widgets (if you add more)
            const MessageCard(isTrue: false),
            SizedBox(height:size.height*0.02),
            const MessageCard(isTrue: true) // Another CardStyle with `isTrue` set to false
          ],
        ),
      ),
    );
  }
}
