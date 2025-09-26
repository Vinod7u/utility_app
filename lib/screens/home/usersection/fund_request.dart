import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Constants/app_colors.dart';

class FundRequestView extends StatefulWidget {
  const FundRequestView({super.key});

  @override
  State<FundRequestView> createState() => _FundRequestViewState();
}

class _FundRequestViewState extends State<FundRequestView> {
  final _formKey = GlobalKey<FormState>();
  final _transferModeController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _regardingController = TextEditingController();
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //                         image: DecorationImage(image: Image.asset('assets')),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 6,
                              color: Colors.grey.withOpacity(.18),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //SizedBox(height: 10,),
                            Center(child: Text('Create new Payment Request',style: TextStyle(fontWeight: FontWeight.w600,color: AppColors.textColor,fontSize: 18),)),
                            Divider(),
                            SizedBox(height: 10,),
                            _buildTextField(controller: _transferModeController, hint: '',label: 'Transfer Mode'),
                            _buildTextField(controller: _emailController, hint: '',label: 'Amount'),
                            _buildTextField(controller: _mobileNoController, hint: '',label: 'UTR No.'),
                            _buildTextField(controller: _regardingController, hint: '',label: 'UPI (optional)'),
                            _buildTextField(controller: _messageController, hint: '',label: 'Description (optional)',),
                            SizedBox(height: 20,),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    /// All fields valid ✅
                                    Get.snackbar("Success", "Enquiry submitted!",
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Submit Fund Request',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // SliverList(
            //   delegate: SliverChildBuilderDelegate((context, index) {
            //     final tx = controller.filteredTransactions[index];
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 16,
            //         vertical: 8,
            //       ),
            //       child: _buildTransactionCard(
            //         tx["title"],
            //         tx["subtitle"],
            //         tx["amount"],
            //         tx["icon"],
            //         tx["time"],
            //       ),
            //     );
            //   }, childCount: controller.filteredTransactions.length),
            // ),
          ],
        ),
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
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLength: maxL,
          maxLines: label.contains("Message") ? 4 : 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType:
          label.contains("UTR No.") || label.contains("Amount")
              ? TextInputType.phone
              : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            counterText: '',
            fillColor: const Color(0xFFf9fafb),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFe5e7eb), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            if (label == "Email" &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "Enter a valid email address";
            }

            return null;
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 0,
      floating: true,
      pinned: true,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffA9E2FF), Color(0xff44A5E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  Text(
                    "Fund Request",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  _buildAppBarIcon(Icons.notifications_outlined, () {}),
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
