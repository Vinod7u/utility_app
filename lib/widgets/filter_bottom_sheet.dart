import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/Constants/screen_size.dart';

import '../controller/userscreenscontrollers/user_trabsection_controller.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final controller = Get.find<UserTransactionController>();
  bool isChecked = false;
  List text = ["Services","Amount","Status","Date"];
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Container(
      height: ScreenSize.height * .8,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filter",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 12,
                    child: Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: ScreenSize.height * 0.4,
                  decoration: BoxDecoration(
                      color: AppColors.bottomSheetColor.withOpacity(.2)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: text.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final isSelected =
                            controller.isFilterCategorySelected.value &&
                                index == controller.selectedFilterIndex.value;

                        return Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              controller.selectedFilterIndex.value = index;
                              controller.isFilterCategorySelected.value = true;
                            },
                            child: Text(
                              text[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  )

                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text("Successful Pending"),
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          isChecked = val ?? false;
                        });
                      },
                      controlAffinity:
                      ListTileControlAffinity.leading, // checkbox on left
                    ),
                    CheckboxListTile(
                      title: const Text("Pending"),
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          isChecked = val ?? false;
                        });
                      },
                      controlAffinity:
                      ListTileControlAffinity.leading, // checkbox on left
                    ),
                    CheckboxListTile(
                      title: const Text("Successful"),
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          isChecked = val ?? false;
                        });
                      },
                      controlAffinity:
                      ListTileControlAffinity.leading, // checkbox on left
                    ),
                    CheckboxListTile(
                      title: const Text("Pending"),
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          isChecked = val ?? false;
                        });
                      },
                      controlAffinity:
                      ListTileControlAffinity.leading, // checkbox on left
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),

          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                    child: Text('Clear All', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal,color: Colors.grey),),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.bottomSheetColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                    child: Text('Apply', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal,color: Colors.white),),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
