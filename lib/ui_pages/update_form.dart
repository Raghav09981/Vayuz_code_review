import 'package:flutter/material.dart';
import 'package:ui_design/api_service/api_service.dart';

class UpdateFormScreen extends StatefulWidget {
  const UpdateFormScreen({super.key});

  @override
  State<UpdateFormScreen> createState() => _UpdateFormScreenState();
}

class _UpdateFormScreenState extends State<UpdateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  late String name;
  late String? location;
  late String email;
  late String? phone;
  late String id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;
    if (args != null) {
      name = args['name'] ?? 'No name available';
      location = args['location'] ?? 'No location available';
      email = args['email'] ?? 'No email available';
      phone = args['phone'] ?? 'No phone available';
      id = args['id'] ?? 'No ID available';
    } else {
      name = 'No name available';
      location = 'No location available';
      email = 'No email available';
      phone = 'No phone available';
      id = 'No ID available';
    }
  }

  Future<void> submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _apiService.updateUser(
            id, name, email, phone ?? "No number available", location ?? "User entered no location");
        if (response != null) {
          print(response);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Updated successfully')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to update. Please try again.')),
          );
        }
      } catch (e) {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update the Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: location,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
