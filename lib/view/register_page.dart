import 'package:bootcamp_project/constants/r.dart';
import 'package:bootcamp_project/helpers/user_email.dart';
import 'package:bootcamp_project/models/network_response.dart';
import 'package:bootcamp_project/models/user_by_email.dart';
import 'package:bootcamp_project/repository/auth_api.dart';
import 'package:bootcamp_project/view/login_page.dart';
import 'package:bootcamp_project/view/main_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String route = "register_page";
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { lakiLaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  List<String> calssSlta = ["10", "11", "12"];

  String gender = "Laki-Laki";
  String selectedClass = "10";
  final emailControler = TextEditingController();
  final schoolNameControler = TextEditingController();
  final fullNameControler = TextEditingController();

  onTapGender(Gender genderInput) {
    if (genderInput == Gender.lakiLaki) {
      gender = "Laki-Laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDataUser() {
    emailControler.text = UserEmail.getUserEmail()!;
    fullNameControler.text = UserEmail.getUserDisplayName()!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F3F5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Yuk Isi Data Diri",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
            backgroundColor: R.colors.primary,
            borderColor: R.colors.primary,
            onTap: () async {
              final json = {
                "email": emailControler.text,
                "nama_lengkap": fullNameControler.text,
                "nama_sekolah": schoolNameControler.text,
                "kelas": selectedClass,
                "gender": gender,
                "foto": UserEmail.getUserPhotoUrl(),
              };
              print(json);
              final result = await AuthApi().postRegister(json);
              print(result);
              if (result.status == Status.success) {
                final registerResult = UserByEmail.fromJson(result.data!);
                print(registerResult);
                if (registerResult.status == 1) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainPage.route, (context) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(registerResult.message!)));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Terjadi kesalahan, silajkan ulangi kembali")));
              }
            },
            child: Text(
              R.strings.daftar,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegisterTextField(
                controller: emailControler,
                title: 'Email anda',
                hintText: 'Email',
                enabled: false,
              ),
              RegisterTextField(
                title: 'Nama lengkap anda',
                hintText: 'Nama lengkap',
                controller: fullNameControler,
              ),
              SizedBox(height: 5),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: gender == "Laki-Laki"
                                  ? R.colors.primary
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    width: 1, color: R.colors.greyBorder),
                              )),
                          onPressed: () {
                            onTapGender(Gender.lakiLaki);
                          },
                          child: Text(
                            "Laki-Laki",
                            style: TextStyle(
                              fontSize: 14,
                              color: gender == "Laki-Laki"
                                  ? Colors.white
                                  : Color(0xff282828),
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: gender == "Perempuan"
                                  ? R.colors.primary
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    width: 1, color: R.colors.greyBorder),
                              )),
                          onPressed: () {
                            onTapGender(Gender.perempuan);
                          },
                          child: Text(
                            "Perempuan",
                            style: TextStyle(
                              fontSize: 14,
                              color: gender == "Perempuan"
                                  ? Colors.white
                                  : Color(0xff282828),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Kelas",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: R.colors.greyBorder),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedClass,
                      items: calssSlta
                          .map(
                            (e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (String? val) {
                        selectedClass = val!;
                        setState(() {});
                      }),
                ),
              ),
              SizedBox(height: 5),
              RegisterTextField(
                title: 'Nama Sekolah anda',
                hintText: 'Nama Sekolah',
                controller: schoolNameControler,
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.enabled = true,
  }) : super(key: key);

  final String title;
  final String hintText;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: R.colors.greyBorder),
          ),
          child: TextField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: R.colors.greyHintText,
                )),
          ),
        ),
      ],
    );
  }
}
