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

  Future<void> _addToCart() async {
    _productsStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.postData(
      endpoint: "api/Cart/add",
      queryParameters: {"productId": widget.product.id, "quantity": 1},
    );
    if (response.isSuccess) {
      _productsStates = DataStates.loaded;
      showMsg(response.msg);
    } else {
      _productsStates = DataStates.error;
      showMsg(response.msg);
    }
    setState(() {});
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
                        image: widget.product.imageUrl,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                        errorBuilder: (context, error, stackTrace) => const AppImage(
                          image:
                              "https://www.loyecosmetics.com/cdn/shop/files/preview_images/70a95804d95749d98ea06715e71ee555.thumbnail.0000000000.jpg?v=1769416939&width=1080",
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _productsStates == DataStates.loaded ? null : _addToCart,
                      child: Container(
                        padding: const EdgeInsetsGeometry.all(8),
                        margin: const EdgeInsetsGeometry.all(8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(8)),
                        child: Builder(
                          builder: (context) {
                            switch (_productsStates) {
                              case DataStates.uninitialized:
                                return const AppImage(image: "add_to_cart.svg", width: 24, height: 24);
                              case DataStates.loading:
                                return const CircularProgressIndicator();
                              case DataStates.loaded:
                                return const AppImage(image: "done_task.svg", width: 30, height: 30);
                              default:
                                return const AppImage(image: "add_to_cart.svg", width: 24, height: 24);
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

