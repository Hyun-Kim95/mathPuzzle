import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../core/app_controller.dart';
import '../../core/app_scope.dart';
import '../../l10n/strings.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final products = app.purchases.products;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(Strings.donateTitle),
      ),
      body: products.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  Strings.purchaseUnavailable,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final p in products)
                  Card(
                    child: ListTile(
                      title: Text(p.title),
                      subtitle: Text(p.description),
                      trailing: Text(p.price),
                      onTap: () => _buy(context, app, p),
                    ),
                  ),
              ],
            ),
    );
  }

  Future<void> _buy(
    BuildContext context,
    AppController app,
    ProductDetails product,
  ) async {
    final started = await app.purchases.buy(product);
    if (!context.mounted) return;
    if (started) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Strings.purchaseThanks)),
      );
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Strings.purchaseFailed)),
      );
    }
  }
}
