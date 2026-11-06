import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================================
// FEATURE 1: DYNAMIC THEMING & BRAND COLOR PALETTE
// Supports Light & Dark mode seamlessly with a single toggle
// ============================================================================
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

class AppColors {
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color cyan = Color(0xFF0EA5E9);
  static const Color emerald = Color(0xFF10B981);
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color bgDark = Color(0xFF0F172A);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color bubbleLight = Color(0xFFF1F5F9);
  static const Color bubbleDark = Color(0xFF334155);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PulseChat',
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            scaffoldBackgroundColor: AppColors.bgLight,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            cardColor: Colors.white,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: AppColors.bgDark,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.cardDark,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            cardColor: AppColors.cardDark,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

// ============================================================================
// FEATURE 2: MAIN HOME CONTAINER & BOTTOM NAVIGATION
// Manages primary app sections: Chats, Updates, Communities, and Calls
// ============================================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<String> titles = ['PulseChat', 'Updates', 'Communities', 'Calls'];
  final List<Widget> pages = const [
    ChatsPage(),
    UpdatesPage(),
    CommunitiesPage(),
    CallsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            titles[currentIndex],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            // FEATURE: Light / Dark Mode Quick Toggle
            IconButton(
              icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
              tooltip: 'Toggle Light/Dark Theme',
              onPressed: () {
                themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
              },
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Camera Selected')),
              ),
            ),
            // FEATURE: Contact & Chat Search
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: ChatSearchDelegate(),
              ),
            ),
          ],
          // FEATURE 3: CHAT SUB-TAB FILTERING (ALL, UNREAD, FAVORITES)
          bottom: currentIndex == 0
              ? const TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Unread'),
                    Tab(text: 'Favorites'),
                  ],
                )
              : null,
        ),
        drawer: const AppDrawer(),
        body: IndexedStack(index: currentIndex, children: pages),
        // FEATURE: NEW CHAT FLOATING ACTION BUTTON
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewChatPage()),
          ),
          icon: const Icon(Icons.chat_bubble_rounded),
          label: const Text('New Chat', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          backgroundColor: isDark ? AppColors.cardDark : Colors.white,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              activeIcon: Icon(Icons.chat_bubble_rounded),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.donut_large_outlined),
              activeIcon: Icon(Icons.donut_large_rounded),
              label: 'Updates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              activeIcon: Icon(Icons.groups_rounded),
              label: 'Communities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_outlined),
              activeIcon: Icon(Icons.phone_rounded),
              label: 'Calls',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// DATA MODEL & SAMPLE DATA
// ============================================================================
class ChatUser {
  final String name;
  final String message;
  final String time;
  final String initials;
  final Color color;
  final int unread;
  final bool favorite;

  const ChatUser({
    required this.name,
    required this.message,
    required this.time,
    required this.initials,
    required this.color,
    this.unread = 0,
    this.favorite = false,
  });
}

const List<ChatUser> chatUsers = [
  ChatUser(
    name: 'Ali Ahmed',
    message: 'Hey! How are you doing today?',
    time: '2:30 PM',
    initials: 'AA',
    color: Color(0xFF3B82F6),
    unread: 2,
    favorite: true,
  ),
  ChatUser(
    name: 'Usman Afzal',
    message: 'Project status looks awesome!',
    time: '1:45 PM',
    initials: 'UA',
    color: Color(0xFFF97316),
    unread: 1,
    favorite: true,
  ),
  ChatUser(
    name: 'Hamza Khan',
    message: 'Send me the assignment files.',
    time: '12:20 PM',
    initials: 'HK',
    color: Color(0xFFA855F7),
  ),
  ChatUser(
    name: 'Ahmed Raza',
    message: 'Thank you so much!',
    time: '11:10 AM',
    initials: 'AR',
    color: Color(0xFF14B8A6),
  ),
  ChatUser(
    name: 'University Group',
    message: 'Tomorrow is our project presentation.',
    time: 'Yesterday',
    initials: 'UG',
    color: Color(0xFF10B981),
    unread: 3,
  ),
  ChatUser(
    name: 'Bilal Hassan',
    message: 'Call me when you are free.',
    time: 'Yesterday',
    initials: 'BH',
    color: Color(0xFFEF4444),
  ),
];

