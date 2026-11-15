import 'package:flutter/material.dart';

const ink = Color(0xFF252447);
const purple = Color(0xFF4F35F5);
const blue = Color(0xFF2868E8);
const lavender = Color(0xFFF2F0FF);
const page = Color(0xFFF7F7FC);
const muted = Color(0xFF777990);

void main() => runApp(const SkillSwapApp());

class SkillSwapApp extends StatefulWidget {
  const SkillSwapApp({super.key});

  @override
  State<SkillSwapApp> createState() => _SkillSwapAppState();
}

class _SkillSwapAppState extends State<SkillSwapApp> {
  final app = DemoState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillSwap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: page,
        colorScheme: ColorScheme.fromSeed(seedColor: purple, primary: purple),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: purple,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7F7FB),
          hintStyle: const TextStyle(color: Color(0xFF9A9AAD), fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFECECF4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: purple, width: 1.4),
          ),
        ),
      ),
      home: LoginPage(app: app),
    );
  }
}

enum SessionStatus { upcoming, completed, cancelled }

enum ExchangeDirection { taught, learned }

class DemoSession {
  DemoSession({
    required this.id,
    required this.partner,
    required this.skill,
    required this.date,
    required this.status,
    required this.direction,
    this.time = '2:00 PM',
    this.place = 'Library study lounge',
  });
  final String id;
  final String partner;
  final String skill;
  final String date;
  final String time;
  final String place;
  SessionStatus status;
  final ExchangeDirection direction;
}

class DemoRequest {
  DemoRequest({
    required this.name,
    required this.skill,
    required this.incoming,
    this.status = 'Pending',
  });
  final String name;
  final String skill;
  final bool incoming;
  String status;
}

class DemoRating {
  DemoRating({
    required this.sessionId,
    required this.partner,
    required this.skill,
    required this.stars,
    required this.review,
    required this.date,
  });
  final String sessionId;
  final String partner;
  final String skill;
  final int stars;
  final String review;
  final String date;
}

class DemoState extends ChangeNotifier {
  String name = 'Maya Kapoor';
  String college = 'Northview College';
  String bio =
      'Curious learner who loves sharing ideas and building new skills.';
  final teachingSkills = <String>['Python', 'UI/UX Design'];
  final learningSkills = <String>['Public Speaking', 'Photography'];
  final sessions = <DemoSession>[
    DemoSession(
      id: 's1',
      partner: 'Isha Patel',
      skill: 'Python basics',
      date: 'Nov 12, 2026',
      status: SessionStatus.completed,
      direction: ExchangeDirection.taught,
      time: '10:30 AM',
    ),
    DemoSession(
      id: 's2',
      partner: 'Ananya Sharma',
      skill: 'Graphic Design',
      date: 'Nov 8, 2026',
      status: SessionStatus.completed,
      direction: ExchangeDirection.learned,
      time: '1:00 PM',
    ),
    DemoSession(
      id: 's3',
      partner: 'Rahul Mehta',
      skill: 'Java fundamentals',
      date: 'Nov 4, 2026',
      status: SessionStatus.completed,
      direction: ExchangeDirection.taught,
      time: '3:30 PM',
    ),
    DemoSession(
      id: 's4',
      partner: 'Rohan Desai',
      skill: 'Photography',
      date: 'Nov 18, 2026',
      status: SessionStatus.upcoming,
      direction: ExchangeDirection.learned,
      time: '2:00 PM',
    ),
    DemoSession(
      id: 's5',
      partner: 'Priya Shah',
      skill: 'Web Development',
      date: 'Nov 20, 2026',
      status: SessionStatus.upcoming,
      direction: ExchangeDirection.taught,
      time: '11:00 AM',
    ),
    DemoSession(
      id: 's6',
      partner: 'Neha Verma',
      skill: 'Public Speaking',
      date: 'Oct 28, 2026',
      status: SessionStatus.cancelled,
      direction: ExchangeDirection.learned,
      time: '4:00 PM',
    ),
  ];
  final requests = <DemoRequest>[
    DemoRequest(name: 'Priya Shah', skill: 'Web Development', incoming: true),
    DemoRequest(name: 'Neha Verma', skill: 'Public Speaking', incoming: true),
    DemoRequest(name: 'Rohan Desai', skill: 'Photography', incoming: false),
  ];
  final ratings = <DemoRating>[
    DemoRating(
      sessionId: 'sample-1',
      partner: 'Ananya Sharma',
      skill: 'Graphic Design',
      stars: 5,
      review: 'A thoughtful and encouraging exchange. I learned so much!',
      date: 'Nov 8',
    ),
    DemoRating(
      sessionId: 'sample-2',
      partner: 'Rahul Mehta',
      skill: 'Java fundamentals',
      stars: 4,
      review: 'Clear explanations and a really helpful session.',
      date: 'Nov 4',
    ),
  ];
  final sentTo = <String>{};

  int get completedCount =>
      sessions.where((s) => s.status == SessionStatus.completed).length;
  int get taughtCount => sessions
      .where(
        (s) =>
            s.status == SessionStatus.completed &&
            s.direction == ExchangeDirection.taught,
      )
      .length;
  int get learnedCount => sessions
      .where(
        (s) =>
            s.status == SessionStatus.completed &&
            s.direction == ExchangeDirection.learned,
      )
      .length;
  double get averageRating => ratings.isEmpty
      ? 0
      : ratings.fold<int>(0, (sum, r) => sum + r.stars) / ratings.length;
  bool isRated(String id) => ratings.any((rating) => rating.sessionId == id);

  void updateProfile({
    required String newName,
    required String newCollege,
    required String newBio,
  }) {
    name = newName.trim();
    college = newCollege.trim();
    bio = newBio.trim();
    notifyListeners();
  }

