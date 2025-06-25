import 'package:catering_1/core/shared/modal/modal_alert.dart';
import 'package:catering_1/features/testimonial/presentation/widgets/section/form_testimonial_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/section/testimonial_section.dart';
import '../manager/testimonial_form_manager.dart';
import '../provider/testimonial_provider.dart';

class TestimonialScreen extends StatefulWidget {
  const TestimonialScreen({super.key});

  @override
  State<TestimonialScreen> createState() => _TestimonialScreenState();
}

class _TestimonialScreenState extends State<TestimonialScreen> {
  final _formManager = TestimonialFormManager();

  @override
  void dispose() {
    _formManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestimonialProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Kami')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TestimonialSection(),
            FormTestimonialSection(
              formManager: _formManager,
              onSubmit: () async {
                if (_formManager.isValid) {
                  await provider.save(_formManager.toEntity());
                  if (provider.message != null) {
                    showModalAlert(
                      // ignore: use_build_context_synchronously
                      context: context,
                      title: "Terima Kasih!",
                      content: provider.message!,
                      status: "success",
                      buttonText: "OK",
                      onClose: () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}