import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

// PasswordScreen widget matching screenshot

// PasswordScreen widget matching screenshot

// Responsive stat item widget for header
class StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool isMobile;
  const StatItem({required this.icon, required this.color, required this.label, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: isMobile ? 22 : 28),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: isMobile ? 2 : 4),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(label, style: TextStyle(color: Colors.white, fontSize: isMobile ? 12 : 14)),
        ),
      ],
    );
  }

}

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int _selectedSection = 0;
  int _savedSection = -1;
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1B33),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSectionTabs(),
              const SizedBox(height: 20),
              _buildSectionContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 500;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20, vertical: isMobile ? 12 : 20),
          decoration: BoxDecoration(
            color: const Color(0xFF23243A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: isMobile ? 28 : 36,
                      backgroundColor: Colors.white10,
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? Icon(Icons.person, size: isMobile ? 28 : 36, color: Colors.white38)
                          : null,
                    ),
                  ),
                  SizedBox(width: isMobile ? 8 : 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Username', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isMobile ? 15 : 18)),
                        SizedBox(height: isMobile ? 2 : 4),
                        Wrap(
                          spacing: isMobile ? 8 : 12,
                          children: [
                            Text('8 ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isMobile ? 13 : 15)),
                            Text('Post', style: TextStyle(color: Colors.white70, fontSize: isMobile ? 13 : 15)),
                            Text('20 ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isMobile ? 13 : 15)),
                            Text('Followers', style: TextStyle(color: Colors.white70, fontSize: isMobile ? 13 : 15)),
                            Text('20 ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isMobile ? 13 : 15)),
                            Text('Following', style: TextStyle(color: Colors.white70, fontSize: isMobile ? 13 : 15)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                      SizedBox(height: isMobile ? 4 : 8),
                      PopupMenuButton<String>(
                        offset: const Offset(0, 40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'JEE',
                            child: Row(
                              children: const [
                                Icon(Icons.verified, color: Colors.green, size: 18),
                                SizedBox(width: 4),
                                Text('JEE', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'NEET',
                            child: Row(
                              children: const [
                                Icon(Icons.verified, color: Colors.purple, size: 18),
                                SizedBox(width: 4),
                                Text('NEET', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          // TODO: handle selection
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.verified, color: Colors.green, size: 18),
                              const SizedBox(width: 4),
                              Text('JEE', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              const Icon(Icons.arrow_drop_down, color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 10 : 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 12 : 24,
                runSpacing: 8,
                children: [
                  StatItem(icon: Icons.star, color: Colors.amber, label: '1 Day Drip', isMobile: isMobile),
                  StatItem(icon: Icons.diamond, color: Colors.greenAccent, label: '20 gems', isMobile: isMobile),
                  StatItem(icon: Icons.bar_chart, color: Colors.purpleAccent, label: '1 Quizzes', isMobile: isMobile),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF23243A),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            children: [
              Row(
                children: [
                  Icon(Icons.settings, color: Colors.white70),
                  const SizedBox(width: 8),
                  const Text('Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
              const SizedBox(height: 16),
              _drawerButton(context, Icons.person, 'Profile', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
              }),
              _drawerButton(context, Icons.lock, 'Passwords', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PasswordScreen()));
              }),
              _drawerSwitch(context, Icons.notifications, 'Notifications'),
              _drawerButton(context, Icons.language, 'Languages', () {
                Navigator.pop(context);
                _showPlaceholder(context, 'Languages');
              }),
              _drawerButton(context, Icons.check_circle, 'Subscriptions', () {
                Navigator.pop(context);
                _showPlaceholder(context, 'Subscriptions');
              }),
              _drawerButton(context, Icons.help_outline, 'Help & Support', () {
                Navigator.pop(context);
                _showPlaceholder(context, 'Help & Support');
              }),
              _drawerButton(context, Icons.delete, 'Delete Account', () {
                Navigator.pop(context);
                _showPlaceholder(context, 'Delete Account');
              }),
              const Divider(height: 32, color: Colors.white12),
              const Text('Login Activity', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add Account pressed')));
                },
                child: const Text('Add Account', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged out')));
                },
                child: const Text('Log out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: Colors.white12),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _drawerSwitch(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white70),
                const SizedBox(width: 16),
                Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
            Switch(
              value: false,
              onChanged: (v) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notifications ${v ? 'enabled' : 'disabled'}')));
              },
              activeColor: Colors.white,
              inactiveTrackColor: Colors.white24,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(height: 1, color: Colors.white12),
        const SizedBox(height: 12),
      ],
    );
  }

  void _showPlaceholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label screen (placeholder)')));
  }

  Widget _buildSectionTabs() {
    return Row(
      children: [
        Expanded(child: _buildTabButton('Posts', 0)),
        Expanded(child: _buildTabButton('Calendar', 1)),
        Expanded(child: _buildTabButton('Saved', 2)),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedSection == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSection = index;
          _savedSection = -1;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF536DFE) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (_selectedSection) {
      case 0:
        // More posts, scrollable
        final posts = List.generate(12, (i) {
          final titles = [
            'INTEGRAL CALCULUS', 'SOLID STATE', 'KINEMATICS', 'AMINES',
            'THERMODYNAMICS', 'ELECTROCHEMISTRY', 'ATOMIC STRUCTURE', 'POLYMERS',
            'ORGANIC CHEMISTRY', 'INORGANIC CHEMISTRY', 'PHYSICS', 'BIOLOGY'
          ];
          final colors = [
            Colors.deepPurple, Colors.blue, Colors.indigo, Colors.amber,
            Colors.red, Colors.green, Colors.teal, Colors.pink,
            Colors.orange, Colors.cyan, Colors.purple, Colors.lime
          ];
          return {
            'title': titles[i % titles.length],
            'desc': 'Learn to find areas and reverse derivatives using integrals.',
            'color': colors[i % colors.length],
          };
        });
        final width = MediaQuery.of(context).size.width;
        final crossAxisCount = width < 600 ? 2 : 4;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.95,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: posts.length,
            itemBuilder: (context, i) {
              final post = posts[i];
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF23243A),
                  border: Border.all(color: post['color'] as Color, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 32, color: Colors.white30),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post['title'] as String,
                      style: TextStyle(
                        color: post['color'] as Color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post['desc'] as String,
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.people, color: Colors.white54, size: 16),
                            SizedBox(width: 2),
                            Text('11', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.emoji_events, color: Colors.white54, size: 16),
                            SizedBox(width: 2),
                            Text('19/25', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF536DFE),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        child: const Text('TAKE TEST', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      case 1:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF23243A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            children: [
              Text(
                'Calendar View',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Calendar functionality coming soon...',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        );
      case 2:
        if (_savedSection == -1) {
          return _SavedGrid(onTap: (index) {
            setState(() {
              _savedSection = index;
            });
          });
        } else {
          return _SavedContent(
            section: _savedSection,
            onBack: () {
              setState(() {
                _savedSection = -1;
              });
            },
          );
        }
      default:
        return const SizedBox();
    }
  }
}

class _SavedGrid extends StatelessWidget {
  final void Function(int) onTap;
  const _SavedGrid({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1,
      children: [
        _SavedTile(
          color: Colors.blue.shade100,
          icon: Icons.description,
          label: 'Notes',
          onTap: () => onTap(0),
        ),
        _SavedTile(
          color: Colors.amber.shade100,
          icon: Icons.ondemand_video,
          label: 'Videos',
          onTap: () => onTap(1),
        ),
        _SavedTile(
          color: Colors.cyan.shade100,
          icon: Icons.view_in_ar,
          label: 'AR/VR',
          onTap: () => onTap(2),
        ),
        _SavedTile(
          color: Colors.pink.shade100,
          icon: Icons.podcasts,
          label: 'Podcast',
          onTap: () => onTap(3),
        ),
      ],
    );
  }
}

class _SavedTile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SavedTile({required this.color, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black54),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _SavedContent extends StatelessWidget {
  final int section;
  final VoidCallback onBack;
  const _SavedContent({required this.section, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final titles = ['Notes', 'Videos', 'AR/VR', 'Podcast'];
    final colors = [Colors.blue, Colors.amber, Colors.cyan, Colors.pink];
    final icons = [Icons.description, Icons.ondemand_video, Icons.view_in_ar, Icons.podcasts];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: onBack),
            Text(titles[section], style: TextStyle(color: colors[section], fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(width: 8),
            Icon(icons[section], color: colors[section], size: 28),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'No saved ${titles[section].toLowerCase()} yet',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23243A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF23243A),
        elevation: 0,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'Edit Profile functionality coming soon...',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _logoutAll = false;
  bool _loading = false;
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  void _showDialog(bool success) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(success ? Icons.check_circle : Icons.cancel,
                    color: success ? Colors.green : Colors.red, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    success ? 'Password changed successfully' : 'Incorrect Password',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context, rootNavigator: true).pop();
      if (success) Navigator.pop(context);
    });
  }

  void _changePassword() {
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _loading = false);
      // Demo logic: password must be at least 6 chars and new == confirm
      if (_currentController.text == '123456' &&
          _newController.text.length >= 6 &&
          _newController.text == _confirmController.text) {
        _showDialog(true);
      } else {
        _showDialog(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23243A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF23243A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Passwords', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Password',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your Password must be at least 6 characters and should include a combination of numbers , letters and special Characters (!@#\$)',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 24),
            _buildTextField('Current Password', _currentController, !_showCurrent, () {
              setState(() => _showCurrent = !_showCurrent);
            }),
            const SizedBox(height: 16),
            _buildTextField('New Password', _newController, !_showNew, () {
              setState(() => _showNew = !_showNew);
            }),
            const SizedBox(height: 16),
            _buildTextField('Confirm Password', _confirmController, !_showConfirm, () {
              setState(() => _showConfirm = !_showConfirm);
            }),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Your Password?', style: TextStyle(color: Colors.blue)),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _logoutAll,
                  onChanged: (v) => setState(() => _logoutAll = v ?? false),
                  activeColor: Colors.blue,
                ),
                const Text('Log out from all devices', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF536DFE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _loading ? null : _changePassword,
                child: _loading
                    ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Change Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool obscure, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF23243A),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white24),
          onPressed: toggle,
        ),
      ),
    );
  }
}


// Helper for menu option
Widget menuOption(IconData icon, String label) {
  return Column(
    children: [
      Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
      const SizedBox(height: 12),
      Container(height: 1, color: Colors.white12),
      const SizedBox(height: 12),
    ],
  );
}

// Helper for menu option with switch
Widget menuOptionSwitch(IconData icon, String label) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          Switch(
            value: false,
            onChanged: (v) {},
            activeColor: Colors.white,
            inactiveTrackColor: Colors.white24,
          ),
        ],
      ),
      const SizedBox(height: 12),
      Container(height: 1, color: Colors.white12),
      const SizedBox(height: 12),
    ],
  );
}
