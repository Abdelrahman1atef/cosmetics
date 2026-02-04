part of '../view.dart';

class _CounterWidget extends StatefulWidget {
  const _CounterWidget({required this.cartItem});

  final Items cartItem;

  @override
  State<_CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<_CounterWidget> {
  int count = 1;
  DataStates _productsStates = DataStates.uninitialized;

  Future<void> _updateItem({bool add = true}) async {
    _productsStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.putData(
      endpoint: "api/Cart/update",
      queryParameters: {"productId": widget.cartItem.productId, "quantity": count},
    );
    if (response.isSuccess) {
      final oldCart = cartNotifier.value;
      final updatedItem = oldCart.items.firstWhere((e) => e.productId == widget.cartItem.productId);
      final updatedTotal = add
          ? oldCart.totalCents + updatedItem.priceCents
          : oldCart.totalCents - updatedItem.priceCents;

      cartNotifier.value = oldCart.copyWith(totalCents: updatedTotal);
      _productsStates = DataStates.loaded;
      showMsg(response.msg);
    } else {
      _productsStates = DataStates.error;
      showMsg(response.msg);
    }
    setState(() {});
  }

  @override
  void initState() {
    count = widget.cartItem.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12),
        border: Border.all(color: Theme.of(context).hintColor, width: 2),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (count > 1) {
                count--;
                _updateItem(add: false);
              }
            },
            child: Container(
              width: 20,
              height: 40,
              margin: const EdgeInsetsGeometry.symmetric(horizontal: 15),
              child: const AppImage(image: "minus.svg", fit: BoxFit.none),
            ),
          ),
          const SizedBox(width: 10),
          _productsStates == DataStates.loading
              ? const CircularProgressIndicator()
              : Text("$count", style: Theme.of(context).textTheme.displayMedium),

          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              count++;
              _updateItem(add: true);
            },
            child: Container(
              width: 20,
              height: 40,
              margin: const EdgeInsetsGeometry.symmetric(horizontal: 15),
              child: const AppImage(image: "plus.svg", fit: BoxFit.none),
            ),
          ),
        ],
      ),
    );
  }
}
