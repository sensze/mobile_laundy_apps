import 'package:flutter/material.dart';
import 'package:mobile_laundy_apps/utils/GetScreenSize.dart';
import 'package:mobile_laundy_apps/views/widgets/CustomButton.dart';
import 'package:mobile_laundy_apps/views/widgets/CustomCheckboxWithText.dart';
import 'package:mobile_laundy_apps/views/widgets/CustomDividerWithText.dart';
import 'package:mobile_laundy_apps/views/widgets/CustomInputField.dart';
import 'package:mobile_laundy_apps/views/widgets/CustomOutlinedButton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: GetScreenSize().getScreenHeight(context),
            ),
            Positioned(
              top: 40,
              width: 165,
              height: 165,
              child: Image.asset(
                "lib/assets/images/wireframe.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 36, left: 36, right: 36),
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > 300) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hai, Selamat Datang!",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Mohon isi semua kolom dengan benar",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.5)),
                          ),
                          const SizedBox(height: 15),
                          CustomInputField()
                              .setController(emailController)
                              .setLabel("Email")
                              .setLabelFontSize(15)
                              .setIcon(const Icon(Icons.email_outlined))
                              .setSizedBoxHeight(20)
                              .build(context),
                          CustomInputField()
                              .setController(passwordController)
                              .setLabel("Password")
                              .setIcon(const Icon(Icons.lock_outline))
                              .setLabelFontSize(15)
                              .setObscureText(true)
                              .build(context),
                          CustomCheckboxWithText()
                              .setOnChanged((p0) {})
                              .setText("Ingat saya?")
                              .build(context),
                          SizedBox(
                            width: GetScreenSize().getScreenWidth(context),
                            child: CustomButton()
                                .setLabel("Masuk")
                                .setOnPressed(() {})
                                .build(context),
                          ),
                          const SizedBox(height: 20),
                          CustomDividerWithText()
                              .setLabel("Atau masuk dengan email")
                              .build(context),
                          const SizedBox(height: 20),
                          CustomOutlinedButton()
                              .setLabel("Masuk dengan Google")
                              .build(context),
                          // const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Akunnya belum ada nih, mau",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.5))),
                              TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(0)),
                                  child: const Text("Daftar ?",
                                      style: TextStyle(
                                          fontFamily: "Inter", fontSize: 13)))
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    /*Implement bigger screen size*/
                    return const Text("Wide");
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
