import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ui_design/api_service/api_service.dart';
import 'package:ui_design/data_models/get_users.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class XYZScreen extends StatefulWidget {
  const XYZScreen({super.key});

  @override
  State<StatefulWidget> createState() => _XYZScreenState();
}

class _XYZScreenState extends State<XYZScreen> {
  bool isLoading = false;
  bool hasMoreData = true;
  List<Datum> lst1 = [];
  int currPage = 1;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    getData();
  }

  Future<void> getData() async {
    if (isLoading || !hasMoreData) return;
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://crud-vip.vercel.app/api/users?page=$currPage&limit=5&search='));
      if (response.statusCode == 200) {
        final data = GetUsers.fromJson(jsonDecode(response.body));
        setState(() {
          if (currPage == 1) {
            lst1 = data.data;
          } else {
            lst1.addAll(data.data);
          }
          if (data.data.isEmpty) {
            hasMoreData = false;
          } else {
            currPage++;
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 300 && !isLoading) {
      getData();
    }
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  ThemeMode _themeMode = ThemeMode.light;
  void _toggleTheme(bool value) {
    setState(() {
      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _themeMode == ThemeMode.dark ? Colors.black26 : Colors.white,
      appBar: AppBar(
        backgroundColor:
            _themeMode == ThemeMode.dark ? Colors.black26 : Colors.white,
        title: const Text(
          'Users List',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Switch(value: _themeMode == ThemeMode.dark, onChanged: _toggleTheme)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: lst1.isEmpty && isLoading
                ? const Center(child: CircularProgressIndicator())
                : lst1.isEmpty
                    ? const Center(child: Text('No users found.'))
                    : ListView.builder(
                        itemCount: lst1.length + (isLoading ? 1 : 0),
                        controller: controller,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          if (index == lst1.length) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          Datum user = lst1[index];
                          return Card(
                            color: _themeMode==ThemeMode.dark ? Colors.indigoAccent: Colors.white,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: Text(user.name),
                                title: Text(
                                  user.phone ?? 'No phone available',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  user.email,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                                trailing: IconButton(
                                    onPressed: () => showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            constraints: const BoxConstraints(
                                                maxHeight: 200),
                                            child: Options(
                                                id: user.id,
                                                name: user.name,
                                                location: user.location,
                                                email: user.email,
                                                phone: user.phone),
                                          );
                                        }),
                                    icon: Icon(Icons.more_vert_sharp))),
                          );
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_data');
                },
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.add, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final ApiService _api = ApiService();

class Options extends StatelessWidget {
  final String id;
  final String name;
  final String? location;
  final String email;
  final String? phone;
  const Options(
      {super.key,
      required this.id,
      required this.name,
      required this.location,
      required this.email,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildOptionCard(
                  Icons.edit_location_alt, 'Edit', Colors.black, context),
              SizedBox(height: size.height * 0.005),
              _buildOptionCard(
                  Icons.delete_outline, 'Delete', Colors.blue, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      IconData icon, String text, Color iconColor, BuildContext context) {
    return InkWell(
      onTap: () {
        switch (text) {
          case 'Delete':
            _api.deleteUser(id);
            break;
          case 'Edit':
            Navigator.pushNamed(context, '/update_data', arguments: {
              'name': name,
              'location': location,
              'email': email,
              'phone': phone,
              'id': id
            });
        }
      },
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 5),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}
