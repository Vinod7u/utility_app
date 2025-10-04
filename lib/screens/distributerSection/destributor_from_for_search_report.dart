import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/payIn_transaction_report.dart';
import 'package:utility_app_flutter/screens/home/usersection/notificaton_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class DestributorFromForSearchReport extends StatefulWidget {
  final String screenName;
  const DestributorFromForSearchReport({super.key, required this.screenName});

  @override
  State<DestributorFromForSearchReport> createState() =>
      _DestributorFromForSearchReportState();
}

class _DestributorFromForSearchReportState
    extends State<DestributorFromForSearchReport> {
  final PayinTransactionReportController controller = Get.put(
    PayinTransactionReportController(),
  );

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

            // 🔹 Notifications List
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 50,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true, // 🔹 ensures title centers
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
                // 🔹 Left Icon (Menu)
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildAppBarIcon(Icons.arrow_back_ios, () {
                    Get.back();
                  }),
                ),

                // 🔹 Center Title
                Text(
                  "Payin Report",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                // 🔹 Right Icon (Notification)
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  /// -------------------- FILTER FORM --------------------
  Widget _filterForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.screenName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[900],
                ),
              ),
            ),

            Divider(color: Colors.blueGrey.shade200),
            const SizedBox(height: 20),

            // 🔹 Search Field
            TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: "Search by name, UTR, amount, etc...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 From Date
            TextFormField(
              controller: controller.fromDateController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.fromDateController.text =
                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                }
              },
              decoration: InputDecoration(
                labelText: "From Date",
                hintText: "dd-mm-yy",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 To Date
            TextFormField(
              controller: controller.toDateController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.toDateController.text =
                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                }
              },
              decoration: InputDecoration(
                labelText: "To Date",
                hintText: "dd-mm-yy",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
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
      ),
    );
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
