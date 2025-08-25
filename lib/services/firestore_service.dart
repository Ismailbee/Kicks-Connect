import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../domain/models.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  // Shoes
  Future<List<Shoe>> getShoes({int limit = 50}) async {
    try {
      final q = await _db.collection('shoes').limit(limit).get();
      return q.docs.map((d) => Shoe.fromMap(d.id, d.data())).toList();
    } catch (e) {
      debugPrint('Error fetching shoes: $e');
      // Return empty list on error - in production, you might want to throw
      return [];
    }
  }

  Future<Shoe?> getShoeById(String id) async {
    try {
      final doc = await _db.collection('shoes').doc(id).get();
      if (doc.exists && doc.data() != null) {
        return Shoe.fromMap(doc.id, doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching shoe $id: $e');
      return null;
    }
  }

  Future<bool> addShoe(Shoe shoe) async {
    try {
      await _db.collection('shoes').doc(shoe.id).set(shoe.toMap());
      return true;
    } catch (e) {
      debugPrint('Error adding shoe: $e');
      return false;
    }
  }

  Future<bool> updateShoe(Shoe shoe) async {
    try {
      await _db.collection('shoes').doc(shoe.id).update(shoe.toMap());
      return true;
    } catch (e) {
      debugPrint('Error updating shoe: $e');
      return false;
    }
  }

  Future<bool> deleteShoe(String id) async {
    try {
      await _db.collection('shoes').doc(id).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting shoe: $e');
      return false;
    }
  }

  // Orders
  Future<bool> createOrder(Order order) async {
    try {
      await _db.collection('orders').doc(order.id).set(order.toMap());
      return true;
    } catch (e) {
      debugPrint('Error creating order: $e');
      return false;
    }
  }

  Stream<List<Order>> watchOrders({String? userId}) {
    try {
      Query q = _db.collection('orders');
      if (userId != null) q = q.where('userId', isEqualTo: userId);
      return q.snapshots().map((s) => s.docs
          .map((d) => Order.fromMap(d.id, d.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      debugPrint('Error watching orders: $e');
      // Return empty stream on error
      return Stream.value([]);
    }
  }

  Future<List<Order>> getOrders({String? userId, int limit = 50}) async {
    try {
      Query q = _db.collection('orders').limit(limit);
      if (userId != null) q = q.where('userId', isEqualTo: userId);
      final snapshot = await q.get();
      return snapshot.docs
          .map((d) => Order.fromMap(d.id, d.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      return [];
    }
  }

  Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      await _db.collection('orders').doc(orderId).update({'status': status});
      return true;
    } catch (e) {
      debugPrint('Error updating order status: $e');
      return false;
    }
  }

  // Users
  Future<bool> createUser(String uid, Map<String, dynamic> userData) async {
    try {
      await _db.collection('users').doc(uid).set(userData);
      return true;
    } catch (e) {
      debugPrint('Error creating user: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUser(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }

  Future<bool> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).update(data);
      return true;
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }

  // Utility method to check Firebase connection
  Future<bool> isConnected() async {
    try {
      await _db.collection('_health').doc('check').get();
      return true;
    } catch (e) {
      debugPrint('Firebase not connected: $e');
      return false;
    }
  }
}
