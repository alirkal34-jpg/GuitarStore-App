// Uygulama genelinde sepet durumunu tutmak için basit bir global liste
import 'package:mobile_application/models/product.dart';

class CartState {
  static List<Product> items = [];

  static void add(Product product) {
    items.add(product);
  }

  static void remove(Product product) {
    items.remove(product);
  }

  static double get totalAmount {
    double total = 0;
    for (var item in items) {
      total += item.price;
    }
    return total;
  }
}
