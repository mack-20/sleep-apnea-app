import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleep_apnea_app/features/profiles/data/profile_model.dart';
import 'package:sleep_apnea_app/features/profiles/data/profile_storage_service.dart';
import 'package:go_router/go_router.dart';


class CreateProfilePage extends ConsumerStatefulWidget {
  const CreateProfilePage({super.key});

  @override
  ConsumerState<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends ConsumerState<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _gestationalAgeController = TextEditingController();

  @override
  void dispose() {
    _firstnameController.dispose();
    _surnameController.dispose();
    _gestationalAgeController.dispose();
    super.dispose();
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      final profile = ProfileModel(
        firstname: _firstnameController.text.trim(),
        surname: _surnameController.text.trim(),
        gestationalAge: int.parse(_gestationalAgeController.text.trim())
      );

      await ProfileStorageService.saveProfile(profile);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Created Successfully")),
      );

      // Navigate to home after saving
      if (mounted){
        context.go('/home', extra: profile);
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: 'Value',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Create New Profile",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text("First Name"),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _firstnameController,
                    decoration: _inputDecoration("Value"),
                    validator: (value) => value == null || value.isEmpty ? 'Enter first name' : null,
                  ),
                  const SizedBox(height: 24),
                  const Text("Surname"),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _surnameController,
                    decoration: _inputDecoration("Value"),
                    validator: (value) => value == null || value.isEmpty ? 'Enter surname' : null,
                  ),
                  const SizedBox(height: 24),
                  const Text("Gestational Age (weeks)"),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _gestationalAgeController,
                    decoration: _inputDecoration("Value"),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty ? 'Enter gestational age' : null,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _submitForm,
                        child: const Text("Submit"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
