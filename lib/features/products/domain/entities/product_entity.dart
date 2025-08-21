class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.imageUrl,
  });

  final String id;
  final String name;
  final double price;
  final String? description;
  final String? imageUrl;
}
