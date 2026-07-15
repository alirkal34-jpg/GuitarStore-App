import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_application/data/dummy_data.dart';
import 'package:mobile_application/models/product.dart';
import 'package:mobile_application/widgets/product_card.dart';
import 'package:mobile_application/screens/cart_screen.dart';
import 'package:mobile_application/models/cart_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  List<Product> get products {
    final List<dynamic> jsonList = jsonDecode(dummyProductsJson);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Flame arka plan — çok düşük opaklık, yazıyı/ikonu etkilemez
            Opacity(
              opacity: 0.13,
              child: Image.asset(
                'assets/Brand ICON/flame image for the top of the guitar shop word.png',
                fit: BoxFit.cover,
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const Icon(Icons.menu, color: Colors.white),
              title: const Text(
                'GUITAR SHOP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 3,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    icon: Badge(
                      label: Text(CartState.items.length.toString()),
                      isLabelVisible: CartState.items.isNotEmpty,
                      backgroundColor: Colors.redAccent,
                      child: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())).then((_) {
                        setState(() {});
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Find your perfect axe. Ready to rock?',
              style: TextStyle(color: Colors.grey, fontSize: 14, letterSpacing: 0.2),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white10),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.redAccent, size: 20),
                  hintText: 'Search guitars...',
                  hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/Brand ICON/vintage-monochrome-rock-gesture-concept_225004-1211.avif'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                ),
              ),
              child: const Center(
                child: Text(
                  'HEAVY METAL DEALS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    onReturn: () => setState(() {}),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedNavIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1),
        unselectedLabelStyle: const TextStyle(fontSize: 11, letterSpacing: 1),
        onTap: (index) => setState(() => _selectedNavIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'FAVORITES'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'PROFILE'),
        ],
      ),
    );
  }
}
