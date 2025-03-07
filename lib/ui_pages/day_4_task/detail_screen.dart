import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data_models/message.dart';
import '../../components/letter_style.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String imgAddress;
  final int id;

  const DetailScreen({
    super.key,
    required this.name,
    required this.imgAddress,
    required this.id,
  });

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Box<Message> messageBox;
  List<Message> l1 = [];

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    messageBox = await Hive.openBox<Message>('messages');
    getMessages();
  }

  void addMessage(String message) async {
    final newMessage = Message(
      message: message,
      timeStamp: DateTime.now(),
      id: widget.id,
    );
    await messageBox.add(newMessage);
    getMessages();
  }

  void getMessages() {
    setState(() {
      l1 = messageBox.values.where((msg) => msg.id == widget.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384955),
      appBar: AppBar(
        backgroundColor: const Color(0xFF303030),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(widget.imgAddress)),
            const SizedBox(width: 8),
            MidHeading(label: widget.name, clr: Colors.white, fw: FontWeight.w600, size: 16),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: l1.length,
                itemBuilder: (context, index) {
                  return MessageCard(
                    text: l1[index].message,
                    dateTime: l1[index].timeStamp,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 10),
              ),
            ),
            BottomMessage(addMessage: addMessage)
          ],
        ),
      ),
    );
  }
}

class BottomMessage extends StatefulWidget {
  final void Function(String) addMessage;
  const BottomMessage({super.key, required this.addMessage});

  @override
  State<BottomMessage> createState() => _BottomMessageState();
}

class _BottomMessageState extends State<BottomMessage> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: TextFormField(
            controller: messageController,
            style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              label: const MidHeading(label: 'Your Message here', clr: Colors.white),
              contentPadding: const EdgeInsets.all(10),
              fillColor: Colors.black,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            String message = messageController.text.trim();
            if (message.isNotEmpty) {
              widget.addMessage(message);
              messageController.clear();
            }
          },
          child: const CircleAvatar(
            backgroundColor: Color(0xFF006400),
            child: Icon(Icons.send_rounded, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class MessageCard extends StatelessWidget {
  final String text;
  final DateTime dateTime;
  const MessageCard({super.key, required this.text, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(7, 94, 84, 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MidHeading(label: text, clr: Colors.white, size: 13),
            Text(
              "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}