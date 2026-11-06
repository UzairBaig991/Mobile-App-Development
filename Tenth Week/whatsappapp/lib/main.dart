
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color whatsappGreen = Color(0xFF075E54);
const Color lightGreen = Color(0xFF25D366);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: whatsappGreen,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// HOME SCREEN

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<String> titles = [
    'WhatsApp',
    'Updates',
    'Communities',
    'Calls',
  ];

  final List<Widget> pages = const [
    ChatsPage(),
    UpdatesPage(),
    CommunitiesPage(),
    CallsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whatsappGreen,
          foregroundColor: Colors.white,
          title: Text(
            titles[currentIndex],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Camera selected')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ChatSearchDelegate(),
                );
              },
            ),
          ],
          bottom: currentIndex == 0
              ? const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Unread'),
              Tab(text: 'Favorites'),
            ],
          )
              : null,
        ),

        drawer: const AppDrawer(),

        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: lightGreen,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewChatPage(),
              ),
            );
          },
          child: const Icon(Icons.message),
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: whatsappGreen,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.circle_outlined),
              label: 'Updates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Communities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Calls',
            ),
          ],
        ),
      ),
    );
  }
}

// SAMPLE CHAT DATA

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
    message: 'Hey! How are you?',
    time: '2:30 PM',
    initials: 'AA',
    color: Colors.blue,
    unread: 2,
    favorite: true,
  ),
  ChatUser(
    name: 'Usman Afzal',
    message: 'Project complete?',
    time: '1:45 PM',
    initials: 'UA',
    color: Colors.orange,
    unread: 1,
    favorite: true,
  ),
  ChatUser(
    name: 'Hamza Khan',
    message: 'Send me the assignment.',
    time: '12:20 PM',
    initials: 'HK',
    color: Colors.purple,
  ),
  ChatUser(
    name: 'Ahmed Raza',
    message: 'Thank you!',
    time: '11:10 AM',
    initials: 'AR',
    color: Colors.teal,
  ),
  ChatUser(
    name: 'University Group',
    message: 'Tomorrow is our presentation.',
    time: 'Yesterday',
    initials: 'UG',
    color: Colors.green,
    unread: 3,
  ),
  ChatUser(
    name: 'Bilal Hassan',
    message: 'Call me when free.',
    time: 'Yesterday',
    initials: 'BH',
    color: Colors.red,
  ),
];

// CHATS SCREEN WITH TABS

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        buildChatList(context, chatUsers),
        buildChatList(
          context,
          chatUsers.where((user) => user.unread > 0).toList(),
        ),
        buildChatList(
          context,
          chatUsers.where((user) => user.favorite).toList(),
        ),
      ],
    );
  }

  Widget buildChatList(
      BuildContext context,
      List<ChatUser> users,
      ) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: whatsappGreen,
            child: Icon(Icons.archive, color: Colors.white),
          ),
          title: const Text('Archived'),
          onTap: () {},
        ),
        ...users.map(
              (user) => ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            leading: CircleAvatar(
              radius: 27,
              backgroundColor: user.color,
              child: Text(
                user.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              user.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: user.unread > 0
                        ? lightGreen
                        : Colors.grey,
                  ),
                ),
                if (user.unread > 0)
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: lightGreen,
                    child: Text(
                      '${user.unread}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(user: user),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// CHAT CONVERSATION SCREEN

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController =
  TextEditingController();

  final List<String> messages = [
    'Hi! How are you?',
    'I am fine. What about you?',
    'I am good, thank you!',
  ];

  void sendMessage() {
    String message = messageController.text.trim();

    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
      });

      messageController.clear();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whatsappGreen,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            Hero(
              tag: widget.user.name,
              child: CircleAvatar(
                backgroundColor: widget.user.color,
                child: Text(
                  widget.user.initials,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.user.name,
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      body: Container(
        color: const Color(0xFFECE5DD),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(
                        maxWidth: 280,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCF8C6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        messages[index],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: whatsappGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// UPDATES SCREEN

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Status',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: const CircleAvatar(
            radius: 28,
            backgroundColor: whatsappGreen,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: const Text('My Status'),
          subtitle: const Text('Tap to add status update'),
          trailing: IconButton(
            icon: const Icon(Icons.add_circle, color: lightGreen),
            onPressed: () {},
          ),
        ),
        const Divider(),
        const Text(
          'Recent Updates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        statusTile('Ali Ahmed', Colors.blue),
        statusTile('Usman Afzal', Colors.orange),
        statusTile('Hamza Khan', Colors.purple),
        statusTile('Bilal Hassan', Colors.red),
      ],
    );
  }

  Widget statusTile(String name, Color color) {
    return ListTile(
      leading: CircleAvatar(
        radius: 27,
        backgroundColor: color,
        child: const Icon(Icons.person, color: Colors.white),
      ),
      title: Text(name),
      subtitle: const Text('Today, 12:30 PM'),
      onTap: () {},
    );
  }
}

// COMMUNITIES SCREEN

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 28,
            backgroundColor: whatsappGreen,
            child: Icon(Icons.groups, color: Colors.white),
          ),
          title: const Text(
            'New Community',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Create a new community'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.school, color: Colors.white),
          ),
          title: const Text('University Community'),
          subtitle: const Text('Announcements and discussions'),
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.work, color: Colors.white),
          ),
          title: const Text('Project Team'),
          subtitle: const Text('Team discussions'),
        ),
      ],
    );
  }
}

