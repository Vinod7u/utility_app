import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFf8fafc), Color(0xFFe2e8f0)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'All Services',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1a202c),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Choose from our wide range of services',
                  style: TextStyle(fontSize: 16, color: Color(0xFF64748b)),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    children: [
                      _buildServiceItem(
                        context,
                        'Electricity Bills',
                        'Pay your electricity bills instantly',
                        Icons.flash_on,
                        [Color(0xFFff9a9e), Color(0xFFfecfef)],
                        () {
                         
                        },
                      ),
                      _buildServiceItem(
                        context,
                        'DMT Transfer',
                        'Domestic Money Transfer',
                        Icons.send,
                        [Color(0xFFa8edea), Color(0xFFfed6e3)],
                        () {},
                       
                      ),
                      _buildServiceItem(
                        context,
                        'Mobile Recharge',
                        'Instant mobile & DTH recharge',
                        Icons.phone_android,
                        [Color(0xFFffecd2), Color(0xFFfcb69f)],
                        () {
                          
                        },
                      ),
                      _buildServiceItem(
                        context,
                        'Credit Card Bills',
                        'Pay credit card bills on time',
                        Icons.credit_card,
                        [Color(0xFFd299c2), Color(0xFFfef9d7)],
                        () {
                          // Handle credit card bills
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    List<Color> gradientColors,
    VoidCallback onTap,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFe2e8f0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColors),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1a202c),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748b)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Color(0xFF667eea), size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
