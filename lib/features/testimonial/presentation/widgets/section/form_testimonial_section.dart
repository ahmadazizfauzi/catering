import 'package:catering_1/core/shared/modal/modal_alert.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import '../../manager/testimonial_form_manager.dart';

class FormTestimonialSection extends StatefulWidget {
  final TestimonialFormManager formManager;
  final void Function()? onSubmit;
  const FormTestimonialSection({
    super.key,
    required this.formManager,
    this.onSubmit,
  });

  @override
  State<FormTestimonialSection> createState() => FormTestimonialSectionState();
}

class FormTestimonialSectionState extends State<FormTestimonialSection> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formManager = widget.formManager;
    return Card(
      color: AppColors.white['default'],
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tulis Testimoni',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.brand['default'],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: formManager.nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: formManager.messageController,
                decoration: const InputDecoration(labelText: 'Pesan'),
                maxLines: 1,
                validator:
                    (v) =>
                        (v == null || v.isEmpty) ? 'Pesan wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Rating:',
                    style: TextStyle(color: AppColors.brand['text']),
                  ),
                  const SizedBox(width: 8),
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color:
                            i <= formManager.rating
                                ? Colors.amber
                                : Colors.grey[300],
                      ),
                      onPressed: () => setState(() => formManager.rating = i),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand['default'],
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.onSubmit != null) widget.onSubmit!();
                      showModalAlert(
                        context: context,
                        title: "Testimoni Terkirim",
                        content: "Terima kasih atas testimoni Anda!",
                        status: "success",
                        buttonText: "OK",
                        onClose: () {
                          Navigator.of(context).pop();
                        },
                      );
                      formManager.nameController.clear();
                      formManager.messageController.clear();
                      setState(() => formManager.rating = 5);
                    }
                  },
                  child: const Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
