import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/service_process_screen_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class SericeProcessScreen extends StatefulWidget {
  final String service;
  const SericeProcessScreen({super.key, required this.service});

  @override
  State<SericeProcessScreen> createState() => _SericeProcessScreenState();
}

class _SericeProcessScreenState extends State<SericeProcessScreen> {
  final controller = Get.put(ServiceProcessScreenController());

  @override
  void initState() {
    super.initState();
    controller.loadFields(widget.service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Obx(() => Column(children: [_buildscreenContent()])),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- APP BAR ----------------
  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 60,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.appbarFirstColor, AppColors.appbarsecondColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 🔹 Back Icon
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),

                // 🔹 Center Title
                Text(
                  widget.service,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildscreenContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.maxFinite,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Service Provider",
            style: TextStyle(
              color: AppColors.new_blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: AppColors.appbarFirstColor),

          // 🔹 Render Dynamic Fields
          ...controller.fields.map((f) {
            if (f.type == "text") {
              return _buildTextField(
                controller: controller.textControllers[f.label]!,
                label: f.label,
                hint: f.hint,
                maxL: f.maxLength,
              );
            } else if (f.type == "dropdown") {
              return _buildDropDownTile(
                title: f.hint,
                label: f.label,
                items: f.options!,
                selectedValue: controller.selectedValues[f.label]!,
              );
            }
            return const SizedBox();
          }).toList(),

          const SizedBox(height: 20),

          // 🔹 Submit button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.new_blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // 🔹 TODO: send formData to API
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
    required String hint,
    bool obscureText = false,
    int? maxL,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.serice_card_color_first,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLength: maxL,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            counterText: '',
            fillColor: AppColors.textfield_inside_color,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.textfield_border_color,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.serice_card_color_second,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {},
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDropDownTile({
    required String title,
    required String label,
    required List<String> items,
    required RxString selectedValue,
  }) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.serice_card_color_first,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            hint: Text(title),
            onChanged: (val) => selectedValue.value = val!,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
