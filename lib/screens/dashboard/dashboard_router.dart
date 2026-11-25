
import 'package:material_ui/material_ui.dart';

import '../../models/app_user.dart';
import 'campus_user_dashboard.dart';
import 'stall_staff_dashboard.dart';
import 'admin_dashboard.dart';

class DashboardRouter extends StatelessWidget {
  final AppUser user;

  const DashboardRouter({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    switch (user.role) {
      case 'campus_user':
        return CampusUserDashboard(user: user);

      case 'stall_staff':
        return StallStaffDashboard(user: user);

      case 'admin':
        return AdminDashboard(user: user);

      default:
        return const Scaffold(
          body: Center(
            child: Text('Unauthorized account role.'),
          ),
        );
    }
  }
}