  void addSkill(String skill, bool teach) {
    final list = teach ? teachingSkills : learningSkills;
    if (skill.trim().isNotEmpty &&
        !list.any((item) => item.toLowerCase() == skill.trim().toLowerCase())) {
      list.add(skill.trim());
      notifyListeners();
    }
  }

  void removeSkill(String skill, bool teach) {
    (teach ? teachingSkills : learningSkills).remove(skill);
    notifyListeners();
  }

  void addRating(DemoRating rating) {
    if (isRated(rating.sessionId)) return;
    ratings.insert(0, rating);
    notifyListeners();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.app});
  final DemoState app;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = GlobalKey<FormState>();
  final email = TextEditingController(text: 'demo@skillswap.edu');
  final password = TextEditingController(text: 'demo123');
  bool hidePassword = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    if (!form.currentState!.validate()) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainShell(app: widget.app)),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
    title: 'Welcome back',
    subtitle: 'Your next skill exchange starts here.',
    children: [
      Form(
        key: form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Good to see you again',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: ink,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Log in to teach, learn and connect.',
              style: TextStyle(color: muted, fontSize: 13),
            ),
            const SizedBox(height: 22),
            const FieldLabel('Email'),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email address',
              ),
              validator: (v) => v == null || !v.contains('@')
                  ? 'Enter a valid email address.'
                  : null,
            ),
            const SizedBox(height: 15),
            const FieldLabel('Password'),
            TextFormField(
              controller: password,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 19,
                  ),
                ),
              ),
              validator: (v) => v == null || v.length < 6
                  ? 'Password must be at least 6 characters.'
                  : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    showMessage(context, 'Demo account password: demo123'),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            PrimaryButton(label: 'Login', onPressed: login),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SignUpPage(app: widget.app),
                  ),
                ),
                child: const Text('New to SkillSwap?  Sign Up'),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const InfoNote(
        icon: Icons.lightbulb_outline,
        title: 'A little knowledge goes a long way.',
        detail: 'Find your people. Share your skills. Grow together.',
      ),
      const SizedBox(height: 10),
      const InfoNote(
        icon: Icons.verified_user_outlined,
        title: 'Demo sign in',
        detail: 'Email: demo@skillswap.edu\nPassword: demo123',
        color: Color(0xFFFFF2F5),
      ),
    ],
  );
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.app});
  final DemoState app;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  bool hide = true;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
    title: 'Join SkillSwap',
    subtitle: 'Learn something new. Share what you know.',
    children: [
      Form(
        key: form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create your account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: ink,
              ),
            ),
            const SizedBox(height: 18),
            const FieldLabel('Full name'),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                hintText: 'Enter your full name',
              ),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Please enter your name.'
                  : null,
            ),
            const SizedBox(height: 12),
            const FieldLabel('Email'),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email address',
              ),
              validator: (v) => v == null || !v.contains('@')
                  ? 'Enter a valid email address.'
                  : null,
            ),
            const SizedBox(height: 12),
            const FieldLabel('Password'),
            TextFormField(
              controller: password,
              obscureText: hide,
              decoration: InputDecoration(
                hintText: 'Create a password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => hide = !hide),
                  icon: const Icon(Icons.visibility_outlined, size: 19),
                ),
              ),
              validator: (v) => v == null || v.length < 8
                  ? 'Use at least 8 characters.'
                  : null,
            ),
            const SizedBox(height: 12),
            const FieldLabel('Confirm password'),
            TextFormField(
              controller: confirm,
              obscureText: hide,
              decoration: const InputDecoration(
                hintText: 'Re-enter your password',
              ),
              validator: (v) =>
                  v != password.text ? 'Passwords do not match.' : null,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Create Account',
              onPressed: () {
                if (!form.currentState!.validate()) return;
                widget.app.updateProfile(
                  newName: name.text,
                  newCollege: widget.app.college,
                  newBio: widget.app.bio,
                );
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('You’re all set!'),
                    content: const Text(
                      'Your SkillSwap demo account has been created. Start sharing your skills!',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Continue to login'),
                      ),
                    ],
                  ),
                );
              },
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already part of SkillSwap?  Login'),
              ),
            ),
          ],
        ),
      ),
      const InfoNote(
        icon: Icons.mark_email_read_outlined,
        title: 'Your skills, your community.',
        detail: 'Create a profile and find a learning partner on campus.',
      ),
    ],
  );
}

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });
  final String title;
  final String subtitle;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        AuthHeader(title: title, subtitle: subtitle),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
            children: [
              CardSurface(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(
      22,
      MediaQuery.paddingOf(context).top + 17,
      22,
      24,
    ),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF6248FF), Color(0xFF4026E9)]),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 25),
            const SizedBox(width: 8),
            const Text(
              'SkillSwap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () =>
                  showMessage(context, 'Learn. Teach. Grow together.'),
              icon: const Icon(Icons.star_outline, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: Color(0xFFE0DCFF)),
        ),
      ],
    ),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.app});
  final DemoState app;
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;
  late final pages = <Widget>[
    MatchesPage(app: widget.app),
    RequestsPage(app: widget.app),
    SessionsPage(app: widget.app),
    SkillsPage(app: widget.app),
    ProfilePage(app: widget.app),
  ];
  static const navItems = [
    (Icons.people_alt_outlined, 'Matches'),
    (Icons.mail_outline, 'Requests'),
    (Icons.calendar_month_outlined, 'Sessions'),
    (Icons.auto_awesome_outlined, 'Skills'),
    (Icons.person_outline, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      top: false,
      child: IndexedStack(index: selected, children: pages),
    ),
    bottomNavigationBar: NavigationBar(
      height: 66,
      selectedIndex: selected,
      onDestinationSelected: (index) => setState(() => selected = index),
      backgroundColor: Colors.white,
      indicatorColor: lavender,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        for (final item in navItems)
          NavigationDestination(
            icon: Icon(item.$1),
            selectedIcon: Icon(item.$1, color: purple),
            label: item.$2,
          ),
      ],
    ),
  );
}

