import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TravelExplorerApp());
}

// ============================================================================
// 1. DATA MODELS & PAKISTAN DESTINATIONS
// ============================================================================

class Destination {
  final String id;
  final String name;
  final String location;
  final String description;
  final String detailedDescription;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String price; // In PKR (Pakistani Rupees)
  final String category;
  final List<String> highlights;
  bool isFavorite;

  Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.detailedDescription,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    required this.category,
    required this.highlights,
    this.isFavorite = false,
  });
}

class TravelCategory {
  final String title;
  final IconData icon;
  final String spotCount;
  final List<Color> colors;
  final String imageUrl;
  final String caption;

  const TravelCategory({
    required this.title,
    required this.icon,
    required this.spotCount,
    required this.colors,
    required this.imageUrl,
    required this.caption,
  });
}

// All 12 Destinations are exclusively in Pakistan with PKR prices
final List<Destination> pakistanDestinations = [
  Destination(
    id: '1',
    name: 'Islamabad',
    location: 'Capital Territory, Pakistan',
    description: 'Beautiful capital city nestled at the foot of Margalla Hills.',
    detailedDescription:
        'Islamabad is the lush green capital city of Pakistan, renowned for its clean environment, modern architecture, and scenic views. Popular tourist spots include the iconic Faisal Mosque, Daman-e-Koh, Saidpur Historic Village, and Monal Restaurant.',
    imageUrl:
        'https://images.unsplash.com/photo-1627894483216-2138af692e32?w=800&q=80',
    rating: 4.8,
    reviewsCount: 1250,
    price: 'PKR 35,000',
    category: 'Cities',
    highlights: ['Faisal Mosque', 'Margalla Hills', 'Daman-e-Koh', 'Saidpur Village'],
    isFavorite: true,
  ),
  Destination(
    id: '2',
    name: 'Lahore',
    location: 'Punjab, Pakistan',
    description: 'The cultural heart of Pakistan rich in Mughal history and food.',
    detailedDescription:
        'Lahore is Pakistan’s cultural capital, famous for ancient Mughal monuments, bustling bazaars, and world-renowned food streets. Highlights include Badshahi Mosque, Lahore Fort (Shahi Qila), Shalimar Gardens, and Minar-e-Pakistan.',
    imageUrl:
        'https://images.unsplash.com/photo-1588065094250-b0c61993bf2b?w=800&q=80',
    rating: 4.9,
    reviewsCount: 2400,
    price: 'PKR 30,000',
    category: 'Historical Places',
    highlights: ['Badshahi Mosque', 'Lahore Fort', 'Shalimar Gardens', 'Gawalmandi Food Street'],
    isFavorite: false,
  ),
  Destination(
    id: '3',
    name: 'Karachi',
    location: 'Sindh, Pakistan',
    description: 'Bustling coastal metropolis along the Arabian Sea.',
    detailedDescription:
        'Karachi is the largest city and economic center of Pakistan, known for its vibrant beaches, sea view dining, and rich history. Major attractions include Clifton Beach, Mazar-e-Quaid, Do Darya, and Mohatta Palace.',
    imageUrl:
        'https://images.unsplash.com/photo-1623874514711-0f321325f318?w=800&q=80',
    rating: 4.6,
    reviewsCount: 1890,
    price: 'PKR 28,000',
    category: 'Beaches & Coastal',
    highlights: ['Clifton Beach', 'Mazar-e-Quaid', 'Do Darya', 'Mohatta Palace'],
    isFavorite: false,
  ),
  Destination(
    id: '4',
    name: 'Hunza Valley',
    location: 'Gilgit-Baltistan, Pakistan',
    description: 'Paradise on Earth surrounded by majestic snow peaks.',
    detailedDescription:
        'Hunza Valley is one of the most famous mountain destinations in Pakistan. It offers stunning views of Rakaposhi peak, crystal-clear turquoise waters of Attabad Lake, historical Altit and Baltit Forts, and the iconic Passu Cones.',
    imageUrl:
        'https://images.unsplash.com/photo-1609839930810-b98a39e8d75d?w=800&q=80',
    rating: 5.0,
    reviewsCount: 3500,
    price: 'PKR 65,000',
    category: 'Mountains',
    highlights: ['Attabad Lake', 'Baltit Fort', 'Passu Cones', 'Rakaposhi Viewpoint'],
    isFavorite: true,
  ),
  Destination(
    id: '5',
    name: 'Skardu',
    location: 'Gilgit-Baltistan, Pakistan',
    description: 'Gateway to K2 featuring cold deserts and alpine lakes.',
    detailedDescription:
        'Skardu is a breath-taking region in Gilgit-Baltistan. It serves as the gateway to four of the world\'s 14 highest peaks, including K2. Key spots include Shangrila Resort, Katpana Cold Desert, and Deosai National Park.',
    imageUrl:
        'https://images.unsplash.com/photo-1596701062351-8c2c14d1fcd0?w=800&q=80',
    rating: 4.9,
    reviewsCount: 2100,
    price: 'PKR 75,000',
    category: 'Adventure',
    highlights: ['Shangrila Lake', 'Katpana Cold Desert', 'Deosai Plains', 'Kachura Lake'],
    isFavorite: false,
  ),
  Destination(
    id: '6',
    name: 'Swat Valley',
    location: 'Khyber Pakhtunkhwa, Pakistan',
    description: 'The Switzerland of the East with rivers and lush forests.',
    detailedDescription:
        'Swat Valley is celebrated for its alpine meadows, roaring Swat River, and snow-clad mountains. Popular travel spots include Malam Jabba ski resort, Kalam Valley, Ushu Forest, and Mahodand Lake.',
    imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
    rating: 4.8,
    reviewsCount: 1650,
    price: 'PKR 45,000',
    category: 'Lakes & Valleys',
    highlights: ['Malam Jabba Ski Resort', 'Kalam Valley', 'Mahodand Lake', 'Ushu Forest'],
    isFavorite: true,
  ),
  Destination(
    id: '7',
    name: 'Murree & Patriata',
    location: 'Punjab, Pakistan',
    description: 'Popular hill station famous for pine forests and cable cars.',
    detailedDescription:
        'Murree is Pakistan\'s most visited hill station, beloved for its pleasant cool weather, Mall Road shopping, pine-covered hills, and the Patriata (New Murree) chairlift and cable car rides.',
    imageUrl:
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&q=80',
    rating: 4.5,
    reviewsCount: 2900,
    price: 'PKR 25,000',
    category: 'Mountains',
    highlights: ['Mall Road', 'Patriata Chairlift', 'Bhurban', 'Changla Gali'],
    isFavorite: false,
  ),
  Destination(
    id: '8',
    name: 'Fairy Meadows',
    location: 'Gilgit-Baltistan, Pakistan',
    description: 'Enchanting grassland at the base of Nanga Parbat mountain.',
    detailedDescription:
        'Fairy Meadows is a magical alpine meadow offering up-close views of Nanga Parbat (8,126m), the Killer Mountain. It is an unforgettable destination for trekkers, campers, and nature enthusiasts.',
    imageUrl:
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80',
    rating: 4.9,
    reviewsCount: 1420,
    price: 'PKR 70,000',
    category: 'Adventure',
    highlights: ['Nanga Parbat View', 'Trekking Trail', 'Camping Sites', 'Beyal Camp'],
    isFavorite: false,
  ),
  Destination(
    id: '9',
    name: 'Naran Kaghan Valley',
    location: 'Khyber Pakhtunkhwa, Pakistan',
    description: 'Picturesque valley home to Saif-ul-Malook Lake.',
    detailedDescription:
        'Naran and Kaghan are famous valley destinations featuring the legendary Lake Saif-ul-Malook, Babusar Top (4,173m), Lulusar Lake, and river rafting in the Kunhar River.',
    imageUrl:
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800&q=80',
    rating: 4.8,
    reviewsCount: 3100,
    price: 'PKR 40,000',
    category: 'Lakes & Valleys',
    highlights: ['Lake Saif-ul-Malook', 'Babusar Top', 'Lulusar Lake', 'Kunhar River'],
    isFavorite: true,
  ),
  Destination(
    id: '10',
    name: 'Gwadar',
    location: 'Balochistan, Pakistan',
    description: 'Deep-sea port city with pristine beaches and dramatic cliffs.',
    detailedDescription:
        'Gwadar is a fast-developing coastal city located in Balochistan along the Arabian Sea. It features stunning places like Hammerhead rock, Gwadar Mini Port, Marine Drive, and Kund Malir beach along the coastal highway.',
    imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
    rating: 4.7,
    reviewsCount: 980,
    price: 'PKR 55,000',
    category: 'Beaches & Coastal',
    highlights: ['Marine Drive', 'Hammerhead Cliff', 'Kund Malir Beach', 'Gwadar Port'],
    isFavorite: false,
  ),
  Destination(
    id: '11',
    name: 'Multan',
    location: 'Punjab, Pakistan',
    description: 'The historic City of Saints, famous for shrines and blue pottery.',
    detailedDescription:
        'Multan is one of the oldest inhabited cities in the Asian subcontinent. Known as the City of Saints, it is famous for magnificent Sufi shrines (Shah Rukn-e-Alam), blue pottery art, and delicious Multani halwa.',
    imageUrl:
        'https://images.unsplash.com/photo-1548013146-72479768bada?w=800&q=80',
    rating: 4.6,
    reviewsCount: 1150,
    price: 'PKR 22,000',
    category: 'Historical Places',
    highlights: ['Shah Rukn-e-Alam Shrine', 'Bahauddin Zakariya Shrine', 'Multan Fort', 'Blue Pottery'],
    isFavorite: false,
  ),
  Destination(
    id: '12',
    name: 'Peshawar',
    location: 'Khyber Pakhtunkhwa, Pakistan',
    description: 'Historic frontier city known for Qissa Khwani and Chapli Kebab.',
    detailedDescription:
        'Peshawar is one of Pakistan\'s oldest cities, rich in Pashtun culture and hospitality. Famous landmarks include Qissa Khwani Bazaar (Storytellers Market), Bala Hisar Fort, Sethi House, and world-famous Pashtun cuisine.',
    imageUrl:
        'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&q=80',
    rating: 4.7,
    reviewsCount: 1340,
    price: 'PKR 26,000',
    category: 'Historical Places',
    highlights: ['Qissa Khwani Bazaar', 'Bala Hisar Fort', 'Sethi House', 'Chapli Kebab Street'],
    isFavorite: false,
  ),
];

