
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class UserService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<AppUser> getUserProfile(String uid) async {
    final document = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    if (!document.exists) {
      throw Exception(
        'User profile not found. Contact administrator.',
      );
    }

    final user = AppUser.fromMap(
      document.id,
      document.data()!,
    );

    if (!user.isActive) {
      throw Exception('Your account is inactive.');
    }

    if (![
      'campus_user',
      'stall_staff',
      'admin',
    ].contains(user.role)) {
      throw Exception('Invalid account role.');
    }

    return user;
  }
}
