class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final Map<String, String> colorVariants;
  final List<String> galleryImages;
  final List<String> tags;
  final Map<String, String> specs;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.colorVariants,
    required this.galleryImages,
    required this.tags,
    required this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      colorVariants: Map<String, String>.from(json['colorVariants'] ?? {}),
      galleryImages: List<String>.from(json['galleryImages'] ?? [json['imageUrl']]),
      tags: List<String>.from(json['tags'] ?? []),
      specs: Map<String, String>.from(json['specs'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'colorVariants': colorVariants,
      'galleryImages': galleryImages,
      'tags': tags,
      'specs': specs,
    };
  }
}
