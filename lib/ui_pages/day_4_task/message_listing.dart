import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ui_design/components/letter_style.dart';
import 'package:ui_design/ui_pages/day_4_task/detail_screen.dart';
import '../../data_models/message.dart';
import '../../data_models/user_mock_data.dart';

class MessageListing extends StatefulWidget {
  const MessageListing({super.key});

  @override
  State<MessageListing> createState() => _MessageListingState();
}

class _MessageListingState extends State<MessageListing> {
  late Box<Message> messageBox;

  @override
  void initState() {
    super.initState();
    initHive();
  }

  Future<void> initHive() async {
    messageBox = await Hive.openBox<Message>('messages');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF303030), // Dark gray
        title: const BigHeading(
          label: 'Messages',
          fw: FontWeight.w600,
          size: 18,
          clr: Color(0xFFFFFFFF), // White color for text
        ),
      ),
      backgroundColor: const Color(0xFF303030),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: messageBox.listenable(),
          builder: (context, Box<Message> box, index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.01,
                    vertical: size.height * 0.015),
                child: SizedBox(
                  height: 500,
                  child: ListView.separated(
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      final person = people[index];

                      // Get the messages for each person from the Hive box
                      List<Message> userMessages = box.values
                          .where((message) => message.id == person.id)
                          .toList();

                      // Get the latest message and time for each person
                      String latestMessage = userMessages.isNotEmpty
                          ? userMessages.last.message
                          : "";
                      String latestTime = userMessages.isNotEmpty
                          ? "${userMessages.last.timeStamp.toLocal().hour}:${userMessages.last.timeStamp.toLocal().minute}"
                          : "";

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                id: person.id,
                                name: person.name,
                                imgAddress: person.imageAsset,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MidHeading(
                                label: person.name,
                                clr: Colors.white,
                                fw: FontWeight.bold,
                                size: 16,
                              ),
                              MidHeading(
                                label: latestTime, // Show latest time here
                                clr: Colors.white,
                                size: 13,
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF497300),
                            radius: 25,
                            backgroundImage: AssetImage(person.imageAsset),
                          ),
                          subtitle: Row(
                            children: [
                              latestMessage.isEmpty
                                  ? const Text("")
                                  : const Icon(Icons.check, color: Colors.blue),
                              Expanded(
                                child: MidHeading(
                                  label:
                                      latestMessage, // Show latest message here
                                  fs: FontStyle.italic,
                                  clr: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Color(0x4D000000));
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
