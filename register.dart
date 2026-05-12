import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  bool _passwordHidden = true;
  bool _confirmHidden = true;
  bool _agreedToTerms = false;
  bool _showRules = false;

  late AnimationController _fadeController;
  late AnimationController _rulesController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rulesAnimation;

  // Field-level error messages
  String? _firstnameError;
  String? _lastnameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmError;

  // Password strength
  int _passwordStrength = 0;

  static const Color _bg = Color(0xFF0C0A14);
  static const Color _surface = Color(0xFF14111F);
  static const Color _accent = Color(0xFFC084FC);
  static const Color _accentDim = Color(0xFF2D1A4A);
  static const Color _textPrimary = Color(0xFFF0F0F5);
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _error = Color(0xFFFF6B6B);
  static const Color _border = Color(0xFF2A2438);

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _rulesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _rulesAnimation = CurvedAnimation(
      parent: _rulesController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
    password.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _rulesController.dispose();
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  void _updatePasswordStrength() {
    final p = password.text;
    int strength = 0;
    if (p.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(p)) strength++;
    if (RegExp(r'[0-9]').hasMatch(p)) strength++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(p)) strength++;
    setState(() => _passwordStrength = strength);
  }

  Color _strengthColor() {
    switch (_passwordStrength) {
      case 1:
        return const Color(0xFFFF6B6B);
      case 2:
        return const Color(0xFFFBBF24);
      case 3:
        return const Color(0xFF60A5FA);
      case 4:
        return _accent;
      default:
        return _border;
    }
  }

  String _strengthLabel() {
    switch (_passwordStrength) {
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return '';
    }
  }

  bool _validate() {
    final nameRegExp = RegExp(r'^[a-zA-Z]+$');
    final emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    final phoneRegExp = RegExp(r'^\+251\d{9}$');
    bool valid = true;
    setState(() {
      _firstnameError = !nameRegExp.hasMatch(firstname.text)
          ? 'Letters only, no spaces or numbers'
          : null;
      _lastnameError = !nameRegExp.hasMatch(lastname.text)
          ? 'Letters only, no spaces or numbers'
          : null;
      _emailError = !emailRegExp.hasMatch(email.text)
          ? 'Enter a valid email address'
          : null;
      _phoneError = !phoneRegExp.hasMatch(phone.text)
          ? 'Must be in format +251XXXXXXXXX'
          : null;
      _passwordError = password.text.length < 8
          ? 'Password must be at least 8 characters'
          : null;
      _confirmError = password.text != confirm.text
          ? 'Passwords do not match'
          : null;
    });
    if (_firstnameError != null ||
        _lastnameError != null ||
        _emailError != null ||
        _phoneError != null ||
        _passwordError != null ||
        _confirmError != null)
      valid = false;
    return valid;
  }

  void _onRegister() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please accept the Terms & Conditions to continue',
          ),
          backgroundColor: _error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }
    if (_validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 10),
              Text('Account created successfully!'),
            ],
          ),
          backgroundColor: const Color(0xFF059669),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: _bg,
              pinned: true,
              expandedHeight: 160,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: _textSecondary,
                  size: 18,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1A0D2E), _bg],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _accentDim,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'NEW ACCOUNT',
                              style: TextStyle(
                                color: _accent,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Create Your\nAccount',
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Personal Info ──────────────────────────
                    _sectionLabel('Personal Information'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: firstname,
                            hint: 'First Name',
                            icon: Icons.person_outline_rounded,
                            error: _firstnameError,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            controller: lastname,
                            hint: 'Last Name',
                            icon: Icons.person_outline_rounded,
                            error: _lastnameError,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: email,
                      hint: 'Email Address',
                      icon: Icons.mail_outline_rounded,
                      keyboard: TextInputType.emailAddress,
                      error: _emailError,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: phone,
                      hint: '+251xxxxxxxxx',
                      icon: Icons.phone_outlined,
                      keyboard: TextInputType.phone,
                      error: _phoneError,
                    ),

                    const SizedBox(height: 24),

                    // ── Security ───────────────────────────────
                    _sectionLabel('Security'),
                    const SizedBox(height: 12),
                    _buildPasswordField(
                      controller: password,
                      hint: 'Password',
                      hidden: _passwordHidden,
                      onToggle: () =>
                          setState(() => _passwordHidden = !_passwordHidden),
                      error: _passwordError,
                    ),
                    if (password.text.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      _buildPasswordStrengthBar(),
                    ],
                    const SizedBox(height: 14),
                    _buildPasswordField(
                      controller: confirm,
                      hint: 'Confirm Password',
                      hidden: _confirmHidden,
                      onToggle: () =>
                          setState(() => _confirmHidden = !_confirmHidden),
                      error: _confirmError,
                    ),

                    const SizedBox(height: 24),

                    // ── Rules & Regulations ────────────────────
                    _buildRulesSection(),

                    const SizedBox(height: 20),

                    // ── Terms checkbox ─────────────────────────
                    _buildTermsCheckbox(),

                    const SizedBox(height: 28),

                    // ── Register button ────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _onRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accent,
                          foregroundColor: const Color(0xFF1A0A2E),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: const TextStyle(
                                color: _accent,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.maybePop(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 14,
          decoration: BoxDecoration(
            color: _accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: error != null ? _error.withOpacity(0.6) : _border,
              width: 1.2,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboard,
            style: const TextStyle(color: _textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 14,
              ),
              prefixIcon: Icon(icon, color: _textSecondary, size: 18),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.error_outline, color: _error, size: 12),
              const SizedBox(width: 4),
              Text(error, style: const TextStyle(color: _error, fontSize: 11)),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool hidden,
    required VoidCallback onToggle,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: error != null ? _error.withOpacity(0.6) : _border,
              width: 1.2,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: hidden,
            style: const TextStyle(color: _textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: _textSecondary,
                size: 18,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  hidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: _textSecondary,
                  size: 18,
                ),
                onPressed: onToggle,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.error_outline, color: _error, size: 12),
              const SizedBox(width: 4),
              Text(error, style: const TextStyle(color: _error, fontSize: 11)),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPasswordStrengthBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
            4,
            (i) => Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: i < _passwordStrength ? _strengthColor() : _border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        if (_passwordStrength > 0) ...[
          const SizedBox(height: 4),
          Text(
            'Strength: ${_strengthLabel()}',
            style: TextStyle(
              color: _strengthColor(),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRulesSection() {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border, width: 1.2),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() => _showRules = !_showRules);
              if (_showRules) {
                _rulesController.forward();
              } else {
                _rulesController.reverse();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _accentDim,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: _accent,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rules & Regulations',
                          style: TextStyle(
                            color: _textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Tap to read before registering',
                          style: TextStyle(color: _textSecondary, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _showRules ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: _textSecondary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Divider(color: _border, height: 1),
                  const SizedBox(height: 14),
                  ..._rules.map(
                    (r) => _buildRuleItem(r['icon']!, r['title']!, r['body']!),
                  ),
                ],
              ),
            ),
            crossFadeState: _showRules
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 350),
          ),
        ],
      ),
    );
  }

  static const List<Map<String, String>> _rules = [
    {
      'icon': '🎂',
      'title': 'Age Requirement',
      'body':
          'You must be at least 18 years old to create an account. By registering, you confirm you meet this requirement.',
    },
    {
      'icon': '📋',
      'title': 'Accurate Information',
      'body':
          'All registration details must be truthful and accurate. Providing false information is grounds for immediate account termination.',
    },
    {
      'icon': '🔒',
      'title': 'Password Security',
      'body':
          'Use a strong, unique password (min. 8 chars with uppercase, number, and symbol). Never share your credentials with anyone.',
    },
    {
      'icon': '🚫',
      'title': 'Prohibited Conduct',
      'body':
          'Accounts may not be used for spam, harassment, illegal activity, or impersonation. Violations will result in permanent suspension.',
    },
    {
      'icon': '🔐',
      'title': 'Data & Privacy',
      'body':
          'Your personal data is collected and stored securely per our Privacy Policy. We do not sell your data to third parties.',
    },
    {
      'icon': '📱',
      'title': 'One Account Policy',
      'body':
          'Each person is allowed one account only. Creating multiple accounts is a violation of our terms and may lead to all accounts being banned.',
    },
  ];

  Widget _buildRuleItem(String emoji, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: _agreedToTerms ? _accent : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _agreedToTerms ? _accent : _border,
                width: 1.5,
              ),
            ),
            child: _agreedToTerms
                ? const Icon(
                    Icons.check_rounded,
                    color: Color(0xFF1A0A2E),
                    size: 14,
                  )
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I have read and agree to the ',
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 13,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    color: _accent,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: _accent,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
