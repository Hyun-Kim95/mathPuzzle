import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../domain/monetization/phase2_placeholders.dart';
import '../l10n/strings.dart';

class PurchaseService {
  PurchaseService() {
    _subscription = _iap.purchaseStream.listen(_onPurchaseUpdate);
  }

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];
  bool _available = false;

  bool get isAvailable => _available;
  List<ProductDetails> get products => _products;

  Future<void> init() async {
    _available = await _iap.isAvailable();
    if (!_available) return;
    final response = await _iap.queryProductDetails(
      Phase2Placeholders.iapSkus.toSet(),
    );
    if (response.error == null) {
      _products = response.productDetails;
    }
  }

  Future<bool> buy(ProductDetails product) async {
    if (!_available) return false;
    final param = PurchaseParam(productDetails: product);
    return _iap.buyConsumable(purchaseParam: param);
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        if (purchase.pendingCompletePurchase) {
          _iap.completePurchase(purchase);
        }
      }
    }
  }

  Future<void> showDonate(BuildContext context) async {
    if (!_available || _products.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Strings.purchaseUnavailable)),
        );
      }
      return;
    }
    if (context.mounted) {
      await Navigator.of(context).pushNamed('/settings/donate');
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
