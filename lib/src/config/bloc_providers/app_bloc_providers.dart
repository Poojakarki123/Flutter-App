import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/auth_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/category_products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/products_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_account_screen_data/fetch_account_screen_data_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/fetch_orders/fetch_orders_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/keep_shopping_for/cubit/keep_shopping_for_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/product_rating/product_rating_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/account/wish_list/wish_list_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_offers/four-images-offer/admin_four_image_offer_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_offers/single_image_carousel_cubit/single_image_carousel_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/add_product_images/admin_add_products_images_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/select_category_cubit/admin_add_select_category_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_add_products/sell_product_cubit/admin_sell_product_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_bottom_bar_cubit/admin_bottom_bar_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_change_order_status/admin_change_order_status_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_fetch_category_products/admin_fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_fetch_orders/admin_fetch_orders_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/admin/admin_get_analytics/admin_get_analytics_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/auth_bloc/radio_bloc/radio_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit1/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit2/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/cart/cart_offers_cubit3/cart_offers_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/category_products/fetch_category_products_bloc/fetch_category_products_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/home_blocs/carousel_bloc/carousel_image_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/home_blocs/deal_of_the_day/deal_of_the_day_cubit.dart';
// import 'package:flutter_amazon_clone_bloc/src/logic/blocs/order/order_cubit/order_cubit.dart';
// import 'package:flutter_amazon_clone_bloc/src/logic/blocs/order/place_order_buy_now/place_order_buy_now_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/page_redirection_cubit/page_redirection_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/product_details/averageRating/average_rating_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/product_details/user_rating/user_rating_cubit.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/search/bloc/search_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Provides all BLoC providers organized by feature
class AppBlocProviders {
  // Core providers that are needed app-wide
  static List<BlocProvider> get coreProviders => [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => RadioBloc(),
        ),
        BlocProvider(
          create: (context) => UserCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => PageRedirectionCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => BottomBarBloc(),
        ),
      ];

  // Home screen related providers
  static List<BlocProvider> get homeProviders => [
        BlocProvider(
          create: (context) => CarouselImageBloc(),
        ),
        BlocProvider(
          create: (context) => DealOfTheDayCubit(ProductsRepository()),
        ),
      ];

  // Account feature related providers
  static List<BlocProvider> get accountProviders => [
        BlocProvider(
          create: (context) => FetchAccountScreenDataCubit(UserRepository()),
        ),
        BlocProvider(
          create: (context) => FetchOrdersCubit(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => ProductRatingBloc(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => KeepShoppingForCubit(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => WishListCubit(
              accountRepository: AccountRepository(),
              userRepository: UserRepository()),
        ),
      ];

  // Product related providers
  static List<BlocProvider> get productProviders => [
        BlocProvider(
          create: (context) =>
              FetchCategoryProductsBloc(CategoryProductsRepository()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(ProductsRepository()),
        ),
        BlocProvider(
          create: (context) => UserRatingCubit(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => AverageRatingCubit(AccountRepository()),
        ),
      ];

  // Cart related providers
  static List<BlocProvider> get cartProviders => [
        BlocProvider(
          create: (context) => CartBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => CartOffersCubit1(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => CartOffersCubit2(AccountRepository()),
        ),
        BlocProvider(
          create: (context) => CartOffersCubit3(AccountRepository()),
        ),
      ];

  // Order related providers
  // static List<BlocProvider> get orderProviders => [
  //       BlocProvider(
  //         create: (context) => OrderCubit(UserRepository()),
  //       ),
  //       BlocProvider(
  //         create: (context) => PlaceOrderBuyNowCubit(UserRepository()),
  //       ),
  //     ];

  // Admin related providers
  static List<BlocProvider> get adminProviders => [
        BlocProvider(create: (context) => AdminBottomBarCubit()),
        BlocProvider(
            create: (context) =>
                AdminFetchCategoryProductsBloc(AdminRepository())),
        BlocProvider(
            create: (context) => AdminFetchOrdersCubit(AdminRepository())),
        BlocProvider(
            create: (context) =>
                AdminChangeOrderStatusCubit(AdminRepository())),
        BlocProvider(
            create: (context) => AdminGetAnalyticsCubit(AdminRepository())),
        BlocProvider(
            create: (context) => AdminAddProductsImagesBloc(AdminRepository())),
        BlocProvider(create: (context) => AdminAddSelectCategoryCubit()),
        BlocProvider(create: (context) => SingleImageCubit()),
        BlocProvider(
            create: (context) => AdminSellProductCubit(AdminRepository())),
        BlocProvider(
            create: (context) => AdminFourImageOfferCubit(AdminRepository())),
      ];

  // Get all providers to use in the main app
  static List<BlocProvider> get allProviders => [
        ...coreProviders,
        ...homeProviders,
        ...accountProviders,
        ...productProviders,
        ...cartProviders,
        // ...orderProviders,
        ...adminProviders,
      ];
}
