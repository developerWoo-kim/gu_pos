import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_product_model.dart';
import 'package:gu_pos/app/product/component/product_category_edit_view.dart';
import 'package:gu_pos/app/product/model/product_model.dart';
import 'package:gu_pos/common/utils/dialog/dialog_util.dart';
import '../../../common/component/text/body_text.dart';
import '../../../common/const/colors.dart';
import '../../order/provider/order_provider.dart';

class ProductGridView extends ConsumerStatefulWidget {
  final List<ProductModel> productList;

  const ProductGridView({
    required this.productList,
    super.key
  });

  @override
  ConsumerState<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends ConsumerState<ProductGridView> {
  int currentPage = 0;
  final int itemsPerPage = 24;
  final int columns = 6;
  final int rows = 4;

  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.productList.length / itemsPerPage).ceil();

    // 현재 페이지에 보여줄 데이터 추출
    final start = currentPage * itemsPerPage;
    final end = (start + itemsPerPage) > widget.productList.length
        ? widget.productList.length
        : (start + itemsPerPage);
    final pageItems = widget.productList.sublist(start, end);

    // 아이템이 24개보다 부족하면 빈칸 채우기
    final paddedItems = [
      ...pageItems,
      ...List.generate(itemsPerPage - pageItems.length, (index) => null),
    ];

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / columns;
              final itemHeight = constraints.maxHeight / rows;

              return GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: columns,
                childAspectRatio: itemWidth / itemHeight,
                children: paddedItems.map((product) {
                  if (product == null) {
                    return Container(); // 빈칸
                  }
                  // return Container(
                  //   margin: const EdgeInsets.all(4),
                  //   color: Colors.blue[100],
                  //   child: Center(child: Text('${item.productNm}')),
                  // );

                  return InkWell(
                    onTap: () {
                      ref.read(orderProvider.notifier).addItem(
                          OrderProductModel(
                              productId: product.productId,
                              productNm: product.productNm,
                              productPrice: product.productPrice,
                              orderProductPrice: product.productPrice,
                              quantity: 1,
                          )
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: BodyText('${product.productNm}', textSize: BodyTextSize.REGULAR,  color: PRIMARY_COLOR_04,))
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                BodyText('${product.productPrice}', textSize: BodyTextSize.SMALL, color: PRIMARY_COLOR_04,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.edit_note, color: TEXT_COLOR_01, size: 24,),
                        SizedBox(width: 2,),
                        BodyText('편집모드', textSize: BodyTextSize.SMALL_HALF, fontWeight: FontWeight.w300, color: PRIMARY_COLOR_03,)
                      ],
                    ),
                  ),
                  SizedBox(width: 18,),
                  InkWell(
                    onTap: () {
                      DialogUtil.basicLayout(context,
                          content: const ProductCategoryEditView()
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add_circle, color: TEXT_COLOR_01, size: 20,),
                        SizedBox(width: 2,),
                        BodyText('상품추가', textSize: BodyTextSize.SMALL_HALF, fontWeight: FontWeight.w300, color: PRIMARY_COLOR_03,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    iconSize: 32,
                    onPressed: currentPage > 0
                        ? () {
                      setState(() {
                        currentPage--;
                      });
                    }
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: BodyText('${currentPage + 1} / $totalPages', textSize: BodyTextSize.SMALL_HALF),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    iconSize: 32,
                    onPressed: currentPage < totalPages - 1
                        ? () {
                      setState(() {
                        currentPage++;
                      });
                    }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
