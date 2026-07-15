import 'package:flutter/material.dart';
import 'package:mobile_application/models/product.dart';
import 'package:mobile_application/screens/detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onReturn;

  const ProductCard({super.key, required this.product, required this.onReturn});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(product: product)),
        ).then((_) => onReturn());
      },
      child: Card(
        color: const Color(0xFF1E1E1E),
        shadowColor: Colors.black,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Colors.white10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resim - tam doldurur, boşluk kalmaz
            Expanded(
              child: ClipRRect(
                child: Container(
                  color: const Color(0xFF0D0D0D),
                  width: double.infinity,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.music_note, color: Colors.grey, size: 50)),
                  ),
                ),
              ),
            ),
            // İsim ve Fiyat
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
