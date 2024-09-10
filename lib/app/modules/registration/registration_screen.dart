// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mondooli_registration/app/modules/registration/registration_viewmodel.dart';
import 'package:mondooli_registration/app/modules/registration/widget/appbar_stepper.dart';
import 'package:mondooli_registration/app/modules/registration/widget/form/form1.dart';
import 'package:mondooli_registration/app/modules/registration/widget/form/form2.dart';
import 'package:mondooli_registration/app/modules/registration/widget/form/form3.dart';
import 'package:mondooli_registration/app/modules/registration/widget/form/form4.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistrationViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Consumer<RegistrationViewModel>(
            builder: (context, model, child) => IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => model.previousStep(context),
            ),
          ),
          automaticallyImplyLeading: false,
          title: Consumer<RegistrationViewModel>(
            builder: (context, model, child) => CustomStepper(
              currentStep: model.currentStep,
              steps: model.steps,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<RegistrationViewModel>(
          builder: (context, viewmodel, child) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: Form(
                      key: viewmodel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Konfirmasi Data dan\nLengkapi Profil',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, bottom: 18),
                            child: Text(
                              'Cek ulang data pribadi kamu dan lengkapi profil sepenuhnya.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          if (viewmodel.currentStep == 0)
                            Form1(
                              emailController: viewmodel.emailController1,
                              socialMediaController:
                                  viewmodel.socialMediaController1,
                              noWhatsappCodeController:
                                  viewmodel.noWhatsappCodeController1,
                            ),
                          if (viewmodel.currentStep == 1)
                            Form2(
                              emailController: viewmodel.emailController2,
                              socialMediaController:
                                  viewmodel.socialMediaController2,
                              noWhatsappCodeController:
                                  viewmodel.noWhatsappCodeController2,
                            ),
                          if (viewmodel.currentStep == 2)
                            Form3(
                              emailController: viewmodel.emailController3,
                              socialMediaController:
                                  viewmodel.socialMediaController3,
                              noWhatsappCodeController:
                                  viewmodel.noWhatsappCodeController3,
                            ),
                          if (viewmodel.currentStep == 3)
                            Form4(
                              firstNameController:
                                  viewmodel.firstNameController,
                              lastNameController: viewmodel.lastNameController,
                              dateOfBirthController:
                                  viewmodel.dateOfBirthController,
                              phoneController: viewmodel.phoneController,
                              countryController: viewmodel.countryController,
                              provinceController: viewmodel.provinceController,
                              citiesController: viewmodel.citiesController,
                              districController: viewmodel.districtController,
                              subdistricController:
                                  viewmodel.subDistrictController,
                              postalCodeController:
                                  viewmodel.postalCodeController,
                              addressController: viewmodel.addressController,
                            ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        minimumSize: Size(800, 50),
                      ),
                      onPressed: viewmodel.isLoading
                          ? null
                          : () {
                              viewmodel.nextStep(context);
                            },
                      child: viewmodel.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              viewmodel.currentStep ==
                                      viewmodel.steps.length - 1
                                  ? 'Submit'
                                  : 'Lanjutkan',
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
