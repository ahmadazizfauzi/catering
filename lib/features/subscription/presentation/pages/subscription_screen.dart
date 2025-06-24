import 'package:catering_1/features/subscription/presentation/data/subscription_data.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _allergyCtrl = TextEditingController();

  String? _selectedPlan;
  final List<String> _mealTypes = [];
  final List<String> _deliveryDays = [];

  double get totalPrice {
    if (_selectedPlan == null || _mealTypes.isEmpty || _deliveryDays.isEmpty)
      return 0;
    final planPrice = plans[_selectedPlan]!;
    return planPrice * _mealTypes.length * _deliveryDays.length * 4.3;
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
                nameCtrl: _nameCtrl,
                phoneCtrl: _phoneCtrl,
              ),
              const SizedBox(height: 24),
              FormPlanSubscriptionSection(
                selectedPlan: _selectedPlan,
                plans: plans,
                onChanged: (val) => setState(() => _selectedPlan = val),
              ),
              const SizedBox(height: 24),
              FormMealSubscriptionSection(
                mealTypes: _mealTypes,
                mealOptions: mealOptions,
                onAdd: (m) => setState(() => _mealTypes.add(m)),
                onRemove: (m) => setState(() => _mealTypes.remove(m)),
              ),
              const SizedBox(height: 24),
              FormDeliverySubscriptionSection(
                deliveryDays: _deliveryDays,
                days: days,
                onAdd: (d) => setState(() => _deliveryDays.add(d)),
                onRemove: (d) => setState(() => _deliveryDays.remove(d)),
              ),
              const SizedBox(height: 16),
              FormAlergySubscriptionSection(allergyCtrl: _allergyCtrl),
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
                    'Rp${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},00',
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
      _mealTypes.isNotEmpty &&
      _deliveryDays.isNotEmpty) {
    final provider = Provider.of<SubscriptionProvider>(context, listen: false);
    await provider.save(
      name: _nameCtrl.text,
      phone: _phoneCtrl.text,
      allergy: _allergyCtrl.text.isEmpty ? null : _allergyCtrl.text,
      plan: _selectedPlan!,
      mealTypes: List<String>.from(_mealTypes),
      deliveryDays: List<String>.from(_deliveryDays),
      totalPrice: totalPrice,
    );

    if (provider.message != null && provider.message!.contains("success")) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColors.white['default'],
          title: Text(
            'Subscription Submitted',
            style: TextStyle(
              color: AppColors.brand['default'],
            ),
          ),
          content: Text(
            'Thank you, ${_nameCtrl.text}! Your subscription has been received.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppColors.brand['default'],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (provider.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.message!)),
      );
    }
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
