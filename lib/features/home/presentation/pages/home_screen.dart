import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';
import '../widgets/section/slogan_home_section.dart';
import '../widgets/section/greeting_home_section.dart';
import '../widgets/section/service_home_section.dart';
import '../widgets/section/contact_home_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const HomeScreen({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppBar(
        backgroundColor: AppColors.brand['default'],
        elevation: 0,
        leading:
            onMenuPressed != null
                ? IconButton(
                  icon: Icon(Icons.menu, color: AppColors.brand['accent']),
                  onPressed: onMenuPressed,
                )
                : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, color: AppColors.white['default']),
            const SizedBox(width: 8),
            Text(
              'SEA Catering',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: AppColors.white['default'],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SloganHomeSection(),
            SizedBox(height: 28),
            GreetingHomeSection(),
            SizedBox(height: 32),
            ServiceHomeSection(),
            SizedBox(height: 36),
            ContactHomeSection(),
            FirebaseLoginSection(),
          ],
        ),
      ),
    );
  }
}

class FirebaseLoginSection extends StatefulWidget {
  const FirebaseLoginSection({super.key});

  @override
  State<FirebaseLoginSection> createState() => _FirebaseLoginSectionState();
}

class _FirebaseLoginSectionState extends State<FirebaseLoginSection> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _loading = false;
  String? _message;

  // Tambahkan controller untuk form buku
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _pagesCtrl = TextEditingController();
  bool _bookLoading = false;
  String? _bookMessage;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _message = null;
    });
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );
      setState(() {
        _message = "Register success!";
      });
    } catch (e) {
      setState(() {
        _message = "Register failed: ${e.toString()}";
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _createBook() async {
    setState(() {
      _bookLoading = true;
      _bookMessage = null;
    });
    try {
      final title = _titleCtrl.text.trim();
      final pages = int.tryParse(_pagesCtrl.text.trim());
      if (title.isEmpty || pages == null) {
        setState(() {
          _bookMessage = "Please enter a valid title and page count.";
        });
        _bookLoading = false;
        return;
      }
      await FirebaseFirestore.instance.collection('books').add({
        'title': title,
        'pages': pages,
        'createdAt': FieldValue.serverTimestamp(),
      });
      setState(() {
        _bookMessage = "Book added successfully!";
        _titleCtrl.clear();
        _pagesCtrl.clear();
      });
    } catch (e) {
      setState(() {
        _bookMessage = "Failed to add book: ${e.toString()}";
      });
    }
    setState(() {
      _bookLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          "Register to Firebase Project",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.brand['default'],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailCtrl,
          decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordCtrl,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _loading ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brand['default'],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child:
                _loading
                    ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : const Text("Register"),
          ),
        ),
        if (_message != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _message!,
              style: TextStyle(
                color:
                    _message!.contains("success") ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        const SizedBox(height: 32),
        Text(
          "Create Book",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.brand['default'],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _titleCtrl,
          decoration: InputDecoration(
            labelText: "Book Title",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.book),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _pagesCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Number of Pages",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.numbers),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _bookLoading ? null : _createBook,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brand['default'],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child:
                _bookLoading
                    ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : const Text("Create Book"),
          ),
        ),
        if (_bookMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _bookMessage!,
              style: TextStyle(
                color:
                    _bookMessage!.contains("success")
                        ? Colors.green
                        : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
