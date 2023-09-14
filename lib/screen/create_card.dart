import 'package:calc/database/calcdb.dart';
import 'package:calc/model/calcmodel.dart';
import 'package:calc/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/value.dart';
import '../widget/custom_button.dart';
import '../widget/custom_image_picker.dart';
import '../widget/custom_toggle_button.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PlatformFile? file;
  bool isActive = true;
  void picker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      file = result.files.first;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Text(
          "Ovy Calc",
          style: GoogleFonts.chewy(
            letterSpacing: 2,
            textStyle: Theme.of(context).textTheme.headlineSmall,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImagePicker(
                  file: file,
                  onTap: picker,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Name",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: validateName,
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Amount",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: validateAmount,
                  controller: amountController,
                  decoration: const InputDecoration(hintText: 'Amount'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomToggleButton(
                      text: "combo",
                      ontap: () {
                        isActive = true;
                        setState(() {});
                      },
                      isActive: isActive == true,
                    ),
                    CustomToggleButton(
                      text: "single",
                      ontap: () {
                        isActive = false;
                        setState(() {});
                      },
                      isActive: isActive == false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              color: secondaryColor,
              text: "back",
              onTap: () {
                Navigator.pop(context);
              },
            ),
            CustomButton(
              color: primaryColor,
              text: "create",
              onTap: () {
                if (formKey.currentState!.validate() && file != null) {
                  CalcDB.instace.addData(
                    CalcModel(nameController.text, file!.path!,
                        double.parse(amountController.text), isActive),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
