import 'package:flutter/material.dart';
import 'package:mobile_application/models/product.dart';
import 'package:mobile_application/models/cart_state.dart';
import 'package:mobile_application/screens/cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String selectedColor;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.product.colorVariants.isNotEmpty) {
      selectedColor = widget.product.colorVariants.keys.first;
    } else {
      selectedColor = 'Standard';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> allImages = widget.product.galleryImages;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Axe Details',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Badge(
                label: Text(CartState.items.length.toString()),
                isLabelVisible: CartState.items.isNotEmpty,
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.shopping_bag_outlined),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Kaydırılabilir Galeri ─────────────────────────────────
            Stack(
              children: [
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: allImages.length,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      return Container(
                        color: const Color(0xFF0D0D0D),
                        child: Image.asset(
                          allImages[index],
                          fit: BoxFit.contain,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.music_note, size: 80, color: Colors.grey)),
                        ),
                      );
                    },
                  ),
                ),
                // IN STOCK badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade800,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'IN STOCK',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
                // Nokta göstergesi
                if (allImages.length > 1)
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(allImages.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentPage == index ? 22 : 8,
                          height: 4,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? Colors.redAccent : Colors.white38,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Renk Seçimi ───────────────────────────────────────
                  if (widget.product.colorVariants.length > 1) ...[
                    const Text(
                      'COLOR FINISHES',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 52,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.colorVariants.length,
                        itemBuilder: (context, index) {
                          String colorName = widget.product.colorVariants.keys.elementAt(index);
                          String imagePath = widget.product.colorVariants[colorName]!;
                          bool isSelected = selectedColor == colorName;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = colorName;
                                int pageIndex = allImages.indexOf(imagePath);
                                if (pageIndex != -1) {
                                  _pageController.animateToPage(
                                    pageIndex,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              });
                            },
                            child: Container(
                              width: 52,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? Colors.redAccent : Colors.white24,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(imagePath, fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ── Ürün Adı (Büyük, Bold) ────────────────────────────
                  Text(
                    widget.product.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Finish
                  Text(
                    'FINISH: $selectedColor'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Tag Chips ─────────────────────────────────────────
                  if (widget.product.tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: widget.product.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: const TextStyle(fontSize: 11, color: Colors.white70, letterSpacing: 1),
                          ),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 20),

                  // ── Açıklama ──────────────────────────────────────────
                  const Text(
                    'DESCRIPTION',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(color: Colors.white70, height: 1.6, fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  // ── Spec Grid (2x2) ───────────────────────────────────
                  if (widget.product.specs.isNotEmpty) ...[
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3.2,
                      children: widget.product.specs.entries.map((entry) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                entry.value,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ADD TO CART butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.shopping_cart_outlined, size: 20),
                  label: const Text(
                    'ADD TO CART',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 2),
                  ),
                  onPressed: () {
                    setState(() {
                      CartState.add(widget.product);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.product.name} sepete eklendi! 🤘'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.black87,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Ana Sayfaya Dön
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white54,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.home_outlined, size: 18),
                  label: const Text(
                    'BACK TO HOME',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                  onPressed: () {
                    // Tüm sayfaları kapatıp ana sayfaya döner
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
