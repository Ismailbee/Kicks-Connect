import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/models.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  // Shoes
  Future<List<Shoe>> getShoes({int limit = 50}) async {
    final q = await _db.collection('shoes').limit(limit).get();
    return q.docs.map((d) => Shoe.fromMap(d.id, d.data())).toList();
  }

  Future<void> addShoe(Shoe shoe) => _db.collection('shoes').doc(shoe.id).set(shoe.toMap());

  Future<void> updateShoe(Shoe shoe) => _db.collection('shoes').doc(shoe.id).update(shoe.toMap());

  Future<void> deleteShoe(String id) => _db.collection('shoes').doc(id).delete();

  // Orders
  Future<void> createOrder(Order order) => _db.collection('orders').doc(order.id).set(order.toMap());

  Stream<List<Order>> watchOrders({String? userId}) {
    Query q = _db.collection('orders');
    if (userId != null) q = q.where('userId', isEqualTo: userId);
    return q.snapshots().map((s) => s.docs.map((d) => Order.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());
  }
}