// GridView Categories (Exactly 6 Categories)
final List<TravelCategory> pakistanCategories = const [
  TravelCategory(
    title: 'Mountains',
    icon: Icons.landscape_rounded,
    spotCount: '15+ Spots',
    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
  ),
  TravelCategory(
    title: 'Historical Places',
    icon: Icons.account_balance_rounded,
    spotCount: '20+ Spots',
    colors: [Color(0xFFE65100), Color(0xFFF57C00)],
  ),
  TravelCategory(
    title: 'Lakes & Valleys',
    icon: Icons.water_rounded,
    spotCount: '18+ Spots',
    colors: [Color(0xFF00695C), Color(0xFF00897B)],
  ),
  TravelCategory(
    title: 'Cities',
    icon: Icons.location_city_rounded,
    spotCount: '12+ Spots',
    colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
  ),
  TravelCategory(
    title: 'Beaches & Coastal',
    icon: Icons.beach_access_rounded,
    spotCount: '10+ Spots',
    colors: [Color(0xFF0277BD), Color(0xFF0288D1)],
  ),
  TravelCategory(
    title: 'Adventure',
    icon: Icons.hiking_rounded,
    spotCount: '14+ Spots',
    colors: [Color(0xFFC62828), Color(0xFFE53935)],
  ),
];

