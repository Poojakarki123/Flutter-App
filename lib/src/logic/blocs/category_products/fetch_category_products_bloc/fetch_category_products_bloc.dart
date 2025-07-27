import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';

part 'fetch_category_products_event.dart';
part 'fetch_category_products_state.dart';

class FetchCategoryProductsBloc
    extends Bloc<FetchCategoryProductsEvent, FetchCategoryProductsState> {
  final CategoryProductsRepository categoryProductRepository;
  final AccountRepository accountRepository = AccountRepository();
  FetchCategoryProductsBloc(this.categoryProductRepository)
      : super(FetchCategoryProductsLoadingS()) {
    on<FetchCategoryProductsEvent>(_onFetchCategoryProductsHandler);
    on<CategoryPressedEvent>(_onFetchCategoryProductsHandler);
  }

  void _onFetchCategoryProductsHandler(event, emit) async {
    try {
      List<Product> productList;
      List<double> averageRatingList = [];
      emit(FetchCategoryProductsLoadingS());

      productList =
          await categoryProductRepository.fetchCategoryProducts(event.category);
      productList.shuffle();

// Fetch ratings in parallel for better performance
      List<double> ratings = await Future.wait(
        productList
            .map((product) => accountRepository.getAverageRating(product.id!)),
      );

// Pair each product with its rating
      List<MapEntry<Product, double>> pairedList = List.generate(
        productList.length,
        (index) => MapEntry(productList[index], ratings[index]),
      );

// Sort by rating in descending order
      pairedList.sort((a, b) => b.value.compareTo(a.value));

// Unpack sorted products and ratings
      productList = pairedList.map((e) => e.key).toList();
      averageRatingList = pairedList.map((e) => e.value).toList();

      emit(FetchCategoryProductsSuccessS(
        productList: productList,
        averageRatingList: averageRatingList,
      ));

      // List<Product> productList;
      // List<double> averageRatingList = [];
      // double rating;
      // emit(FetchCategoryProductsLoadingS());

      // productList =
      //     await categoryProductRepository.fetchCategoryProducts(event.category);
      // productList.shuffle();

      // for (int i = 0; i < productList.length; i++) {
      //   rating = await accountRepository.getAverageRating(productList[i].id!);
      //   averageRatingList.add(rating);
      // }

      // emit(FetchCategoryProductsSuccessS(
      //     productList: productList, averageRatingList: averageRatingList));
    } catch (e) {
      emit(FetchCategoryProductsErrorS(errorString: e.toString()));
    }
  }
}
