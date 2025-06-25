import 'package:catering_1/features/testimonial/domain/entities/testimonial.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import 'package:provider/provider.dart';
import '../../provider/testimonial_provider.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  int _current = 0;

  @override
  void initState() {
    super.initState();
    // Ambil data testimonial dari provider saat widget pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestimonialProvider>(context, listen: false).getAll();
    });
  }

  Widget _buildCardTestimonial(Testimonial t) {
    return Card(
      color: AppColors.white['default'],
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: t.photo != null && t.photo!.isNotEmpty
                  ? NetworkImage(t.photo!)
                  : null,
              backgroundColor: AppColors.brand['light'],
              child: (t.photo == null || t.photo!.isEmpty)
                  ? Icon(Icons.person, color: AppColors.brand['dark'])
                  : null,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (idx) => Icon(
                  Icons.star,
                  color: idx < t.rating ? Colors.amber : Colors.grey[300],
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Text(
                  '"${t.message}"',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: AppColors.brand['text']),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '- ${t.name} -',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.brand['default']),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestimonialProvider>(context);
    final testimonials = provider.testimonials;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (testimonials.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          "Belum ada testimoni.",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            itemCount: testimonials.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) {
              final t = testimonials[i];
              return _buildCardTestimonial(t);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            testimonials.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _current == i ? AppColors.brand['default'] : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}