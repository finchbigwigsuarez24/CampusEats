
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/stall.dart';

class StallService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // Retrieve all active stalls
  Stream<List<Stall>> getActiveStalls() {
    return _firestore
        .collection('stalls')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Stall.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  // Retrieve one stall
  Future<Stall?> getStallById(String stallId) async {
    final document = await _firestore
        .collection('stalls')
        .doc(stallId)
        .get();

    if (!document.exists) {
      return null;
    }

    return Stall.fromMap(
      document.id,
      document.data()!,
    );
  }
}