// ============================================================================
// 2. MAIN APP & THEME
// ============================================================================

class TravelExplorerApp extends StatelessWidget {
  const TravelExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryNavy = Color(0xFF0D47A1);
    const secondarySky = Color(0xFF0288D1);

    return MaterialApp(
      title: 'Travel Explorer Pakistan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryNavy,
          primary: primaryNavy,
          secondary: secondarySky,
          surface: const Color(0xFFF8FAFC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// Custom Safe Image Helper Widget
class SafeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.blue.shade50,
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF0D47A1),
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF0288D1)],
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.landscape_rounded, color: Colors.white, size: 36),
              SizedBox(height: 4),
              Text('Explore Pakistan', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}

// Reusable Drawer Navigation Menu
class CustomDrawer extends StatelessWidget {
  final String currentRoute;

  const CustomDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF0288D1)],
              ),
            ),
            currentAccountPicture: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                backgroundColor: Color(0xFF0D47A1),
                child: Icon(Icons.flight_takeoff, color: Colors.white, size: 28),
              ),
            ),
            accountName: const Text(
              'Travel Explorer Pakistan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: const Text('Discover Pakistan, One Journey at a Time.'),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded, color: Color(0xFF0D47A1)),
            title: const Text('Home'),
            selected: currentRoute == 'Home',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != 'Home') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.explore_rounded, color: Color(0xFF0D47A1)),
            title: const Text('Explore Destinations'),
            selected: currentRoute == 'Explore',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != 'Explore') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListScreen()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_rounded, color: Color(0xFF0D47A1)),
            title: const Text('About & Categories'),
            selected: currentRoute == 'About',
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != 'About') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ListScreen(showFavoritesOnly: true),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Reusable Bottom Navigation Bar
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ListScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AboutScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      selectedItemColor: const Color(0xFF0D47A1),
      unselectedItemColor: Colors.grey.shade600,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore_rounded),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline_rounded),
          activeIcon: Icon(Icons.info_rounded),
          label: 'About',
        ),
      ],
    );
  }
}