// CALLS SCREEN

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: whatsappGreen,
            child: Icon(Icons.link, color: Colors.white),
          ),
          title: Text('Create call link'),
          subtitle: Text('Share a link for your WhatsApp call'),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recent',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        callTile('Ali Ahmed', Colors.blue, Icons.call_received),
        callTile('Usman Afzal', Colors.orange, Icons.call_made),
        callTile('Hamza Khan', Colors.purple, Icons.call_missed),
        callTile('Bilal Hassan', Colors.red, Icons.call_received),
      ],
    );
  }

  Widget callTile(String name, Color color, IconData callIcon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: const Icon(Icons.person, color: Colors.white),
      ),
      title: Text(name),
      subtitle: const Text('Today, 10:30 AM'),
      trailing: Icon(
        callIcon,
        color: callIcon == Icons.call_missed
            ? Colors.red
            : whatsappGreen,
      ),
    );
  }
}

// DRAWER NAVIGATION

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: whatsappGreen),
            accountName: Text('WhatsApp User'),
            accountEmail: Text('user@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: whatsappGreen,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => openPage(context, const ProfilePage()),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Starred Messages'),
            onTap: () => openPage(
              context,
              const SimplePage(title: 'Starred Messages'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Linked Devices'),
            onTap: () => openPage(
              context,
              const SimplePage(title: 'Linked Devices'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => openPage(
              context,
              const SimplePage(title: 'Settings'),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () => openPage(
              context,
              const SimplePage(title: 'Help'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () => openPage(
              context,
              const SimplePage(title: 'About'),
            ),
          ),
        ],
      ),
    );
  }
}

// PROFILE SCREEN WITH HERO ANIMATION

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: whatsappGreen,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero(
              tag: 'profile-image',
              child: CircleAvatar(
                radius: 65,
                backgroundColor: whatsappGreen,
                child: Icon(
                  Icons.person,
                  size: 75,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'WhatsApp User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('+92 300 1234567'),
            ),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Available'),
            ),
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

// NEW CHAT SCREEN

class NewChatPage extends StatelessWidget {
  const NewChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact'),
        backgroundColor: whatsappGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ...chatUsers.map(
                (user) => ListTile(
              leading: CircleAvatar(
                backgroundColor: user.color,
                child: Text(
                  user.initials,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(user.name),
              subtitle: const Text('Available'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(user: user),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// SEARCH CHATS

class ChatSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = chatUsers.where(
          (user) => user.name.toLowerCase().contains(query.toLowerCase()),
    );

    return ListView(
      children: results.map((user) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: user.color,
            child: Text(
              user.initials,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(user.name),
          subtitle: Text(user.message),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(user: user),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = chatUsers.where(
          (user) => user.name.toLowerCase().contains(query.toLowerCase()),
    );

    return ListView(
      children: results.map((user) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: user.color,
            child: Text(
              user.initials,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(user.name),
          subtitle: Text(user.message),
          onTap: () {
            query = user.name;
            showResults(context);
          },
        );
      }).toList(),
    );
  }
}

// REUSABLE SIMPLE PAGE

class SimplePage extends StatelessWidget {
  final String title;

  const SimplePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: whatsappGreen,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title Page',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
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
