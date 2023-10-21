import 'package:flutter/material.dart';
import 'package:mobile_laundy_apps/routes/routes.dart';
import 'package:mobile_laundy_apps/utils/get_screen_size.dart';
import 'package:mobile_laundy_apps/views/widgets/custom_button.dart';
import 'package:mobile_laundy_apps/views/widgets/custom_input_field.dart';
import 'package:mobile_laundy_apps/views/widgets/custom_text_area.dart';

class MitraRegisterLaundry extends StatefulWidget {
  const MitraRegisterLaundry({super.key});

  @override
  State<MitraRegisterLaundry> createState() => _MitraRegisterLaundryState();
}

class _MitraRegisterLaundryState extends State<MitraRegisterLaundry> {
  TextEditingController laundryNameController = TextEditingController();
  TextEditingController laundryAddressController = TextEditingController();
  TextEditingController laundryPhoneController = TextEditingController();
  TextEditingController laundryPriceRangeController = TextEditingController();
  TextEditingController laundryDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: GetScreenSize.getScreenHeight(context),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                          "Masukkan Data Laundry!",
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
                            .setController(laundryNameController)
                            .setLabel("Nama Laundry")
                            .setIcon(const Icon(Icons.home_outlined))
                            .setSizedBoxHeight(20)
                            .build(context),
                        CustomTextArea()
                            .setSizedBoxHeight(20)
                            .setIcon(const Icon(Icons.location_on_outlined))
                            .setLabel("Alamat Laundry")
                            .build(context),
                        CustomInputField()
                            .setController(laundryPhoneController)
                            .setLabel("No. Telepon Laundry")
                            .setIcon(const Icon(Icons.call_outlined))
                            .setKeyboardType(TextInputType.phone)
                            .setSizedBoxHeight(20)
                            .build(context),
                        CustomInputField()
                            .setController(laundryPriceRangeController)
                            .setLabel("Kisaran Harga Laundry")
                            .setIcon(const Icon(Icons.price_change_outlined))
                            .setSizedBoxHeight(20)
                            .build(context),
                        CustomTextArea()
                            .setController(laundryDescriptionController)
                            .setSizedBoxHeight(20)
                            .setIcon(const Icon(Icons.short_text_rounded))
                            .setLabel("Deskripsi Laundry")
                            .build(context),
                        SizedBox(
                          width: GetScreenSize.getScreenWidth(context),
                          child: CustomButton().setLabel("Daftar").setOnPressed(
                            () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.authCheck);
                              });
                            },
                          ).build(context),
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
          Positioned(
            top: 30,
            height: 104,
            width: 104,
            child: Image.asset("lib/assets/images/iron.png"),
          ),
        ],
      ),
    ));
  }
}
