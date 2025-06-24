import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class FormTestimonialSection extends StatefulWidget {
  final void Function(String name, String message, int rating)? onSubmit;
  const FormTestimonialSection({super.key, this.onSubmit});

  @override
  State<FormTestimonialSection> createState() => FormTestimonialSectionState();
}

class FormTestimonialSectionState extends State<FormTestimonialSection> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _message = '';
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
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
              Text('Tulis Testimoni', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.brand['default'])),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama'),
                onSaved: (v) => _name = v ?? '',
                validator: (v) => (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Pesan'),
                maxLines: 2,
                onSaved: (v) => _message = v ?? '',
                validator: (v) => (v == null || v.isEmpty) ? 'Pesan wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('Rating:', style: TextStyle(color: AppColors.brand['text'])),
                  const SizedBox(width: 8),
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color: i <= _rating ? Colors.amber : Colors.grey[300],
                      ),
                      onPressed: () => setState(() => _rating = i),
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
                      _formKey.currentState!.save();
                      widget.onSubmit?.call(_name, _message, _rating);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Testimoni berhasil dikirim!')),
                      );
                      _formKey.currentState!.reset();
                      setState(() => _rating = 5);
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