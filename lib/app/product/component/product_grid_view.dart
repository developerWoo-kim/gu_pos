import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_product_model.dart';
import 'package:gu_pos/app/product/model/product_model.dart';
import 'package:gu_pos/common/component/button/basic_button.dart';

import '../../../common/component/form/basic_text_form_field.dart';
import '../../../common/component/text/body_text.dart';
import '../../../common/const/colors.dart';
import '../../order/model/order_item_model.dart';
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
                    onTap: () {

                    },
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
                      showDialog<String>(
                          context: context,
                          // barrierColor: Colors.cyan.withOpacity(0.4),
                          barrierDismissible: true,
                          builder: (context) {
                            return Dialog(
                              // /// 배경 컬러
                              // backgroundColor: Colors.grey.shade100,
                              // /// 그림자 컬러
                              // shadowColor: Colors.blue,
                              /// 다이얼로그의 모양 설정
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              /// z축 높이, elevation의 값이 높을 수록 그림자가 아래 위치하게 됩니다.
                              // elevation: 10,
                              // /// 다이얼로그의 위치 설정, 기본값은 center
                              // alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: 750,
                                  height: 750,
                                  decoration: BoxDecoration(
                                    color: PRIMARY_COLOR_04,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 45, bottom: 50, left: 60, right: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BodyText("카테고리 관리", textSize: BodyTextSize.LARGE_HALF, fontWeight: FontWeight.w500,),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        BodyText("삭제", textSize: BodyTextSize.MEDIUM,),
                                                        BodyText("순서편집", textSize: BodyTextSize.MEDIUM,),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 40,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: BasicTextFormField(
                                                      hintText: '새로운 카테고리 이름',
                                                    ),
                                                  ),
                                                  SizedBox(width: 16,),
                                                  Expanded(
                                                      flex: 2,
                                                      child: BasicButton('저장', backgroundColor: COLOR_eaf3fe, textColor: PRIMARY_COLOR_01)
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 16,),
                                              Container(
                                                child: ListView(
                                                  children: _buildListWithDividers(
                                                      paddedItems.map((products) {
                                                        return Row(
                                                          children: [
                                                            Expanded(child: BodyText('${products?.productNm}', textSize: BodyTextSize.MEDIUM))
                                                          ],
                                                        );
                                                      }).toList()
                                                  )
                                                )
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25, bottom: 30, right: 26),
                                        child: SizedBox(
                                          width: 50,
                                          child: Column(
                                            children: [
                                              Icon(Icons.close_rounded, color: TEXT_COLOR_01, size: 42,)
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
                          }
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

  List<Widget> _buildListWithDividers(List<Widget> items) {
    List<Widget> children = [];

    // 첫 번째 Divider
    children.add(Row(
      children: [
        Expanded(child: Divider(color: PRIMARY_COLOR_02)),
      ],
    ));

    for (var item in items) {
      // 아이템
      children.add(item);

      // 각 아이템 아래 Divider
      children.add(Row(
        children: [
          Expanded(child: Divider(color: PRIMARY_COLOR_02)),
        ],
      ));
    }

    return children;
  }
}
