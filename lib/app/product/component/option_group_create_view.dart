import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/model/product_option_model.dart';
import 'package:gu_pos/common/component/button/basic_button_v2.dart';
import 'package:gu_pos/common/utils/toast/toast_util.dart';

import '../../../common/component/form/basic_text_form_field.dart';
import '../../../common/component/text/body_text.dart';
import '../../../common/const/colors.dart';
import '../provider/product_option_group_edit_provider.dart';

class OptionGroupCreateView extends ConsumerStatefulWidget {
  const OptionGroupCreateView({super.key});

  @override
  ConsumerState<OptionGroupCreateView> createState() => _OptionCreateViewState();
}

class _OptionCreateViewState extends ConsumerState<OptionGroupCreateView> {
  int optionCount = 1;

  List<ProductOptionModel> optionList = [
    ProductOptionModel(productOptionId: 0, productOptionNm: '', optionPrice: 0, sortOrder: 0)
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productOptionGroupEditProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 50, left: 60, right: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BodyText("옵션 추가", textSize: BodyTextSize.LARGE_HALF, fontWeight: FontWeight.w500,),
            ],
          ),
          const SizedBox(height: 40,),
          Expanded(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    BodyText("옵션 그룹", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
                                    BodyText("・", textSize: BodyTextSize.LARGE, color: COLOR_d23e41,),
                                  ],
                                ),
                                const SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BasicTextFormField(
                                        hintText: '예)온도',
                                        onChanged: (value) {
                                          ref.read(productOptionGroupEditProvider.notifier).changeValue(optionGroupNm: value);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 40,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    BodyText("옵션이름", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
                                  ],
                                ),
                                const SizedBox(height: 8,),
                                Column(
                                    children: List.generate(state.optionList.length, (index) {
                                      final option = state.optionList[index];
                                      return Padding(
                                        key: ValueKey(option.productOptionId),
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: BasicTextFormField(
                                                hintText: '예)HOT',
                                                onChanged: (value) {
                                                  ref.read(productOptionGroupEditProvider.notifier).changeOptionValue(index, productOptionNm: value);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 8,),
                                            Expanded(
                                              flex: 3,
                                              child: BasicTextFormField(
                                                hintText: '0',
                                                suffixWidget: Padding(
                                                  padding: const EdgeInsets.only(right: 16),
                                                  child: BodyText("원", textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_02,),
                                                ),
                                                onChanged: (value) {
                                                  int? intValue = int.tryParse(value);
                                                  if (intValue != null) {
                                                    ref.read(productOptionGroupEditProvider.notifier).changeOptionValue(index, optionPrice: intValue);
                                                  }

                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 8,),
                                            InkWell(
                                              onTap: () {
                                                ref.read(productOptionGroupEditProvider.notifier).removeOption(index);
                                              },
                                              child: Container(
                                                height: 48,
                                                width: 48,
                                                decoration: BoxDecoration(
                                                  color: COLOR_e6e8ea,
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                child: Icon(Icons.delete, color: COLOR_505967,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        ref.read(productOptionGroupEditProvider.notifier).addOption();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.add, color: PRIMARY_COLOR_01, size: 18,),
                                          BodyText('추가하기', textSize: BodyTextSize.REGULAR_HALF, color: PRIMARY_COLOR_01,)
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        BodyText('순서편집', textSize: BodyTextSize.REGULAR_HALF, color: TEXT_COLOR_02,),
                                        Icon(Icons.arrow_forward_ios_rounded, color: TEXT_COLOR_04, size: 14),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BodyText("이 옵션은 필수선택이에요", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
                                CupertinoSwitch(
                                  value: ref.read(productOptionGroupEditProvider).requiredAt == 'N' ? false : true,
                                  activeColor: CupertinoColors.activeBlue,
                                  onChanged: (bool value) {
                                    final requiredAt = value ? 'Y' : 'N';
                                    ref.read(productOptionGroupEditProvider.notifier).changeValue(requiredAt: requiredAt);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),

          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: BasicButtonV2(
                        text: BodyText("취소",
                          textSize: BodyTextSize.HUGE,
                          color: COLOR_505967,
                          fontWeight: FontWeight.w500,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        backgroundColor: COLOR_f3f4f6,
                      ),
                    ),
                    const SizedBox(width: 8,),
                    InkWell(
                      onTap: ref.read(productOptionGroupEditProvider.notifier).isReadyForSave()
                        ? () {
                          ref.read(productOptionGroupEditProvider.notifier).saveOptionGroup();
                          Navigator.pop(context);
                          ToastUtil.showToast(context);
                        }
                        : null,
                      child: BasicButtonV2(
                        text: BodyText("등록",
                          textSize: BodyTextSize.HUGE,
                          color: PRIMARY_COLOR_04,
                          fontWeight: FontWeight.w500,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        backgroundColor: ref.read(productOptionGroupEditProvider.notifier).isReadyForSave() ? PRIMARY_COLOR_01 : COLOR_d0e1fd,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
