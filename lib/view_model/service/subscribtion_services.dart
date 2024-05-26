import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubscriptionService {
  Future<List<Map<String, dynamic>>> getUserSubscriptions() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("No user is signed in.");
    }

    try {
      final QuerySnapshot subscriptionSnapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('subscriptionRequests')
          .get();

      final List<Map<String, dynamic>> subscriptions = subscriptionSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return subscriptions;
    } catch (e) {
      throw Exception('Failed to fetch subscription data: $e');
    }
  }
}