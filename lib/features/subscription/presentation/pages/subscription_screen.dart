import 'package:catering_1/features/subscription/presentation/data/subscription_data.dart';
import 'package:catering_1/features/subscription/presentation/manager/subscription_form_manager.dart';
import 'package:catering_1/features/subscription/presentation/widgets/section/form/form_biodata_subscription_section.dart.dart';
import 'package:catering_1/features/subscription/presentation/widgets/section/header/header_subscription_section.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import '../widgets/section/form/form_plan_subscription_section.dart';
import '../widgets/section/form/form_meal_subscription_section.dart';
import '../widgets/section/form/form_delivery_subscription_section.dart';
import '../widgets/section/form/form_alergy_subscription_section.dart';
import '../provider/subscription_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final _formManager = SubscriptionFormManager();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Subscription Form',
          style: TextStyle(color: AppColors.white['default']),
        ),
        backgroundColor: AppColors.brand['default'],
        foregroundColor: Colors.white,
        elevation: 0,
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
                onChanged: (val) => setState(() => _formManager.selectedPlan = val),
              ),
              const SizedBox(height: 24),
              FormMealSubscriptionSection(
                mealTypes: _formManager.mealTypes,
                mealOptions: mealOptions,
                onAdd: (m) => setState(() => _formManager.mealTypes.add(m)),
                onRemove: (m) => setState(() => _formManager.mealTypes.remove(m)),
              ),
              const SizedBox(height: 24),
              FormDeliverySubscriptionSection(
                deliveryDays: _formManager.deliveryDays,
                days: days,
                onAdd: (d) => setState(() => _formManager.deliveryDays.add(d)),
                onRemove: (d) => setState(() => _formManager.deliveryDays.remove(d)),
              ),
              const SizedBox(height: 16),
              FormAlergySubscriptionSection(allergyCtrl: _formManager.allergyController),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand['default'],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _formManager.isValid) {
                      final provider = Provider.of<SubscriptionProvider>(
                        context,
                        listen: false,
                      );
                      await provider.save(_formManager.toEntity());
                    }
                  },
                  child: const Text('Submit', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}