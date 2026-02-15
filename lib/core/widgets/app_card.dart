part of '../../../views/home/pages/home.dart';
class _LoadingProductWidget extends StatelessWidget {
  const _LoadingProductWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadiusGeometry.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                // height: 150,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Title placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
          ),

          const SizedBox(height: 8),

          // Price placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 14,
              width: 80,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppCard extends StatefulWidget {
  const _AppCard({required this.product});

  final _ProductModel product;

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  DataStates _productsStates = DataStates.uninitialized;
  bool isAdded = false;
  @override
  void initState() {
    isAdded = addedProducts.contains(widget.product.id);
    super.initState();
  }
  Future<void> _addToCart() async {
    _productsStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.postData(
      endpoint: "api/Cart/add",
      queryParameters: {"productId": widget.product.id, "quantity": 1},
    );
    setState(() {
      _productsStates =
      response.isSuccess ? DataStates.loaded : DataStates.error;
    });

    showMsg(response.msg);
    getCartReq();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {},
      child: Container(
        padding: const EdgeInsetsGeometry.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadiusGeometry.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Center(
                      child: AppImage(
                        image: imageList[Random().nextInt(imageList.length)],
                        // image: widget.product.imageUrl,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                        errorBuilder: (context, error, stackTrace) => AppImage(
                          fit: BoxFit.cover,
                          height: 200,
                          width: 200,
                          image:imageList[Random().nextInt(imageList.length)],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: isAdded||_productsStates == DataStates.loading ? null : _addToCart,
                      child: Container(
                        padding: const EdgeInsetsGeometry.all(8),
                        margin: const EdgeInsetsGeometry.all(8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(8)),
                        child: Builder(
                          builder: (context) {
                            if (isAdded) {
                              return const AppImage(
                              image: "check_out.svg",
                              width: 24,
                              height: 24,
                            );
                            }
                            switch (_productsStates) {
                              case DataStates.loading:
                                return const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                );

                              case DataStates.loaded:
                                return const AppImage(
                                  image: "check_out.svg",
                                  width: 24,
                                  height: 24,
                                );

                              default:
                                return const AppImage(
                                  image: "add_to_cart.svg",
                                  width: 24,
                                  height: 24,
                                );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.product.name, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 10),
            Text(
              "\$${widget.product.price}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontVariations: <FontVariation>[const FontVariation('wght', 700)],
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final imageList = [
  "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1571781926291-c477ebfd024b?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=1000&auto=format&fit=crop",
];