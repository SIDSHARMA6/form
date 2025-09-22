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

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const treatments = [
    {'title': 'Erectile Dysfunction', 'image': 'assets/doctor.png'},
    {'title': 'Weight Loss', 'image': 'assets/doctor.png'},
    {'title': 'Hair Loss', 'image': 'assets/doctor.png'},
    {'title': 'Premature Ejaculation', 'image': 'assets/doctor.png'},
    {'title': 'Testosterone Booster', 'image': 'assets/doctor.png'},
  ];

  double _getResponsiveValue(BuildContext context,
      {required double mobile,
      required double tablet,
      required double desktop}) {
    if (ResponsiveBreakpoints.of(context).isMobile) return mobile;
    if (ResponsiveBreakpoints.of(context).isTablet) return tablet;
    return desktop;
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.all(
            _getResponsiveValue(context, mobile: 16, tablet: 24, desktop: 32)),
        child: Column(
          children: [
            Text(
              "What treatment are you looking for?",
              style: GoogleFonts.poppins(
                fontSize: _getResponsiveValue(context,
                    mobile: 20, tablet: 24, desktop: 28),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E3A8A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ResponsiveGridView.builder(
                gridDelegate: ResponsiveGridDelegate(
                  crossAxisExtent: _getResponsiveValue(context,
                      mobile: 160, tablet: 200, desktop: 240),
                  mainAxisSpacing: _getResponsiveValue(context,
                      mobile: 12, tablet: 16, desktop: 20),
                  crossAxisSpacing: _getResponsiveValue(context,
                      mobile: 12, tablet: 16, desktop: 20),
                ),
                itemCount: treatments.length,
                itemBuilder: (context, index) {
                  final treatment = treatments[index];
                  return TreatmentCard(
                    title: treatment['title']!,
                    image: treatment['image']!,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              QuizPage(treatment: treatment['title']!)),
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

  double _getResponsiveValue(
      {required double mobile,
      required double tablet,
      required double desktop}) {
    if (ResponsiveBreakpoints.of(context).isMobile) return mobile;
    if (ResponsiveBreakpoints.of(context).isTablet) return tablet;
    return desktop;
  }

  @override
  Widget build(BuildContext context) {
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
                Image.asset(
                  widget.image,
                  height:
                      _getResponsiveValue(mobile: 50, tablet: 70, desktop: 80),
                ),
                SizedBox(
                    height: _getResponsiveValue(
                        mobile: 8, tablet: 12, desktop: 16)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: _getResponsiveValue(
                          mobile: 12, tablet: 14, desktop: 16),
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

  const QuizPage({super.key, required this.treatment});

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

  double _getResponsiveValue(
      {required double mobile,
      required double tablet,
      required double desktop}) {
    if (ResponsiveBreakpoints.of(context).isMobile) return mobile;
    if (ResponsiveBreakpoints.of(context).isTablet) return tablet;
    return desktop;
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
          width: _getResponsiveValue(mobile: 300, tablet: 350, desktop: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please provide your email and create a password to save your ${widget.treatment} quiz results.',
                style:
                    GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
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
                  labelText: 'Create Password',
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
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
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
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

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
        'uid': credential.user!.uid,
        'email': email,
        'firstName': _controllers[3].text.trim(),
        'lastName': _controllers[4].text.trim(),
        'fullName':
            '${_controllers[3].text.trim()} ${_controllers[4].text.trim()}',
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

      // Save to users collection for easy viewing in Firebase Console
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set(userProfile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "✅ Quiz completed! Your ${widget.treatment} profile saved to Firebase Console."),
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
          padding: EdgeInsets.all(
              _getResponsiveValue(mobile: 16, tablet: 24, desktop: 32)),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                backgroundColor: Colors.grey.shade200,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF06B6D4)),
                minHeight:
                    _getResponsiveValue(mobile: 6, tablet: 8, desktop: 10),
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 32),
              Text(
                current['question'],
                style: GoogleFonts.poppins(
                  fontSize:
                      _getResponsiveValue(mobile: 18, tablet: 20, desktop: 22),
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
                      minimumSize: Size(
                          double.infinity,
                          _getResponsiveValue(
                              mobile: 48, tablet: 52, desktop: 56)),
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
    return Column(
      children: [
        ResponsiveRowColumn(
          layout: ResponsiveBreakpoints.of(context).isMobile
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            for (int i = 0; i < 3; i++)
              ResponsiveRowColumnItem(
                child: Padding(
                  padding: EdgeInsets.all(
                      _getResponsiveValue(mobile: 4, tablet: 6, desktop: 8)),
                  child: TextField(
                    controller: _controllers[i],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: ['DD', 'MM', 'YYYY'][i],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: _getResponsiveValue(mobile: 48, tablet: 52, desktop: 56),
          child: ElevatedButton(
            onPressed: () => _nextQuestion(),
            child: Text('Continue', style: GoogleFonts.poppins(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildNameInput() {
    return Column(
      children: [
        for (int i = 3; i < 5; i++) ...[
          TextField(
            controller: _controllers[i],
            decoration: InputDecoration(
              labelText: ['First Name', 'Last Name'][i - 3],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          if (i == 3) const SizedBox(height: 16),
        ],
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: _getResponsiveValue(mobile: 48, tablet: 52, desktop: 56),
          child: ElevatedButton(
            onPressed: () => _nextQuestion(),
            child: Text('Continue', style: GoogleFonts.poppins(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleChoice(List<String> options) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(
            vertical: _getResponsiveValue(mobile: 4, tablet: 6, desktop: 8)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity,
                _getResponsiveValue(mobile: 50, tablet: 55, desktop: 60)),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF1E3A8A),
            side: BorderSide(color: Colors.grey.shade200),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            padding: EdgeInsets.symmetric(
              horizontal:
                  _getResponsiveValue(mobile: 16, tablet: 20, desktop: 24),
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
                  style: GoogleFonts.poppins(
                    fontSize: _getResponsiveValue(
                        mobile: 14, tablet: 15, desktop: 16),
                  ),
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