class PageFrame extends StatelessWidget {
  const PageFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
  });
  final String title;
  final String subtitle;
  final Widget child;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      AppHeader(title: title, subtitle: subtitle, trailing: trailing),
      Expanded(child: child),
    ],
  );
}

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
  });
  final String title;
  final String subtitle;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(
      19,
      MediaQuery.paddingOf(context).top + 10,
      15,
      17,
    ),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF6047FF), Color(0xFF462DF0)]),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(21)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.swap_horiz_rounded, size: 21, color: Colors.white),
            const SizedBox(width: 7),
            const Text(
              'SkillSwap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
            const Spacer(),
            trailing ??
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => showMessage(
                    context,
                    'Your next great exchange is just around the corner.',
                  ),
                  icon: const Icon(
                    Icons.star_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
          ],
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            height: 1.2,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Color(0xFFE3DFFF)),
        ),
      ],
    ),
  );
}

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key, required this.app});
  final DemoState app;
  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  bool showTeach = true;
  final students = const [
    Student(
      'Isha Patel',
      'Python',
      'UI/UX Design',
      'Learn Python from the basics, or swap design tips.',
      5,
      Icons.code_rounded,
      Color(0xFF6754E8),
    ),
    Student(
      'Ananya Sharma',
      'Graphic Design',
      'Illustration',
      'Creative designer who loves helping beginners.',
      5,
      Icons.brush_outlined,
      Color(0xFFEF7294),
    ),
    Student(
      'Rahul Mehta',
      'Java',
      'Problem Solving',
      'Let’s make coding concepts easy and fun.',
      4,
      Icons.terminal_rounded,
      Color(0xFF3678D8),
    ),
    Student(
      'Priya Shah',
      'Web Development',
      'HTML & CSS',
      'Build your first responsive website with me.',
      5,
      Icons.web_rounded,
      Color(0xFF18A987),
    ),
    Student(
      'Rohan Desai',
      'Photography',
      'Photo Editing',
      'Learn to see the little details in every frame.',
      5,
      Icons.camera_alt_outlined,
      Color(0xFFE8A341),
    ),
    Student(
      'Neha Verma',
      'Public Speaking',
      'Presentation Skills',
      'Find your voice and speak with confidence.',
      4,
      Icons.mic_none_rounded,
      Color(0xFF8A61D5),
    ),
  ];
  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Find Your Match',
    subtitle: 'Meet students who help you grow.',
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: true, label: Text('Can teach me')),
            ButtonSegment(value: false, label: Text('Wants to learn')),
          ],
          selected: {showTeach},
          showSelectedIcon: false,
          onSelectionChanged: (value) =>
              setState(() => showTeach = value.first),
          style: ButtonStyle(
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) =>
                  states.contains(WidgetState.selected) ? purple : Colors.white,
            ),
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) =>
                  states.contains(WidgetState.selected) ? Colors.white : ink,
            ),
            side: const WidgetStatePropertyAll(
              BorderSide(color: Color(0xFFE8E6F3)),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            ),
          ),
        ),
        const SizedBox(height: 14),
        InfoNote(
          icon: Icons.auto_awesome_outlined,
          title: showTeach
              ? 'Find your learning circle'
              : 'Share what you know',
          detail: showTeach
              ? 'Add learning skills to get matched with students who can teach you.'
              : 'Explore students who would love to learn your skills.',
        ),
        const SizedBox(height: 18),
        const SectionTitle('Student matches'),
        const SizedBox(height: 10),
        for (final student in students)
          MatchCard(
            student: student,
            showTeach: showTeach,
            sent: widget.app.sentTo.contains(student.name),
            onProfile: () => showStudentProfile(context, student),
            onRequest: () {
              setState(() => widget.app.sentTo.add(student.name));
              widget.app.requests.insert(
                0,
                DemoRequest(
                  name: student.name,
                  skill: showTeach ? student.teaches : student.learns,
                  incoming: false,
                ),
              );
              showMessage(context, 'Exchange request sent to ${student.name}.');
            },
          ),
      ],
    ),
  );
}