// ============================================================================
// REUSABLE EASY HELPER WIDGET (SHORT & CLEAN CODE)
// ============================================================================
class AppCardTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AppCardTile({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: leading,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

// ============================================================================
// FEATURE 3: CHATS PAGE WITH TAB FILTERING
// Filter lists into: All, Unread, and Favorites
// ============================================================================
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _buildList(context, chatUsers),
        _buildList(context, chatUsers.where((u) => u.unread > 0).toList()),
        _buildList(context, chatUsers.where((u) => u.favorite).toList()),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<ChatUser> users) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // FEATURE 4: ARCHIVED CHATS
        AppCardTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.archive_rounded, color: AppColors.primary, size: 20),
          ),
          title: 'Archived Chats',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('0', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
          onTap: () {},
        ),
        ...users.map(
          (user) => AppCardTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: user.color,
                  child: Text(
                    user.initials,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.emerald,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            title: user.name,
            subtitle: Text(user.message, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  user.time,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: user.unread > 0 ? FontWeight.bold : FontWeight.normal,
                    color: user.unread > 0 ? AppColors.primary : Colors.grey,
                  ),
                ),
                if (user.unread > 0) ...[
                  const SizedBox(height: 4),
                  CircleAvatar(
                    radius: 9,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      '${user.unread}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatScreen(user: user)),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// FEATURE 5: CHAT CONVERSATION SCREEN & REAL-TIME MESSAGING
// Allows viewing active conversation & sending new text messages
// ============================================================================
class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [
    'Hi! How are you doing today?',
    'I am doing great! Working on the app.',
    'That sounds fantastic!',
  ];

  // FEATURE: Send message state handler
  void sendMessage() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      setState(() => messages.add(text));
      controller.clear();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Hero(
              tag: widget.user.name,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: widget.user.color,
                child: Text(
                  widget.user.initials,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Online', style: TextStyle(fontSize: 11, color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final isMe = index % 2 != 0;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: isMe
                          ? AppColors.primary
                          : (isDark ? AppColors.bubbleDark : AppColors.bubbleLight),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: isMe ? Colors.white : (isDark ? Colors.white : Colors.black87),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // FEATURE: Message Input Control
          Container(
            padding: const EdgeInsets.all(12),
            color: isDark ? AppColors.cardDark : Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  const Icon(Icons.sentiment_satisfied_alt_rounded, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppColors.primary),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// FEATURE 6: UPDATES & STATUS STORIES PAGE
// View personal status and contact story updates
// ============================================================================
class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Status Updates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        AppCardTile(
          leading: const CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: 'My Status',
          subtitle: const Text('Tap to add status update'),
          trailing: const Icon(Icons.add_circle, color: AppColors.emerald),
        ),
        const SizedBox(height: 12),
        const Text('Recent Updates', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _statusTile('Ali Ahmed', Colors.blue, '12 mins ago'),
        _statusTile('Usman Afzal', Colors.orange, '45 mins ago'),
        _statusTile('Hamza Khan', Colors.purple, 'Today, 10:15 AM'),
      ],
    );
  }

  Widget _statusTile(String name, Color color, String time) {
    return AppCardTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: const Icon(Icons.person, color: Colors.white),
      ),
      title: name,
      subtitle: Text(time),
    );
  }
}

// ============================================================================
// FEATURE 7: COMMUNITIES PAGE
// Manage group hubs & community spaces
// ============================================================================
class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        AppCardTile(
          leading: Icon(Icons.groups_rounded, color: AppColors.primary, size: 30),
          title: 'New Community',
          subtitle: Text('Connect your group discussions'),
        ),
        SizedBox(height: 12),
        Text('Your Communities', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        AppCardTile(
          leading: CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.school, color: Colors.white)),
          title: 'University Community',
          subtitle: Text('Announcements and discussions'),
        ),
        AppCardTile(
          leading: CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.work, color: Colors.white)),
          title: 'Project Team',
          subtitle: Text('Team task coordination'),
        ),
      ],
    );
  }
}

