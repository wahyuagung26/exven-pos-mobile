import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/dependency_injection.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

final getProductsProvider = Provider<GetProducts>((ref) {
  return getIt<GetProducts>();
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final getProducts = ref.watch(getProductsProvider);
  final result = await getProducts();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (products) => products,
  );
});

final selectedProductProvider = StateProvider<Product?>((ref) => null);

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider);
  final productsAsync = ref.watch(productsProvider);

  return productsAsync.when(
    data: (products) {
      if (searchQuery.isEmpty) {
        return AsyncValue.data(products);
      }
      
      final filtered = products.where((product) {
        return product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
               product.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
               product.category.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
      
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});