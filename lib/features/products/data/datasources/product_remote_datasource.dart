import '../../../../data/datasources/remote/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> searchProducts(String query);
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<bool> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    // Mock implementation - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    return _getMockProducts();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
    
    final products = _getMockProducts();
    return products.firstWhere((p) => p.id == id);
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
    
    final products = _getMockProducts();
    return products
        .where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return product;
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return product;
  }

  @override
  Future<bool> deleteProduct(String id) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  List<ProductModel> _getMockProducts() {
    final now = DateTime.now();
    return [
      ProductModel(
        id: '1',
        name: 'Coffee Latte',
        description: 'Smooth espresso with steamed milk',
        price: 4.50,
        stock: 100,
        category: 'Beverages',
        imageUrl: 'https://example.com/latte.jpg',
        barcode: '1234567890',
        createdAt: now,
        updatedAt: now,
      ),
      ProductModel(
        id: '2',
        name: 'Croissant',
        description: 'Buttery French pastry',
        price: 3.00,
        stock: 50,
        category: 'Bakery',
        imageUrl: 'https://example.com/croissant.jpg',
        barcode: '1234567891',
        createdAt: now,
        updatedAt: now,
      ),
      ProductModel(
        id: '3',
        name: 'Sandwich',
        description: 'Fresh sandwich with various fillings',
        price: 6.50,
        stock: 30,
        category: 'Food',
        imageUrl: 'https://example.com/sandwich.jpg',
        barcode: '1234567892',
        createdAt: now,
        updatedAt: now,
      ),
      ProductModel(
        id: '4',
        name: 'Orange Juice',
        description: 'Freshly squeezed orange juice',
        price: 3.50,
        stock: 80,
        category: 'Beverages',
        imageUrl: 'https://example.com/orange-juice.jpg',
        barcode: '1234567893',
        createdAt: now,
        updatedAt: now,
      ),
      ProductModel(
        id: '5',
        name: 'Chocolate Cake',
        description: 'Rich chocolate cake slice',
        price: 5.00,
        stock: 20,
        category: 'Desserts',
        imageUrl: 'https://example.com/cake.jpg',
        barcode: '1234567894',
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}