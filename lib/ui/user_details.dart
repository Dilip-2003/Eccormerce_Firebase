import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/const/colors.dart';
import 'package:ecommerce_firebase/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UserDetails extends StatefulWidget {
  const UserDetails(
      {super.key,
      required this.emailController,
      required this.paswordController});
  final String emailController, paswordController;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late DateRangePickerController dateRangePickerController;
  bool isCalendarVisible = false;
  DateTime? selectedDate;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dropdownController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  List<String> dropdownItems = ['Female', 'Male', 'Others'];

  @override
  void initState() {
    super.initState();
    dateRangePickerController = DateRangePickerController();
  }

  sendUserDataToDataBase() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionReference =
        FirebaseFirestore.instance.collection('user_details');
    return _collectionReference
        .doc(currentUser!.email)
        .set({
          'name': nameController.text,
          'phone': phoneController.text,
          'dob': dobController.text,
          'age': ageController.text,
          'gender': dropdownController.text,
        })
        .then((value) => print('user data added'))
        .catchError((error) => print('something is wrong $error'));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColor.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submit this form to continue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: MyColor.primaryColor,
                ),
              ),
              const Text(
                'We will not share your information anywhere.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text(
                    'Enter your name',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  label: Text(
                    'Enter your Phone Number',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              TextField(
                controller: dobController,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCalendarVisible = !isCalendarVisible;
                      });
                    },
                    child: Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.blue.shade400,
                    ),
                  ),
                  label: const Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isCalendarVisible,
                child: SfDateRangePicker(
                  controller: dateRangePickerController,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.single,
                  headerHeight: height * 0.075,
                  showActionButtons: true,
                  showNavigationArrow: true,
                  onCancel: () {
                    setState(() {
                      isCalendarVisible = false;
                    });
                  },
                  onSubmit: (value) {
                    print(value);
                    selectedDate = (value as DateTime?);
                    setState(() {
                      isCalendarVisible = false;
                      dobController.text =
                          DateFormat('dd MMMM yyyy').format(selectedDate!);
                      calculateAge(); // Calculate age when dob is selected
                    });
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: dropdownController,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _showDropdown(context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.blue.shade400,
                            size: 40,
                          ),
                        ),
                        label: const Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              TextField(
                controller: ageController,
                readOnly: true,
                decoration: const InputDecoration(
                  label: Text(
                    'Age (Years)',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              InkWell(
                onTap: () {
                  sendUserDataToDataBase();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                  print('button click');
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: MyColor.primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: MyColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            children: dropdownItems
                .map(
                  (item) => ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        dropdownController.text = item;
                      });
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void calculateAge() {
    if (selectedDate != null) {
      final now = DateTime.now();
      final age = now.year - selectedDate!.year;
      setState(() {
        ageController.text = age.toString();
      });
    }
  }
}