// ============================================================================
// FEATURE 8: CALL LOGS & CALL LINK GENERATOR
// Manage voice & video call history
// ============================================================================
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const AppCardTile(
          leading: Icon(Icons.link_rounded, color: AppColors.primary, size: 30),
          title: 'Create Call Link',
          subtitle: Text('Share a link for your PulseChat call'),
        ),
        const SizedBox(height: 12),
        const Text('Recent Calls', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _callTile('Ali Ahmed', Colors.blue, Icons.call_received_rounded, 'Today, 10:30 AM'),
        _callTile('Usman Afzal', Colors.orange, Icons.call_made_rounded, 'Today, 9:15 AM'),
        _callTile('Hamza Khan', Colors.purple, Icons.call_missed_rounded, 'Yesterday, 5:40 PM'),
      ],
    );
  }

  Widget _callTile(String name, Color color, IconData icon, String time) {
    final isMissed = icon == Icons.call_missed_rounded;
    return AppCardTile(
      leading: CircleAvatar(backgroundColor: color, child: const Icon(Icons.person, color: Colors.white)),
      title: name,
      subtitle: Row(
        children: [
          Icon(icon, size: 14, color: isMissed ? Colors.red : AppColors.emerald),
          const SizedBox(width: 4),
          Text(time),
        ],
      ),
      trailing: const Icon(Icons.phone_rounded, color: AppColors.primary),
    );
  }
}

// ============================================================================
// FEATURE 9: NAVIGATION DRAWER
// Access profile, settings, and dark mode toggle switch
// ============================================================================
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _nav(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            accountName: Text('PulseChat User', style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text('user@pulsechat.io'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_rounded, size: 40, color: AppColors.primary),
            ),
          ),
          // FEATURE 10: PROFILE VIEW LINK
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: const Text('Profile'),
            onTap: () => _nav(context, const ProfilePage()),
          ),
          ListTile(
            leading: const Icon(Icons.star_outline_rounded),
            title: const Text('Starred Messages'),
            onTap: () => _nav(context, const SimplePage(title: 'Starred Messages')),
          ),
          ListTile(
            leading: const Icon(Icons.devices_rounded),
            title: const Text('Linked Devices'),
            onTap: () => _nav(context, const SimplePage(title: 'Linked Devices')),
          ),
          // FEATURE: Theme Switcher in Drawer
          SwitchListTile(
            secondary: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: (val) => themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => _nav(context, const SimplePage(title: 'Settings')),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline_rounded),
            title: const Text('Help'),
            onTap: () => _nav(context, const SimplePage(title: 'Help')),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
            onTap: () => _nav(context, const SimplePage(title: 'About')),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// FEATURE 10: PROFILE PAGE WITH HERO ANIMATION
// Displays user info and profile avatar
// ============================================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Hero(
                tag: 'profile-image',
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              const Text('PulseChat User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('Available', style: TextStyle(color: AppColors.emerald, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// FEATURE 11: NEW CHAT / CONTACT SELECTOR
// Browse available contacts to initiate a new message
// ============================================================================
class NewChatPage extends StatelessWidget {
  const NewChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Contact')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: chatUsers
            .map(
              (user) => AppCardTile(
                leading: CircleAvatar(
                  backgroundColor: user.color,
                  child: Text(user.initials, style: const TextStyle(color: Colors.white)),
                ),
                title: user.name,
                subtitle: const Text('Available'),
                trailing: const Icon(Icons.message_outlined, color: AppColors.primary),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChatScreen(user: user)),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ============================================================================
// FEATURE 12: IN-APP SEARCH DELEGATE
// Real-time search filtering across existing chat contacts
// ============================================================================
class ChatSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));
  }

  @override
  Widget buildResults(BuildContext context) => _searchList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _searchList(context);

  Widget _searchList(BuildContext context) {
    final results = chatUsers.where(
      (u) => u.name.toLowerCase().contains(query.toLowerCase()),
    );
    return ListView(
      padding: const EdgeInsets.all(12),
      children: results
          .map(
            (u) => AppCardTile(
              leading: CircleAvatar(backgroundColor: u.color, child: Text(u.initials, style: const TextStyle(color: Colors.white))),
              title: u.name,
              subtitle: Text(u.message),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen(user: u)),
              ),
            ),
          )
          .toList(),
    );
  }
}

// ============================================================================
// FEATURE 13: REUSABLE SIMPLE PLACEHOLDER PAGE
// ============================================================================
class SimplePage extends StatelessWidget {
  final String title;
  const SimplePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$title Page', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
