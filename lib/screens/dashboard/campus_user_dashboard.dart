
import 'package:material_ui/material_ui.dart';

import '../../models/app_user.dart';
import '../../models/stall.dart';
import '../../services/stall_service.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class CampusUserDashboard extends StatelessWidget {
  final AppUser user;

  const CampusUserDashboard({
    super.key,
    required this.user,
  });

static final StallService _stallService = StallService();

  Future<void> logout(BuildContext context) async {
    await AuthService().signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusEats'),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // WELCOME SECTION
              Text(
                'Hello, ${user.fullName}!',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF174B35),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'What would you like to eat today?',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              // STALL SECTION
              const Text(
                'Campus Food Stalls',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // FIRESTORE STALL LIST
              StreamBuilder<List<Stall>>(
                stream: _stallService.getActiveStalls(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Unable to load food stalls.',
                      ),
                    );
                  }

                  final stalls = snapshot.data ?? [];

                  if (stalls.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          'No food stalls available yet.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: stalls.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {

                      final stall = stalls[index];

                      return Card(
                        elevation: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.all(15),

                          leading: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F2EC),
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.store,
                              color: Color(0xFF176B45),
                              size: 30,
                            ),
                          ),

                          title: Text(
                            stall.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),

                              Text(stall.description),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 9,
                                    color: stall.isOpen
                                        ? Colors.green
                                        : Colors.red,
                                  ),

                                  const SizedBox(width: 6),

                                  Text(
                                    stall.isOpen
                                        ? 'Open'
                                        : 'Closed',
                                    style: TextStyle(
                                      color: stall.isOpen
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),

                          // Product navigation will be added next.
                          onTap: stall.isOpen
                              ? () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Selected ${stall.name}',
                                      ),
                                    ),
                                  );
                                }
                              : null,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
