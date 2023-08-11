import 'package:cliff/models/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartDataProvider {
  Stream<List<CartItem>> getCartDataStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((userSnapshot) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> cartData = userData['cart'] != null
          ? Map<String, dynamic>.from(userData['cart'])
          : {};

      List<CartItem> cartItems = [];
      cartData.forEach((productId, productData) {
        cartItems.add(CartItem(
          productId: productId,
          name: productData['name'],
          quantity: productData['quantity'],
          size: productData['size'],
          price: productData['price'],
          photoUrl: productData['photoUrl'],
        ));
      });

      return cartItems;
    });
  }
}
