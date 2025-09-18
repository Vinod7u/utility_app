import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class RetailerRegister extends StatefulWidget {
  const RetailerRegister({super.key});

  @override
  State<RetailerRegister> createState() => _RetailerRegisterState();
}

class _RetailerRegisterState extends State<RetailerRegister> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController businessNameC = TextEditingController();
  final TextEditingController pinCodeC = TextEditingController();
  final TextEditingController addressC = TextEditingController();
  final TextEditingController fileC = TextEditingController();
  final TextEditingController mFilesC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Retailer Register',style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text('Name'),
              TextFormField(
                controller: nameC,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null; // valid
                },
                onSaved: (value) {
                  // Save value to model/state
                },
              ),
              SizedBox(height: 10,),
              //Text('Phone'),
              TextFormField(
                controller: phoneC,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone is required';
                  }
                  return null; // valid
                },
                onSaved: (value) {
                  // Save value to model/state
                },
              ),
              SizedBox(height: 10,),
              //Text('Email'),
              TextFormField(
                controller: emailC,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'email is required';
                  }
                  return null; // valid
                },
                onSaved: (value) {
                  // Save value to model/state
                },
              ),

              SizedBox(height: 10,),
              //Business Section
              //Text('Business Name'),
              TextFormField(
                controller: businessNameC,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  hintText: 'Enter your Business Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Business Name is required';
                  }
                  return null; // valid
                },
                onSaved: (value) {
                  // Save value to model/state
                },
              ),
              SizedBox(height: 10,),
              //Text('Pincode'),
              TextFormField(
                controller: pinCodeC,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'PinCode',
                  hintText: 'Enter your PinCode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'PinCode is required';
                  }
                  return null; // valid
                },
                onSaved: (value) {
                  // Save value to model/state
                },
              ),
              SizedBox(height: 10,),
              //Text('Address'),
              TextFormField(
                controller: addressC,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Address is required';
                  }
                  return null; // valid
                },
                onSaved: (value) {
                  // Save value to model/state
                },
              ),

              SizedBox(height: 10,),
             // Text('Owner Photo'),
              TextFormField(
                controller: fileC,
                readOnly: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Owner Photo',
                  hintText: 'Choose File',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'File is required';
                  }
                  return null; // valid
                },
                onSaved: (value) {
                  // Save value to model/state
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}