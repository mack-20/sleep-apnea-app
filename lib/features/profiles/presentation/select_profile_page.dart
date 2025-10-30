import 'package:flutter/material.dart';
import 'package:sleep_apnea_app/features/profiles/data/profile_model.dart';
import 'package:sleep_apnea_app/features/profiles/data/profile_storage_service.dart';
import 'package:sleep_apnea_app/features/home/presentation/home_page.dart';
import 'package:sleep_apnea_app/features/profiles/presentation/create_profile_page.dart';
import 'package:go_router/go_router.dart';


class SelectProfilePage extends StatefulWidget {
  const SelectProfilePage({super.key});

  @override
  State<SelectProfilePage> createState() => _SelectProfilePageState();
}

class _SelectProfilePageState extends State<SelectProfilePage> {
  List<ProfileModel> profiles = [];

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    final loadedProfiles = await ProfileStorageService.getAllProfiles();
    setState(() {
      profiles = loadedProfiles;
    });
  }

  void _openCreateProfile() {
    context.push('/create-profile');
  }

  void _selectProfile(ProfileModel profile) {
    context.go('/home', extra: profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Profile')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return GestureDetector(
            onTap: () => _selectProfile(profile),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${profile.firstname} ${profile.surname}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${profile.gestationalAge} weeks',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile.createdAt.toString(), // format later
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: _openCreateProfile,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
