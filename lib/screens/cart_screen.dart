import 'package:flutter/material.dart';
import 'package:mobile_application/models/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final int itemCount = CartState.items.length;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'YOUR CART',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          // ── Checkout image — Sabit arka plan ──────────────────────────
          Positioned.fill(
            child: Opacity(
              opacity: 0.35, // Her zaman aynı opaklıkta ve boyutta kalır
              child: Image.asset(
                'assets/checkout-image/artworks-000090742583-gjocdn-t500x500.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── Ürün listesi veya boş mesaj ───────────────────────────
          itemCount == 0
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 80),
                      Text(
                        'YOUR CART IS EMPTY',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Grab an axe and start shredding!',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final item = CartState.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xDD1E1E1E), // hafif şeffaf kutular
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Image.asset(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) =>
                                    const Icon(Icons.image, color: Colors.grey),
                              ),
                            ),
                          ),
                          title: Text(
                            item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              '\$${item.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.redAccent, size: 22),
                            onPressed: () {
                              setState(() {
                                CartState.remove(item);
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
      bottomNavigationBar: itemCount == 0
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  border: Border(top: BorderSide(color: Colors.white10)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL:',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              letterSpacing: 2),
                        ),
                        Text(
                          '\$${CartState.totalAmount.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed! Keep rocking! 🤘'),
                              backgroundColor: Colors.black87,
                            ),
                          );
                          setState(() {
                            CartState.items.clear();
                          });
                        },
                        child: const Text(
                          'PROCEED TO CHECKOUT',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