class Student {
  const Student(
    this.name,
    this.teaches,
    this.learns,
    this.bio,
    this.rating,
    this.icon,
    this.color,
  );
  final String name;
  final String teaches;
  final String learns;
  final String bio;
  final int rating;
  final IconData icon;
  final Color color;
}

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.student,
    required this.showTeach,
    required this.sent,
    required this.onProfile,
    required this.onRequest,
  });
  final Student student;
  final bool showTeach;
  final bool sent;
  final VoidCallback onProfile;
  final VoidCallback onRequest;
  @override
  Widget build(BuildContext context) => CardSurface(
    margin: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Avatar(
              name: student.name,
              color: student.color,
              icon: student.icon,
              radius: 25,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 15,
                        color: Color(0xFFF1B638),
                      ),
                      Text(
                        ' ${student.rating}.0  ·  Student',
                        style: const TextStyle(fontSize: 11, color: muted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Text('CAN TEACH', style: smallCaption),
        const SizedBox(height: 5),
        SkillPill(student.teaches, color: purple),
        const SizedBox(height: 9),
        Text('WANTS TO LEARN', style: smallCaption),
        const SizedBox(height: 5),
        SkillPill(student.learns, color: blue),
        const SizedBox(height: 13),
        Text(
          student.bio,
          style: const TextStyle(fontSize: 12, height: 1.4, color: muted),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onProfile,
                icon: const Icon(Icons.person_outline, size: 16),
                label: const Text(
                  'View Profile',
                  overflow: TextOverflow.ellipsis,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: purple,
                  side: const BorderSide(color: Color(0xFFE3E0FF)),
                  textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton.icon(
                onPressed: sent ? null : onRequest,
                icon: Icon(sent ? Icons.check : Icons.send_outlined, size: 15),
                label: Text(
                  sent ? 'Requested' : 'Send Request',
                  overflow: TextOverflow.ellipsis,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: purple,
                  disabledBackgroundColor: const Color(0xFFE8E6F2),
                  disabledForegroundColor: muted,
                  textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key, required this.app});
  final DemoState app;
  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  bool received = true;
  @override
  Widget build(BuildContext context) {
    final requests = widget.app.requests
        .where((r) => r.incoming == received)
        .toList();
    return PageFrame(
      title: 'Exchange Requests',
      subtitle: 'Start a conversation. Build a connection.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Received')),
              ButtonSegment(value: false, label: Text('Sent')),
            ],
            selected: {received},
            showSelectedIcon: false,
            onSelectionChanged: (v) => setState(() => received = v.first),
            style: ButtonStyle(
              textStyle: const WidgetStatePropertyAll(
                TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? purple
                    : Colors.white,
              ),
              foregroundColor: WidgetStateProperty.resolveWith(
                (states) =>
                    states.contains(WidgetState.selected) ? Colors.white : ink,
              ),
              side: const WidgetStatePropertyAll(
                BorderSide(color: Color(0xFFE8E6F3)),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          InfoNote(
            icon: Icons.inbox_outlined,
            title: requests.isEmpty
                ? 'Your exchanges start here'
                : 'Your exchange requests',
            detail: requests.isEmpty
                ? 'Received and sent requests will appear here when you find a student.'
                : 'A student would like to exchange skills with you.',
          ),
          const SizedBox(height: 18),
          SectionTitle(received ? 'Received requests' : 'Sent requests'),
          const SizedBox(height: 10),
          if (requests.isEmpty)
            EmptyState(
              icon: Icons.mark_email_read_outlined,
              title: 'All caught up!',
              detail:
                  'There are no ${received ? 'received' : 'sent'} requests right now.',
            ),
          for (final request in requests)
            CardSurface(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Avatar(name: request.name, radius: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: ink,
                              ),
                            ),
                            Text(
                              'Skill information: ${request.skill}',
                              style: const TextStyle(
                                color: muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StatusPill(
                        request.status,
                        color: request.status == 'Accepted'
                            ? const Color(0xFF168B64)
                            : request.status == 'Rejected' ||
                                  request.status == 'Cancelled'
                            ? const Color(0xFF9B5363)
                            : blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: lavender,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${request.name.split(' ').first} would like to exchange skills with you.',
                      style: const TextStyle(fontSize: 12, color: ink),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (request.status == 'Pending')
                    Row(
                      children: [
                        if (received) ...[
                          Expanded(
                            child: FilledButton(
                              onPressed: () =>
                                  setState(() => request.status = 'Accepted'),
                              style: FilledButton.styleFrom(
                                backgroundColor: purple,
                              ),
                              child: const Text('Accept'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => request.status = 'Rejected'),
                              child: const Text('Reject'),
                            ),
                          ),
                        ] else
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => request.status = 'Cancelled'),
                              child: const Text('Cancel Request'),
                            ),
                          ),
                      ],
                    )
                  else
                    Text(
                      'Request ${request.status.toLowerCase()}.',
                      style: const TextStyle(color: muted, fontSize: 12),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key, required this.app});
  final DemoState app;
  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  int tab = 0;
  final labels = const ['Upcoming', 'Completed', 'Cancelled'];
  SessionStatus statusFor(int index) => [
    SessionStatus.upcoming,
    SessionStatus.completed,
    SessionStatus.cancelled,
  ][index];
  @override
  Widget build(BuildContext context) {
    final sessions = widget.app.sessions
        .where((s) => s.status == statusFor(tab))
        .toList();
    return PageFrame(
      title: 'My Sessions',
      subtitle: 'Make time to learn, teach and connect.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          SegmentedButton<int>(
            segments: [
              for (var i = 0; i < labels.length; i++)
                ButtonSegment(value: i, label: Text(labels[i])),
            ],
            selected: {tab},
            showSelectedIcon: false,
            onSelectionChanged: (v) => setState(() => tab = v.first),
            style: ButtonStyle(
              textStyle: const WidgetStatePropertyAll(
                TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? purple
                    : Colors.white,
              ),
              foregroundColor: WidgetStateProperty.resolveWith(
                (states) =>
                    states.contains(WidgetState.selected) ? Colors.white : ink,
              ),
              side: const WidgetStatePropertyAll(
                BorderSide(color: Color(0xFFE8E6F3)),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          InfoNote(
            icon: Icons.event_available_outlined,
            title: tab == 0
                ? 'Make your next exchange happen'
                : 'Every exchange is part of your journey',
            detail: tab == 0
                ? 'Your sessions will appear here when you have an exchange scheduled.'
                : 'Find a session in your history, leave feedback and celebrate your progress.',
          ),
          const SizedBox(height: 18),
          SectionTitle('${labels[tab]} sessions'),
          const SizedBox(height: 10),
          if (sessions.isEmpty)
            EmptyState(
              icon: Icons.event_note_outlined,
              title: 'No ${labels[tab].toLowerCase()} sessions yet',
              detail: 'Your skill exchange journey will show up here.',
            ),
          for (final session in sessions)
            SessionCard(
              session: session,
              rated: widget.app.isRated(session.id),
              onComplete: () =>
                  setState(() => session.status = SessionStatus.completed),
              onCancel: () =>
                  setState(() => session.status = SessionStatus.cancelled),
              onRate: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RatingPage(app: widget.app, session: session),
                ),
              ),
            ),
          if (tab == 1)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: OutlinedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PassportPage(app: widget.app),
                  ),
                ),
                icon: const Icon(Icons.workspace_premium_outlined),
                label: const Text('View My Skill Passport'),
              ),
            ),
        ],
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.session,
    required this.rated,
    required this.onComplete,
    required this.onCancel,
    required this.onRate,
  });
  final DemoSession session;
  final bool rated;
  final VoidCallback onComplete;
  final VoidCallback onCancel;
  final VoidCallback onRate;
  @override
  Widget build(BuildContext context) {
    final status = switch (session.status) {
      SessionStatus.upcoming => 'Upcoming',
      SessionStatus.completed => 'Completed',
      SessionStatus.cancelled => 'Cancelled',
    };
    final color = switch (session.status) {
      SessionStatus.upcoming => blue,
      SessionStatus.completed => const Color(0xFF168B64),
      SessionStatus.cancelled => const Color(0xFF9B5363),
    };
    return CardSurface(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(name: session.partner, radius: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.partner,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ink,
                      ),
                    ),
                    Text(
                      session.skill,
                      style: const TextStyle(color: muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              StatusPill(status, color: color),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 15,
            runSpacing: 7,
            children: [
              LabelIcon(
                icon: Icons.calendar_today_outlined,
                text: session.date,
              ),
              LabelIcon(icon: Icons.access_time, text: session.time),
            ],
          ),
          const SizedBox(height: 7),
          LabelIcon(icon: Icons.location_on_outlined, text: session.place),
          const SizedBox(height: 13),
          if (session.status == SessionStatus.upcoming)
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onComplete,
                    style: FilledButton.styleFrom(backgroundColor: purple),
                    child: const Text(
                      'Mark Completed',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    child: const Text(
                      'Cancel Session',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          else if (session.status == SessionStatus.completed)
            SizedBox(
              width: double.infinity,
              child: rated
                  ? OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.check_circle_outline, size: 17),
                      label: const Text('Rating submitted'),
                    )
                  : FilledButton.tonalIcon(
                      onPressed: onRate,
                      icon: const Icon(Icons.star_outline, size: 18),
                      label: const Text('Rate your experience'),
                    ),
            )
          else
            const Text(
              'This session was cancelled.',
              style: TextStyle(color: muted, fontSize: 12),
            ),
        ],
      ),
    );
  }
}

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key, required this.app});
  final DemoState app;
  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  void addSkill(bool teach) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(teach ? 'Add a teaching skill' : 'Add a learning goal'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: teach ? 'e.g. Creative writing' : 'e.g. Data science',
          ),
          onSubmitted: (_) => Navigator.pop(dialogContext),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isEmpty) return;
              final skills = teach
                  ? widget.app.teachingSkills
                  : widget.app.learningSkills;
              if (skills.any(
                (item) => item.toLowerCase() == value.toLowerCase(),
              )) {
                Navigator.pop(dialogContext);
                showMessage(context, 'That skill is already on your list.');
                return;
              }
              widget.app.addSkill(value, teach);
              Navigator.pop(dialogContext);
            },
            child: const Text('Add skill'),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
  }

  Widget skillSection(
    String title,
    String subtitle,
    bool teach,
    IconData icon,
  ) {
    final skills = teach
        ? widget.app.teachingSkills
        : widget.app.learningSkills;
    return CardSurface(
      margin: const EdgeInsets.only(bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: teach ? purple : blue),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ink,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (skills.isEmpty)
            const EmptyState(
              icon: Icons.auto_awesome_outlined,
              title: 'Nothing here yet',
              detail: 'Add a skill to get started.',
            ),
          if (skills.isNotEmpty)
            Wrap(
              spacing: 7,
              runSpacing: 8,
              children: [
                for (final skill in skills)
                  InputChip(
                    label: Text(skill),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => widget.app.removeSkill(skill, teach),
                    backgroundColor: lavender,
                    labelStyle: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    side: BorderSide.none,
                  ),
              ],
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => addSkill(teach),
              icon: const Icon(Icons.add, size: 18),
              label: Text(teach ? 'Add Teaching Skill' : 'Add Learning Skill'),
              style: FilledButton.styleFrom(
                backgroundColor: teach ? purple : blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'My Skills',
    subtitle: 'Share your strengths. Explore your curiosity.',
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        InfoNote(
          icon: Icons.auto_awesome_outlined,
          title: 'Your skills open doors',
          detail: 'Add a skill you can teach and something you are excited to learn.',
        ),
        const SizedBox(height: 16),
        skillSection(
          'Skills I Can Teach',
          'Teach what comes naturally to you.',
          true,
          Icons.menu_book_outlined,
        ),
        skillSection(
          'Skills I Want to Learn',
          'Make room for your next discovery.',
          false,
          Icons.lightbulb_outline,
        ),
        CardSurface(
          child: Row(
            children: [
              const Icon(Icons.insights_outlined, color: purple, size: 25),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  'You have completed ${widget.app.completedCount} skill exchanges so far.',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ink,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PassportPage(app: widget.app),
                  ),
                ),
                child: const Text('Passport'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.app});
  final DemoState app;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final name = TextEditingController(text: widget.app.name);
  late final college = TextEditingController(text: widget.app.college);
  late final bio = TextEditingController(text: widget.app.bio);
  @override
  void dispose() {
    name.dispose();
    college.dispose();
    bio.dispose();
    super.dispose();
  }

  void reset() {
    name.text = widget.app.name;
    college.text = widget.app.college;
    bio.text = widget.app.bio;
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'My Profile',
    subtitle: 'A little about you. A world of possibilities.',
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        CardSurface(
          child: Column(
            children: [
              Avatar(
                name: widget.app.name,
                radius: 30,
                color: Color(0xFF6754E8),
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 8),
              const Text(
                'Make your profile yours',
                style: TextStyle(fontWeight: FontWeight.w800, color: ink),
              ),
              const SizedBox(height: 4),
              const Text(
                'Add a photo and introduce yourself to the SkillSwap community.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: muted),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () =>
                    showMessage(context, 'Your profile avatar is ready!'),
                icon: const Icon(Icons.add_a_photo_outlined, size: 16),
                label: const Text('Add profile photo'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        CardSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Personal details',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: ink,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Only you can edit this profile.',
                style: TextStyle(fontSize: 12, color: muted),
              ),
              const SizedBox(height: 14),
              const FieldLabel('Full name'),
              TextField(
                controller: name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Add your full name',
                ),
              ),
              const SizedBox(height: 12),
              const FieldLabel('College or university'),
              TextField(
                controller: college,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Add your college or university',
                ),
              ),
              const SizedBox(height: 12),
              const FieldLabel('Bio'),
              TextField(
                controller: bio,
                maxLength: 200,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'What do you enjoy learning or teaching?',
                ),
              ),
              SizedBox(
                height: 42,
                child: FilledButton(
                  onPressed: () {
                    if (name.text.trim().isEmpty ||
                        college.text.trim().isEmpty) {
                      showMessage(context, 'Name and college are required.');
                      return;
                    }
                    widget.app.updateProfile(
                      newName: name.text,
                      newCollege: college.text,
                      newBio: bio.text,
                    );
                    FocusScope.of(context).unfocus();
                    showMessage(context, 'Your profile has been saved.');
                  },
                  style: FilledButton.styleFrom(backgroundColor: purple),
                  child: const Text('Save Profile'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 42,
                child: OutlinedButton(
                  onPressed: reset,
                  child: const Text('Cancel changes'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        CardSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.workspace_premium_outlined, color: purple),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Your Skill Passport',
                      style: TextStyle(fontWeight: FontWeight.w800, color: ink),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PassportPage(app: widget.app),
                      ),
                    ),
                    child: const Text('Open'),
                  ),
                ],
              ),
              const Text(
                'Your teaching, learning and student achievements in one place.',
                style: TextStyle(fontSize: 12, color: muted),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  MiniStat(
                    value: '${widget.app.completedCount}',
                    label: 'Completed',
                  ),
                  MiniStat(
                    value: widget.app.averageRating.toStringAsFixed(1),
                    label: 'Avg. rating',
                  ),
                  MiniStat(
                    value: '${widget.app.ratings.length}',
                    label: 'Ratings',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class RatingPage extends StatefulWidget {
  const RatingPage({super.key, required this.app, required this.session});
  final DemoState app;
  final DemoSession session;
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final review = TextEditingController();
  int selected = 0;
  bool submitting = false;
  bool submitted = false;
  static const ratingLabels = [
    'Poor',
    'Fair',
    'Good',
    'Very Good',
    'Excellent',
  ];

  @override
  void dispose() {
    review.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (selected == 0 || submitting || submitted) return;
    setState(() => submitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (!mounted) return;
    widget.app.addRating(
      DemoRating(
        sessionId: widget.session.id,
        partner: widget.session.partner,
        skill: widget.session.skill,
        stars: selected,
        review: review.text.trim(),
        date: 'Today',
      ),
    );
    setState(() {
      submitting = false;
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: PageFrame(
      title: 'Rate Your Experience',
      subtitle: 'Your feedback helps other students build trust and improve their learning experience.',
      trailing: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PassportPage(app: widget.app)),
        ),
        icon: const Icon(Icons.workspace_premium_outlined, color: Colors.white),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 26),
        children: [
          SectionTitle(submitted ? 'Thank you for sharing!' : 'Your session'),
          const SizedBox(height: 9),
          CardSurface(
            child: Row(
              children: [
                Avatar(name: widget.session.partner, radius: 25),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.session.partner,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.session.skill,
                        style: const TextStyle(color: muted, fontSize: 12),
                      ),
                      const SizedBox(height: 7),
                      Wrap(
                        spacing: 11,
                        children: [
                          LabelIcon(
                            icon: Icons.calendar_today_outlined,
                            text: widget.session.date,
                          ),
                          LabelIcon(
                            icon: Icons.access_time,
                            text: widget.session.time,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const StatusPill('Completed', color: Color(0xFF168B64)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          CardSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How was your experience?',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Required · Choose one rating',
                  style: TextStyle(fontSize: 11, color: muted),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5,
                    (i) => Semantics(
                      button: true,
                      label: 'Rate ${i + 1} ${ratingLabels[i]}',
                      child: InkWell(
                        onTap: submitted
                            ? null
                            : () => setState(() => selected = i + 1),
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            i < selected
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 39,
                            color: i < selected
                                ? const Color(0xFFFFB72B)
                                : const Color(0xFFB7B7C7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (selected > 0)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: lavender,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$selected  ·  ${ratingLabels[selected - 1]}',
                        style: const TextStyle(
                          color: purple,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                if (selected == 0)
                  const Center(
                    child: Text(
                      'Select a rating',
                      style: TextStyle(fontSize: 12, color: muted),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          CardSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Write a Review',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Optional · Help another student know what to expect.',
                  style: TextStyle(fontSize: 11, color: muted),
                ),
                const SizedBox(height: 11),
                TextField(
                  controller: review,
                  enabled: !submitted,
                  maxLength: 500,
                  maxLines: 5,
                  minLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Share your experience with this student...',
                    counterText: '',
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${review.text.length}/500 characters',
                    style: const TextStyle(fontSize: 10, color: muted),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (submitted)
            CardSurface(
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF20A477),
                    size: 34,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Rating submitted successfully',
                    style: TextStyle(fontWeight: FontWeight.w800, color: ink),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your $selected-star review is now part of your Skill Passport.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: muted, fontSize: 12),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PassportPage(app: widget.app),
                      ),
                    ),
                    icon: const Icon(Icons.workspace_premium_outlined),
                    label: const Text('View Skill Passport'),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: selected == 0 || submitting ? null : submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: purple,
                      disabledBackgroundColor: const Color(0xFFE4E3EC),
                      disabledForegroundColor: muted,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: submitting
                        ? const SizedBox(
                            width: 19,
                            height: 19,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Submit Rating',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  selected == 0
                      ? 'Select a star rating to continue'
                      : 'Your written review is optional.',
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ),
          const SizedBox(height: 12),
          const InfoNote(
            icon: Icons.shield_outlined,
            title: 'Honest feedback builds a better community.',
            detail:
                'Your review helps SkillSwap students make great connections.',
          ),
        ],
      ),
    ),
  );
}

class PassportPage extends StatelessWidget {
  const PassportPage({super.key, required this.app});
  final DemoState app;
  @override
  Widget build(BuildContext context) {
    final completed =
        app.sessions.where((s) => s.status == SessionStatus.completed).toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    return Scaffold(
      body: PageFrame(
        title: 'My Skill Passport',
        subtitle:
            'Your skills, achievements and learning journey in one place.',
        trailing: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 25),
          children: [
            CardSurface(
              child: Column(
                children: [
                  Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF806CFF), purple],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: purple.withValues(alpha: .2),
                          blurRadius: 16,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        initials(app.name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    app.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.school_outlined,
                        size: 15,
                        color: purple,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          app.college,
                          style: const TextStyle(fontSize: 12, color: muted),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  const StatusPill('SKILLSWAP STUDENT', color: purple),
                  const SizedBox(height: 13),
                  Text(
                    app.bio,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: muted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            CardSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Your exchange impact'),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      Expanded(
                        child: PassportStat(
                          value: '${app.taughtCount}',
                          label: 'Sessions Taught',
                          icon: Icons.menu_book_outlined,
                          color: purple,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: PassportStat(
                          value: '${app.learnedCount}',
                          label: 'Sessions Learned',
                          icon: Icons.school_outlined,
                          color: blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Expanded(
                        child: PassportStat(
                          value: '${app.completedCount}',
                          label: 'Completed Sessions',
                          icon: Icons.check_circle_outline,
                          color: const Color(0xFF15966F),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: PassportStat(
                          value: app.averageRating.toStringAsFixed(1),
                          label: 'Average Rating',
                          icon: Icons.star_rounded,
                          color: const Color(0xFFE9A91E),
                          stars: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.rate_review_outlined,
                        color: purple,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${app.ratings.length} student ratings',
                        style: const TextStyle(
                          color: ink,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${app.ratings.length} total',
                        style: const TextStyle(fontSize: 11, color: muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: app.averageRating == 0 ? 0 : app.averageRating / 5,
                      minHeight: 7,
                      backgroundColor: lavender,
                      color: const Color(0xFFFFB72B),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    app.ratings.isEmpty
                        ? 'No ratings yet. Complete a session and invite a student to leave feedback.'
                        : '${app.averageRating.toStringAsFixed(1)} out of 5.0 based on ${app.ratings.length} ${app.ratings.length == 1 ? 'rating' : 'ratings'}',
                    style: const TextStyle(color: muted, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            skillPassportSection(
              'Skills I Can Teach',
              app.teachingSkills,
              Icons.volunteer_activism_outlined,
              purple,
            ),
            const SizedBox(height: 10),
            skillPassportSection(
              'Skills I Want to Learn',
              app.learningSkills,
              Icons.lightbulb_outline,
              blue,
            ),
            const SizedBox(height: 14),
            CardSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Recent activity'),
                  const SizedBox(height: 4),
                  const Text(
                    'Your latest completed skill exchanges.',
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                  const SizedBox(height: 12),
                  if (completed.isEmpty)
                    const EmptyState(
                      icon: Icons.history,
                      title: 'Your journey starts here',
                      detail:
                          'Complete an exchange to add your first activity.',
                    ),
                  for (final session in completed.take(5))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 11),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color:
                                  session.direction == ExchangeDirection.taught
                                  ? lavender
                                  : const Color(0xFFECF3FF),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Icon(
                              session.direction == ExchangeDirection.taught
                                  ? Icons.menu_book_outlined
                                  : Icons.school_outlined,
                              color:
                                  session.direction == ExchangeDirection.taught
                                  ? purple
                                  : blue,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${session.direction == ExchangeDirection.taught ? 'Taught' : 'Learned'} ${session.skill}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: ink,
                                  ),
                                ),
                                Text(
                                  'with ${session.partner}  ·  ${session.date}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (app.isRated(session.id))
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Color(0xFFFFB72B),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            CardSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Milestones'),
                  const SizedBox(height: 11),
                  Milestone(
                    title: 'First Lesson',
                    detail: 'Complete your first learning session.',
                    unlocked: app.completedCount >= 1,
                    progress: app.completedCount >= 1
                        ? '1 / 1'
                        : '${app.completedCount} / 1',
                    icon: Icons.menu_book_outlined,
                  ),
                  const SizedBox(height: 9),
                  Milestone(
                    title: 'Knowledge Sharer',
                    detail: 'Complete your first teaching session.',
                    unlocked: app.taughtCount >= 1,
                    progress: app.taughtCount >= 1
                        ? '1 / 1'
                        : '${app.taughtCount} / 1',
                    icon: Icons.volunteer_activism_outlined,
                  ),
                  const SizedBox(height: 9),
                  Milestone(
                    title: 'Exchange Champion',
                    detail: 'Complete five skill exchanges.',
                    unlocked: app.completedCount >= 5,
                    progress: '${app.completedCount.clamp(0, 5)} / 5',
                    icon: Icons.workspace_premium_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            if (app.ratings.isNotEmpty)
              CardSurface(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle('Latest student feedback'),
                    const SizedBox(height: 9),
                    for (final rating in app.ratings.take(3))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Avatar(name: rating.partner, radius: 18),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          rating.partner,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: ink,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        rating.date,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        i < rating.stars
                                            ? Icons.star_rounded
                                            : Icons.star_outline_rounded,
                                        size: 13,
                                        color: const Color(0xFFFFB72B),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    rating.review,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      height: 1.35,
                                      color: muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            else
              const EmptyState(
                icon: Icons.rate_review_outlined,
                title: 'No ratings yet',
                detail: 'Ratings from completed sessions will appear here.',
              ),
          ],
        ),
      ),
    );
  }

  Widget skillPassportSection(
    String title,
    List<String> skills,
    IconData icon,
    Color color,
  ) => CardSurface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 19, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800, color: ink),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (skills.isEmpty)
          const Text(
            'No skills added yet. Visit My Skills to add some.',
            style: TextStyle(color: muted, fontSize: 12),
          ),
        if (skills.isNotEmpty)
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              for (final skill in skills) SkillPill(skill, color: color),
            ],
          ),
      ],
    ),
  );
}

class PassportStat extends StatelessWidget {
  const PassportStat({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    this.stars = false,
  });
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final bool stars;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F7FD),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFF0EFF8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (stars)
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                i < double.tryParse(value)!.round()
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: 12,
                color: const Color(0xFFFFB72B),
              ),
            ),
          ),
      ],
    ),
  );
}

class Milestone extends StatelessWidget {
  const Milestone({
    super.key,
    required this.title,
    required this.detail,
    required this.unlocked,
    required this.progress,
    required this.icon,
  });
  final String title;
  final String detail;
  final bool unlocked;
  final String progress;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: unlocked ? const Color(0xFFF1FBF7) : const Color(0xFFF8F8FC),
      borderRadius: BorderRadius.circular(13),
      border: Border.all(
        color: unlocked ? const Color(0xFFD8F1E7) : const Color(0xFFEFEFF5),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: unlocked ? const Color(0xFFDDF5EB) : lavender,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 18,
            color: unlocked ? const Color(0xFF168B64) : purple,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: ink,
                ),
              ),
              Text(detail, style: const TextStyle(fontSize: 10, color: muted)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              unlocked ? Icons.check_circle : Icons.lock_outline,
              color: unlocked ? const Color(0xFF168B64) : muted,
              size: 17,
            ),
            Text(
              unlocked ? 'Earned' : progress,
              style: TextStyle(
                fontSize: 9,
                color: unlocked ? const Color(0xFF168B64) : muted,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class MiniStat extends StatelessWidget {
  const MiniStat({super.key, required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: purple,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: muted, fontSize: 10),
        ),
      ],
    ),
  );
}

class CardSurface extends StatelessWidget {
  const CardSurface({
    super.key,
    required this.child,
    this.margin,
    this.padding = const EdgeInsets.all(14),
  });
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0B282550),
          blurRadius: 15,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.name,
    this.radius = 24,
    this.color = const Color(0xFF6754E8),
    this.icon,
  });
  final String name;
  final double radius;
  final Color color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: radius,
    backgroundColor: color.withValues(alpha: .12),
    child: icon == null
        ? Text(
            initials(name),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: radius * .53,
            ),
          )
        : Icon(icon, color: color, size: radius * .95),
  );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 46,
    child: FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    ),
  );
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
    ),
  );
}

class InfoNote extends StatelessWidget {
  const InfoNote({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
    this.color = const Color(0xFFEFF3FF),
  });
  final IconData icon;
  final String title;
  final String detail;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: purple, size: 19),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: ink,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                detail,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.35,
                  color: muted,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: ink,
    ),
  );
}