// ============================================================================
// 3. SPLASH SCREEN (ANIMATED)
// ============================================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Auto-navigate to HomeScreen after 3 seconds
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF0288D1), Color(0xFF4FC3F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.flight_takeoff_rounded,
                      size: 60,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Column(
                  children: [
                    Text(
                      'Travel Explorer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Discover Pakistan, One Journey at a Time.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 16),
              const Text('Loading Pakistan Destinations...',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 4. HOME SCREEN (SLIVERAPPBAR & CUSTOMSCROLLVIEW)
// ============================================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featured = pakistanDestinations[3]; // Hunza Valley

    return Scaffold(
      drawer: const CustomDrawer(currentRoute: 'Home'),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar Requirement
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: const Color(0xFF0D47A1),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Travel Explorer Pakistan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  SafeNetworkImage(imageUrl: featured.imageUrl),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          const Color(0xFF0D47A1).withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Pakistan places (e.g. Hunza, Lahore)...',
                    prefixIcon:
                        const Icon(Icons.search_rounded, color: Color(0xFF0D47A1)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                  onSubmitted: (query) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListScreen(searchQuery: query),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Featured Destination Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Destination',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DestinationDetailsScreen(destination: featured),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            SafeNetworkImage(
                              imageUrl: featured.imageUrl,
                              width: double.infinity,
                              height: 180,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.8),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        featured.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        featured.location,
                                        style: const TextStyle(
                                            color: Colors.white70, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DestinationDetailsScreen(
                                                  destination: featured),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFF0D47A1),
                                    ),
                                    child: const Text('Explore'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Categories Horizontal Quick View
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 85,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pakistanCategories.length,
                      itemBuilder: (context, index) {
                        final cat = pakistanCategories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ListScreen(searchQuery: cat.title),
                              ),
                            );
                          },
                          child: Container(
                            width: 110,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: cat.colors),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(cat.icon, color: Colors.white, size: 28),
                                const SizedBox(height: 4),
                                Text(
                                  cat.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Popular Destinations List Title
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Pakistan Destinations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
          ),

          // Horizontal Destination Scroll
          SliverToBoxAdapter(
            child: Container(
              height: 230,
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: pakistanDestinations.length,
                itemBuilder: (context, index) {
                  final item = pakistanDestinations[index];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DestinationDetailsScreen(destination: item),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SafeNetworkImage(
                              imageUrl: item.imageUrl,
                              height: 120,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.price,
                                    style: const TextStyle(
                                      color: Color(0xFF0D47A1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          size: 14, color: Colors.amber),
                                      Text(
                                        ' ${item.rating}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. LIST SCREEN WITH LISTVIEW & SEARCH FILTER
// ============================================================================

class ListScreen extends StatefulWidget {
  final String? searchQuery;
  final bool showFavoritesOnly;

  const ListScreen({
    super.key,
    this.searchQuery,
    this.showFavoritesOnly = false,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late bool _favOnly;
  late List<Destination> _filteredList;

  @override
  void initState() {
    super.initState();
    _favOnly = widget.showFavoritesOnly;
    if (widget.searchQuery != null) {
      _searchController.text = widget.searchQuery!;
    }
    _filter();
  }

  void _filter() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredList = pakistanDestinations.where((item) {
        final matchesQuery = item.name.toLowerCase().contains(query) ||
            item.location.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query);
        final matchesFav = !_favOnly || item.isFavorite;
        return matchesQuery && matchesFav;
      }).toList();
    });
  }

  void _toggleFavorite(Destination item) {
    setState(() {
      item.isFavorite = !item.isFavorite;
      _filter();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          item.isFavorite
              ? '${item.name} added to favorites!'
              : '${item.name} removed from favorites.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Pakistan'),
        actions: [
          IconButton(
            icon: Icon(
              _favOnly ? Icons.favorite : Icons.favorite_border,
              color: _favOnly ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _favOnly = !_favOnly;
                _filter();
              });
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(currentRoute: 'Explore'),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
      body: Column(
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _filter(),
              decoration: InputDecoration(
                hintText: 'Search city or valley (e.g. Hunza, Lahore)...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF0D47A1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          // ListView.builder Requirement
          Expanded(
            child: _filteredList.isEmpty
                ? const Center(
                    child: Text(
                      'No Pakistan destinations found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _filteredList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DestinationDetailsScreen(destination: item),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SafeNetworkImage(
                                imageUrl: item.imageUrl,
                                width: 120,
                                height: 110,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              item.isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.redAccent,
                                              size: 20,
                                            ),
                                            onPressed: () =>
                                                _toggleFavorite(item),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        item.location,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.price,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0D47A1),
                                              fontSize: 14,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  size: 14, color: Colors.amber),
                                              Text(' ${item.rating}',
                                                  style: const TextStyle(
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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

// ============================================================================
// 6. ABOUT SCREEN WITH GRIDVIEW (6 CATEGORIES)
// ============================================================================

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About & Categories')),
      drawer: const CustomDrawer(currentRoute: 'About'),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.flight_takeoff_rounded,
                        size: 50, color: Color(0xFF0D47A1)),
                    const SizedBox(height: 8),
                    const Text(
                      'Travel Explorer Pakistan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const Text('Version 1.0.0',
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    const Text(
                      'Discover Pakistan, One Journey at a Time.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This application displays top destinations across Pakistan including northern mountains, historic cities, coastal beaches, and valleys.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // GridView Header
            const Text(
              'Explore Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
            const SizedBox(height: 10),

            // GridView Requirement: Exactly 6 items (2 columns x 3 rows)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pakistanCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final category = pakistanCategories[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ListScreen(searchQuery: category.title),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: category.colors),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category.icon, color: Colors.white, size: 36),
                          const SizedBox(height: 8),
                          Text(
                            category.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            category.spotCount,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Developer Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Developer Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.person, color: Color(0xFF0D47A1)),
                      title: const Text('Developer'),
                      subtitle: const Text('Flutter App Developer'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.school, color: Color(0xFF0D47A1)),
                      title: const Text('Assignment'),
                      subtitle: const Text('Mobile Application Development'),
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
}

// ============================================================================
// 7. DESTINATION DETAILS SCREEN
// ============================================================================

class DestinationDetailsScreen extends StatefulWidget {
  final Destination destination;

  const DestinationDetailsScreen({super.key, required this.destination});

  @override
  State<DestinationDetailsScreen> createState() =>
      _DestinationDetailsScreenState();
}

class _DestinationDetailsScreenState extends State<DestinationDetailsScreen> {
  late bool _fav;

  @override
  void initState() {
    super.initState();
    _fav = widget.destination.isFavorite;
  }

  void _showBookingDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Book Tour to ${widget.destination.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Package Price: ${widget.destination.price} per person'),
            const SizedBox(height: 6),
            Text('Location: ${widget.destination.location}'),
            const SizedBox(height: 10),
            const Text(
              'Thank you for booking! Our team will contact you to finalize trip arrangements.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking submitted for ${widget.destination.name}!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm Booking'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dest = widget.destination;

    return Scaffold(
      appBar: AppBar(
        title: Text(dest.name),
        actions: [
          IconButton(
            icon: Icon(
              _fav ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onPressed: () {
              setState(() {
                _fav = !_fav;
                dest.isFavorite = _fav;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeNetworkImage(
              imageUrl: dest.imageUrl,
              height: 240,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dest.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dest.price,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Color(0xFF0288D1)),
                      const SizedBox(width: 4),
                      Text(dest.location,
                          style: TextStyle(color: Colors.grey.shade700)),
                    ],
                  ),
                  const Divider(height: 24),
                  const Text(
                    'Key Attractions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: dest.highlights
                        .map((h) => Chip(
                              label: Text(h, style: const TextStyle(fontSize: 12)),
                              backgroundColor: const Color(0xFFE3F2FD),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'About Destination',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dest.detailedDescription,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _showBookingDialog,
                      icon: const Icon(Icons.book_online_rounded),
                      label: const Text('Book Tour Package'),
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
