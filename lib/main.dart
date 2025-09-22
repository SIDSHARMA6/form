import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'firebase_options.dart';
import 'data/erectile_dysfunction_quiz.dart';
import 'data/weight_loss_quiz.dart';
import 'data/hair_loss_quiz.dart';
import 'data/premature_ejaculation_quiz.dart';
import 'data/testosterone_booster_quiz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PhoenixApp());
}

class PhoenixApp extends StatelessWidget {
  const PhoenixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoenix Quiz',
      theme: ThemeData(
        primaryColor: const Color(0xFF1E3A8A),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E3A8A),
          secondary: Color(0xFF06B6D4),
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: const OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  User? _currentUser;

  static const treatments = [
    {'title': 'Erectile Dysfunction', 'image': 'assets/doctor.png'},
    {'title': 'Weight Loss', 'image': 'assets/doctor.png'},
    {'title': 'Hair Loss', 'image': 'assets/doctor.png'},
    {'title': 'Premature Ejaculation', 'image': 'assets/doctor.png'},
    {'title': 'Testosterone Booster', 'image': 'assets/doctor.png'},
  ];

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<void> _signInWithGoogle() async {
    try {
      // For web, use Firebase Auth popup
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);

      setState(() {
        _currentUser = userCredential.user;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome ${_currentUser?.displayName ?? 'User'}!'),
            backgroundColor: const Color(0xFF06B6D4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Sign-in failed: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "PHOENIX",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: const Color(0xFF06B6D4),
          ),
        ),
        actions: [
          if (_currentUser != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  _currentUser!.displayName?.split(' ').first ?? 'User',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF06B6D4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(isMobile
            ? 16
            : isTablet
                ? 24
                : 32),
        child: Column(
          children: [
            if (_currentUser == null) ...[
              // Google Sign-In Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Sign in to continue",
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E3A8A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _signInWithGoogle,
                      icon: Image.asset(
                        'assets/google_icon.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                      ),
                      label: Text(
                        'Sign in with Google',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        minimumSize: Size(double.infinity, isMobile ? 52 : 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],

            // Treatment Selection Section
            Text(
              "What treatment are you looking for?",
              style: GoogleFonts.poppins(
                fontSize: isMobile
                    ? 20
                    : isTablet
                        ? 24
                        : 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E3A8A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile
                      ? 1
                      : isTablet
                          ? 2
                          : 3,
                  mainAxisSpacing: isMobile ? 12 : 16,
                  crossAxisSpacing: isMobile ? 12 : 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: treatments.length,
                itemBuilder: (context, index) {
                  final treatment = treatments[index];
                  return TreatmentCard(
                    title: treatment['title']!,
                    image: treatment['image']!,
                    onTap: _currentUser == null
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please sign in first to take the quiz'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizPage(
                                  treatment: treatment['title']!,
                                  user: _currentUser!,
                                ),
                              ),
                            ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TreatmentCard extends StatefulWidget {
  final String title, image;
  final VoidCallback onTap;

  const TreatmentCard(
      {super.key,
      required this.title,
      required this.image,
      required this.onTap});

  @override
  State<TreatmentCard> createState() => _TreatmentCardState();
}

class _TreatmentCardState extends State<TreatmentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse().then((_) => widget.onTap()),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFFFFF), Color(0xFFF1F5F9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.image, height: isMobile ? 50 : 70),
                SizedBox(height: isMobile ? 8 : 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 12 : 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class QuizPage extends StatefulWidget {
  final String treatment;
  final User user;

  const QuizPage({super.key, required this.treatment, required this.user});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final _controllers = <TextEditingController>[
    for (int i = 0; i < 5; i++) TextEditingController()
  ];
  final Map<int, String> _userAnswers = {};

  static const quizData = {
    "Hair Loss": HairLossQuiz.questions,
    "Erectile Dysfunction": ErectileDysfunctionQuiz.questions,
    "Testosterone Booster": TestosteroneBoosterQuiz.questions,
    "Weight Loss": WeightLossQuiz.questions,
    "Premature Ejaculation": PrematureEjaculationQuiz.questions,
  };

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();
  }

  bool _validateAge() {
    if (_controllers.length < 3) return false;
    final day = int.tryParse(_controllers[0].text);
    final month = int.tryParse(_controllers[1].text);
    final year = int.tryParse(_controllers[2].text);
    if (day == null || month == null || year == null) return false;
    final birthDate = DateTime(year, month, day);
    final today = DateTime.now();
    final age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      return age - 1 >= 18;
    }
    return age >= 18;
  }

  void _nextQuestion([String? selectedAnswer]) async {
    final questions = quizData[widget.treatment]!;
    final current = questions[currentIndex];

    if (selectedAnswer != null) {
      _userAnswers[currentIndex] = selectedAnswer;
    }

    if (current['type'] == 'date_input' && !_validateAge()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('You are not eligible. Must be 18 or older.'),
              backgroundColor: Colors.red),
        );
      }
      return;
    }

    if (currentIndex < questions.length - 1) {
      await _fadeController.reverse();
      setState(() => currentIndex++);
      _fadeController.forward();
    } else {
      _showEmailPasswordDialog();
    }
  }

  void _showEmailPasswordDialog() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Complete Your Profile',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: const Color(0xFF1E3A8A)),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width < 600 ? 300 : 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please provide your contact email and preferred password for your profile.',
                style:
                    GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Contact Email',
                  hintText: 'your-email@example.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF1E3A8A)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Preferred Password',
                  hintText: 'For your profile records',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF1E3A8A)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.trim().isEmpty ||
                  passwordController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
                return;
              }
              Navigator.pop(context);
              await _saveCompleteUserProfile(
                contactEmail: emailController.text.trim(),
                preferredPassword: passwordController.text.trim(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Save Results',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _saveCompleteUserProfile(
      {required String contactEmail, required String preferredPassword}) async {
    try {
      final questions = quizData[widget.treatment]!;
      final answers = <String, dynamic>{};

      for (int i = 0; i < questions.length; i++) {
        if (_userAnswers.containsKey(i)) {
          answers['question_${i + 1}'] = {
            'questionNumber': i + 1,
            'questionText': questions[i]['question'],
            'selectedAnswer': _userAnswers[i],
            'questionType': questions[i]['type'] ?? 'multiple_choice',
          };
        }
      }

      final userProfile = {
        'uid': widget.user.uid,
        'googleEmail': widget.user.email,
        'googleDisplayName': widget.user.displayName,
        'contactEmail': contactEmail,
        'preferredPassword': preferredPassword,
        'firstName': _controllers[3].text.trim(),
        'lastName': _controllers[4].text.trim(),
        'dateOfBirth':
            '${_controllers[0].text}/${_controllers[1].text}/${_controllers[2].text}',
        'treatment': widget.treatment,
        'totalQuestions': questions.length,
        'answersCount': answers.length,
        'allAnswers': answers,
        'createdAt': FieldValue.serverTimestamp(),
        'completedAt': FieldValue.serverTimestamp(),
        'deviceInfo': 'Web',
        'appVersion': '1.0.0',
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .set(userProfile, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "✅ Quiz completed! Your ${widget.treatment} profile saved successfully."),
            backgroundColor: const Color(0xFF06B6D4),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = quizData[widget.treatment]!;
    final current = questions[currentIndex];
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "PHOENIX",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: const Color(0xFF06B6D4),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                backgroundColor: Colors.grey.shade200,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF06B6D4)),
                minHeight: isMobile ? 6 : 10,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 32),
              Text(
                current['question'],
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E3A8A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Expanded(child: _buildQuestionContent(current)),
              if (currentIndex > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: OutlinedButton(
                    onPressed: () async {
                      await _fadeController.reverse();
                      setState(() => currentIndex--);
                      _fadeController.forward();
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, isMobile ? 48 : 56),
                      side: const BorderSide(color: Color(0xFF06B6D4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Previous",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: const Color(0xFF1E3A8A))),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContent(Map<String, dynamic> question) {
    switch (question['type']) {
      case 'date_input':
        return _buildDateInput();
      case 'name_input':
        return _buildNameInput();
      default:
        return _buildMultipleChoice(question['options']);
    }
  }

  Widget _buildDateInput() {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        if (isMobile)
          // Mobile: Vertical layout
          Column(
            children: [
              TextField(
                controller: _controllers[0],
                keyboardType: TextInputType.number,
                maxLength: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: 'Day (DD)',
                  hintText: '15',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  counterText: '',
                ),
                onChanged: (value) {
                  if (value.length == 2) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controllers[1],
                keyboardType: TextInputType.number,
                maxLength: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: 'Month (MM)',
                  hintText: '03',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  counterText: '',
                ),
                onChanged: (value) {
                  if (value.length == 2) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controllers[2],
                keyboardType: TextInputType.number,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: 'Year (YYYY)',
                  hintText: '1990',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  counterText: '',
                ),
                onChanged: (value) {
                  if (value.length == 4) {
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ],
          )
        else
          // Desktop/Tablet: Horizontal layout
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controllers[0],
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    labelText: 'DD',
                    hintText: '15',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    counterText: '',
                  ),
                  onChanged: (value) {
                    if (value.length == 2) FocusScope.of(context).nextFocus();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _controllers[1],
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    labelText: 'MM',
                    hintText: '03',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    counterText: '',
                  ),
                  onChanged: (value) {
                    if (value.length == 2) FocusScope.of(context).nextFocus();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _controllers[2],
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    labelText: 'YYYY',
                    hintText: '1990',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    counterText: '',
                  ),
                  onChanged: (value) {
                    if (value.length == 4) FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ],
          ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: isMobile ? 52 : 60,
          child: ElevatedButton(
            onPressed: () {
              if (_controllers[0].text.isEmpty ||
                  _controllers[1].text.isEmpty ||
                  _controllers[2].text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill in all date fields'),
                    backgroundColor: Colors.orange,
                  ),
                );
                return;
              }
              _nextQuestion();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Continue',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameInput() {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        TextField(
          controller: _controllers[3],
          decoration: InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controllers[4],
          decoration: InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: isMobile ? 48 : 56,
          child: ElevatedButton(
            onPressed: () => _nextQuestion(),
            child: Text('Continue', style: GoogleFonts.poppins(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleChoice(List<String> options) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(vertical: isMobile ? 4 : 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, isMobile ? 50 : 60),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF1E3A8A),
            side: BorderSide(color: Colors.grey.shade200),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: 16,
            ),
          ),
          onPressed: () => _nextQuestion(options[index]),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  options[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: isMobile ? 14 : 16),
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF06B6D4)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
