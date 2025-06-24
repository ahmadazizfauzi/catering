import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import '../../data/ratings_data.dart';

class TestimonialAboutSection extends StatefulWidget {
  const TestimonialAboutSection({super.key});

  @override
  State<TestimonialAboutSection> createState() => _TestimonialAboutSectionState();
}

class _TestimonialAboutSectionState extends State<TestimonialAboutSection> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            itemCount: sampleTestimonials.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) {
              final t = sampleTestimonials[i];
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (idx) => Icon(
                            Icons.star,
                            color: idx < t['rating'] ? Colors.amber : Colors.grey[300],
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '"${t['message']}"',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: AppColors.brand['text']),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '- ${t['name']} -',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.brand['default']),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            sampleTestimonials.length,
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