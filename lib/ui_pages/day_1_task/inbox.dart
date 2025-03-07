import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_design/ui_pages/day_1_task/inbox_messages.dart';
import 'package:ui_design/ui_pages/day_1_task/inbox_notification.dart';
import 'package:ui_design/components/letter_style.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<StatefulWidget> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            label: 'Inbox', fw: FontWeight.w700, size: size.width * 0.04),
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
        bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: GoogleFonts.encodeSans(fontWeight: FontWeight.w700),
            controller: _tabController,
            tabs: const [
              Tab(text: 'Notifications'),
              Tab(text: 'Messages'),
            ],
            indicatorColor: Colors.pinkAccent,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey),
      ),
      // The Expanded widget is not necessary here for TabBarView
      body: TabBarView(
        controller: _tabController,
        children: [InboxNotification(), InboxMessages()],
      ),
    );
  }
}
