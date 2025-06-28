import 'package:catering_1/core/shared/appbar/appbar_shared.dart';
import 'package:catering_1/core/shared/button/button_shared.dart';
import 'package:catering_1/core/shared/modal/modal_alert.dart';
import 'package:catering_1/features/subscription/presentation/data/subscription_data.dart';
import 'package:catering_1/features/subscription/presentation/manager/subscription_form_manager.dart';
import 'package:catering_1/features/subscription/presentation/widgets/section/form/form_biodata_subscription_section.dart.dart';
import 'package:catering_1/features/subscription/presentation/widgets/section/header/header_subscription_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import '../../widgets/section/form/form_plan_subscription_section.dart';
import '../../widgets/section/form/form_meal_subscription_section.dart';
import '../../widgets/section/form/form_delivery_subscription_section.dart';
import '../../widgets/section/form/form_alergy_subscription_section.dart';
import '../../provider/consumen/consumen_subscription_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  final VoidCallback? onMenuPressed;

  const SubscriptionScreen({super.key, this.onMenuPressed});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final _formManager = SubscriptionFormManager();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _formManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppbarShared(
        leading:
            widget.onMenuPressed != null
                ? IconButton(
                  icon: Icon(Icons.menu, color: AppColors.white['default']),
                  onPressed: widget.onMenuPressed,
                )
                : null,
        title: 'Subscription Form',
        icon: Icon(Icons.receipt_long, color: AppColors.white['default']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSubscriptionSection(),
              const SizedBox(height: 24),
              FormBiodataSubscriptionSection(
                nameCtrl: _formManager.nameController,
                phoneCtrl: _formManager.phoneController,
              ),
              const SizedBox(height: 24),
              FormPlanSubscriptionSection(
                selectedPlan: _formManager.selectedPlan,
                plans: plans,
                onChanged:
                    (val) => setState(() => _formManager.selectedPlan = val),
              ),
              const SizedBox(height: 24),
              FormMealSubscriptionSection(
                mealTypes: _formManager.mealTypes,
                mealOptions: mealOptions,
                onAdd: (m) => setState(() => _formManager.mealTypes.add(m)),
                onRemove:
                    (m) => setState(() => _formManager.mealTypes.remove(m)),
              ),
              const SizedBox(height: 24),
              FormDeliverySubscriptionSection(
                deliveryDays: _formManager.deliveryDays,
                days: days,
                onAdd: (d) => setState(() => _formManager.deliveryDays.add(d)),
                onRemove:
                    (d) => setState(() => _formManager.deliveryDays.remove(d)),
              ),
              const SizedBox(height: 16),
              FormAlergySubscriptionSection(
                allergyCtrl: _formManager.allergyController,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.brand['default'],
                    ),
                  ),
                  Text(
                    'Rp${_formManager.totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.brand['dark'],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ButtonShared(
                  onPressed:
                      _isLoading
                          ? null
                          : () async {
                            if (_formKey.currentState!.validate() &&
                                _formManager.isValid) {
                              setState(() => _isLoading = true);
                              final provider =
                                  Provider.of<ConsumenSubscriptionProvider>(
                                    context,
                                    listen: false,
                                  );
                              final userId =
                                  FirebaseAuth.instance.currentUser?.uid ?? '';
                              await provider.save(
                                _formManager.toEntity(userId),
                                userId,
                              );
                              setState(() => _isLoading = false);

                              if (provider.message?.contains("success") ==
                                  true) {
                                showModalAlert(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  title: "Success",
                                  content: "Subscription has been saved successfully!",
                                  status: "success",
                                  buttonText: "OK",
                                  onClose: () {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pop();
                                    // After modal is closed, reset form
                                    _formKey.currentState?.reset();
                                    _formManager.nameController.clear();
                                    _formManager.phoneController.clear();
                                    _formManager.allergyController.clear();
                                    _formManager.selectedPlan = null;
                                    _formManager.mealTypes.clear();
                                    _formManager.deliveryDays.clear();
                                    setState(() {});
                                  },
                                );
                              } else if (provider.message != null) {
                                showModalAlert(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  title: "Failed",
                                  content: provider.message!,
                                  status: "failed",
                                  buttonText: "OK",
                                  onClose: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            }
                          },
                  text: 'Submit',
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
