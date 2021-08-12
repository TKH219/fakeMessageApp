import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseHandler {

  static final InAppPurchaseHandler _instance = InAppPurchaseHandler._internal();
  InAppPurchaseHandler._internal();
  factory InAppPurchaseHandler() {
    return _instance;
  }

  List<ProductDetails>? products;

  void fetchAllProduct() async {
    const Set<String> _kIds = <String>{'com.hatk.fakeMessageScreen'};
    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      print('Fetch error');
    }

    products = response.productDetails;
    print(products.toString());
  }

  void makingPurchase() {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: products!.first);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void restorePurchase() async {
    try {
      await InAppPurchase.instance.restorePurchases();
    } catch(error) {
      print(error);
    }
  }
}