class SkillPill extends StatelessWidget {
  const SkillPill(this.text, {super.key, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .09),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color),
    ),
  );
}

class StatusPill extends StatelessWidget {
  const StatusPill(this.text, {super.key, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: color),
    ),
  );
}

class LabelIcon extends StatelessWidget {
  const LabelIcon({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 13, color: muted),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(fontSize: 10, color: muted)),
    ],
  );
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
  });
  final IconData icon;
  final String title;
  final String detail;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    child: Column(
      children: [
        Icon(icon, size: 31, color: const Color(0xFFB2A9F6)),
        const SizedBox(height: 7),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: ink,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: muted),
        ),
      ],
    ),
  );
}

const smallCaption = TextStyle(
  fontSize: 9,
  fontWeight: FontWeight.w800,
  letterSpacing: .5,
  color: muted,
);

String initials(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '?';
  return parts.take(2).map((part) => part[0].toUpperCase()).join();
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
}

void showStudentProfile(BuildContext context, Student student) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
      decoration: const BoxDecoration(
        color: page,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD5D3E1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 18),
            Avatar(
              name: student.name,
              radius: 38,
              color: student.color,
              icon: student.icon,
            ),
            const SizedBox(height: 10),
            Text(
              student.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: ink,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFF1B638),
                  size: 17,
                ),
                Text(
                  ' ${student.rating}.0  ·  SkillSwap student',
                  style: const TextStyle(fontSize: 12, color: muted),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              student.bio,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: muted),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('CAN TEACH', style: smallCaption),
                      const SizedBox(height: 7),
                      SkillPill(student.teaches, color: purple),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('WANTS TO LEARN', style: smallCaption),
                      const SizedBox(height: 7),
                      SkillPill(student.learns, color: blue),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  showMessage(
                    context,
                    'Send an exchange request from Find Your Match.',
                  );
                },
                icon: const Icon(Icons.send_outlined, size: 17),
                label: const Text('Connect with student'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
