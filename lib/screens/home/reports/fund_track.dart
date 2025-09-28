import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/fund_track_controller.dart';
import 'package:utility_app_flutter/screens/home/usersection/notificaton_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class FundTrack extends StatefulWidget {
  const FundTrack({super.key});

  @override
  State<FundTrack> createState() => _FundTrackState();
}

class _FundTrackState extends State<FundTrack> {
  final FundTrackController controller = Get.put(FundTrackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Obx(() {
                return controller.showTable.value
                    ? _transactionTable()
                    : _filterForm();
              }),
            ),
          ],
        ),
      ),
    );
  }

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
                // Left Menu Icon
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildAppBarIcon(Icons.arrow_back_ios, () {
                    Get.back();
                  }),
                ),

                // Center Title
                const Text(
                  "Fund Tracking",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                // Right Notification Icon
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildAppBarIcon(Icons.notifications_outlined, () {
                    Get.to(() => NotificatonScreen());
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  /// -------------------- FILTER FORM --------------------
  Widget _filterForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Center(
            child: Text(
              "Track Fund History",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Divider(color: Colors.blueGrey.shade200),
          const SizedBox(height: 20),

          // Statistics Cards Row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Success",
                  "₹ 0%",
                  "0%",
                  "Count :0",
                  Icons.trending_up_outlined,
                  AppColors.icon_blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  "Total Filed",
                  "₹ 0%",
                  "0%",
                  "Count :0",
                  Icons.handshake_outlined,
                  AppColors.icon_blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  "Total Pending",
                  "₹ 0%",
                  "0%",
                  "Count :0",
                  Icons.people_outline,
                  AppColors.icon_blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Search Field

          // 🔹 Search Field
          TextFormField(
            controller: controller.searchController,
            decoration: _inputDecoration("Search by name, UTR, amount, etc..."),
          ),
          const SizedBox(height: 16),

          // 🔹 Status Dropdown (DropdownButton2)
          Obx(
            () => DropdownButtonFormField2<String>(
              value: controller.selectedStatus.value,
              items: controller.statusList
                  .map(
                    (status) =>
                        DropdownMenuItem(value: status, child: Text(status)),
                  )
                  .toList(),
              onChanged: (val) {
                controller.selectedStatus.value = val!;
              },
              decoration: _inputDecoration("Status"),
            ),
          ),
          const SizedBox(height: 16),

          // 🔹 From Date
          TextFormField(
            controller: controller.fromDateController,
            readOnly: true,
            onTap: () => _selectDate(controller.fromDateController),

            decoration: _inputDecoration(
              "From Date",
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 16),

          // 🔹 To Date
          TextFormField(
            controller: controller.toDateController,
            readOnly: true,
            onTap: () => _selectDate(controller.toDateController),

            decoration: _inputDecoration(
              "To Date",
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: controller.applyFilter,
                child: const Text(
                  "Apply",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: controller.resetFilter,
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  // 🔹 Common InputDecoration builder for reusability
  InputDecoration _inputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade50,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.appbarFirstColor,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      suffixIcon: suffixIcon,
    );
  }

  Widget _buildStatCard(
    String title,
    String amount,
    String percentage,
    String count,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                percentage,
                style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
              ),
              Text(
                count,
                style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.appbarFirstColor, // header & selected date
              onPrimary: Colors.white, // text on header
              surface: Colors.white, // background
              onSurface: Colors.black, // default text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    AppColors.appbarFirstColor, // "OK"/"CANCEL" color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      controller.text =
          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year.toString().substring(2)}";
    }
  }

  /// -------------------- TRANSACTION TABLE --------------------
  Widget _transactionTable() {
    // 🔹 Dummy data
    final List<Map<String, String>> transactions = List.generate(100, (index) {
      return {
        "id": "${index + 1}",
        "name": "User ${index + 1}",
        "date": "25-09-2025",
        "amount": "₹${(index + 1) * 500}",
        "utr": "UTR${1000 + index}",
        "reference": "REF${2000 + index}",
        "status": index % 2 == 0 ? "Success" : "Pending",
        "remark": index % 2 == 0 ? "Payment received" : "Waiting",
      };
    });

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(50), // ID
            1: FixedColumnWidth(100), // Name
            2: FixedColumnWidth(100), // Date
            3: FixedColumnWidth(80), // Amount
            4: FixedColumnWidth(120), // UTR
            5: FixedColumnWidth(120), // Reference
            6: FixedColumnWidth(100), // Status
            7: FixedColumnWidth(150), // Remark
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            // 🔹 Header Row
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: [
                _headerCell("ID"),
                _headerCell("Name"),
                _headerCell("Date"),
                _headerCell("Amount"),
                _headerCell("UTR"),
                _headerCell("Reference"),
                _headerCell("Status"),
                _headerCell("Remark"),
              ],
            ),

            // 🔹 Data Rows
            for (var txn in transactions)
              TableRow(
                decoration: BoxDecoration(
                  color: transactions.indexOf(txn) % 2 == 0
                      ? Colors.grey.shade50
                      : Colors.white,
                ),
                children: [
                  _dataCell(txn["id"]!),
                  _dataCell(txn["name"]!),
                  _dataCell(txn["date"]!),
                  _dataCell(txn["amount"]!),
                  _dataCell(txn["utr"]!),
                  _dataCell(txn["reference"]!),
                  _dataCell(
                    txn["status"]!,
                    color: txn["status"] == "Success"
                        ? Colors.green
                        : Colors.orange,
                    bold: true,
                  ),
                  _dataCell(txn["remark"]!),
                ],
              ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Header Cell
  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 🔹 Reusable Data Cell
  Widget _dataCell(String text, {Color? color, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color ?? Colors.black87,
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
