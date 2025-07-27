import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int _selectedSection = 0; // 0: Post, 1: Calendar, 2: Saved
  int _savedSection = -1; // -1: grid, 0: Notes, 1: Videos, 2: AR
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23243A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF23243A),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          // You can add profile actions here if needed
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF23243A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF23243A)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white24,
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person, size: 40, color: Colors.white38)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Username', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  const Text('user@email.com', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            // Settings/Options panel in Drawer
            _SettingsOptionsPanel(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile section
              Row(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white24,
                          backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                          child: _profileImage == null
                              ? const Icon(Icons.person, size: 60, color: Colors.white38)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue.shade200,
                          child: const Icon(Icons.shield, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Username', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _StatItem(label: 'Post', value: '8'),
                            _StatItem(label: 'Followers', value: '20'),
                            _StatItem(label: 'Following', value: '20'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text('JEE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Badges row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BadgeItem(icon: Icons.star, label: '1 Day\nDrip', color: Colors.white),
                  _BadgeItem(icon: Icons.diamond, label: '20 gems', color: Colors.greenAccent),
                  _BadgeItem(icon: Icons.bar_chart, label: '1 Quizzes', color: Colors.purpleAccent),
                ],
              ),
              const SizedBox(height: 16),
              // Section buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ProfileButton(
                    label: 'Post',
                    selected: _selectedSection == 0,
                    onTap: () => setState(() { _selectedSection = 0; _savedSection = -1; }),
                  ),
                  _ProfileButton(
                    label: 'Calendar',
                    selected: _selectedSection == 1,
                    onTap: () => setState(() { _selectedSection = 1; _savedSection = -1; }),
                  ),
                  _ProfileButton(
                    label: 'Saved',
                    selected: _selectedSection == 2,
                    onTap: () => setState(() { _selectedSection = 2; _savedSection = -1; }),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Section content
              if (_selectedSection == 0) ...[
                // Post section: upload pic, post, etc.
                _PostSection(),
              ] else if (_selectedSection == 1) ...[
                // Calendar section
                _CalendarSection(),
              ] else if (_selectedSection == 2) ...[
                // Saved section
                if (_savedSection == -1)
                  _SavedGrid(onTap: (idx) => setState(() { _savedSection = idx; }))
                else if (_savedSection == 0)
                  _SavedNotes(onBack: () => setState(() { _savedSection = -1; }))
                else if (_savedSection == 1)
                  _SavedVideos(onBack: () => setState(() { _savedSection = -1; }))
                else if (_savedSection == 2)
                  _SavedAR(onBack: () => setState(() { _savedSection = -1; }))
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _BadgeItem({required this.icon, required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }
}

// Update _ProfileButton to look and behave like a button with color change
class _ProfileButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ProfileButton({required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFB39DDB) : const Color(0xFFBDBDBD),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? const Color(0xFF7C4DFF) : Colors.transparent,
              width: selected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Post Section ---
class _PostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Upload your picture or post here!', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.upload, color: Colors.white),
          label: const Text('Upload Picture', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Icon(Icons.image, color: Colors.white30, size: 60)),
        ),
      ],
    );
  }
}

// --- Calendar Section ---
class _CalendarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final year = 2025;
    final month = 5;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstDayOfWeek = DateTime(year, month, 1).weekday % 7; // 0=Sun, 6=Sat
    final List<Widget> dayWidgets = [];
    // Add empty widgets for days before the 1st
    for (int i = 0; i < firstDayOfWeek; i++) {
      dayWidgets.add(const SizedBox());
    }
    // Add day numbers
    for (int d = 1; d <= daysInMonth; d++) {
      dayWidgets.add(_CalendarDay(
        day: d,
        isToday: year == today.year && month == today.month && d == today.day,
        isSelected: d == 29, // Example: 29th is selected as in screenshot
      ));
    }
    // Fill the last row with empty widgets if needed
    while (dayWidgets.length % 7 != 0) {
      dayWidgets.add(const SizedBox());
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF18192B),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('May 2025', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _CalendarWeekday('S'),
                  _CalendarWeekday('M'),
                  _CalendarWeekday('T'),
                  _CalendarWeekday('W'),
                  _CalendarWeekday('T'),
                  _CalendarWeekday('F'),
                  _CalendarWeekday('S'),
                ],
              ),
              const SizedBox(height: 4),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: dayWidgets,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF35345A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text('Month: May', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

class _CalendarWeekday extends StatelessWidget {
  final String label;
  const _CalendarWeekday(this.label);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final int day;
  final bool isToday;
  final bool isSelected;
  const _CalendarDay({required this.day, this.isToday = false, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.transparent;
    Color textColor = Colors.white;
    if (isSelected) {
      bgColor = const Color(0xFF7C4DFF);
      textColor = Colors.white;
    } else if (isToday) {
      bgColor = Colors.white24;
      textColor = Colors.white;
    }
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text('$day', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// --- Saved Section ---
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
          color: Colors.yellow.shade100,
          icon: Icons.ondemand_video,
          label: 'Videos',
          onTap: () => onTap(1),
        ),
        _SavedTile(
          color: Colors.pink.shade100,
          icon: Icons.podcasts,
          label: 'Podcasts',
          onTap: () {},
        ),
        _SavedTile(
          color: Colors.cyan.shade100,
          icon: Icons.view_in_ar,
          label: 'AR',
          onTap: () => onTap(2),
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
            Icon(icon, size: 48, color: Colors.black54),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

class _SavedNotes extends StatelessWidget {
  final VoidCallback onBack;
  const _SavedNotes({required this.onBack});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: onBack),
            const Text('Notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(width: 8),
            const Icon(Icons.description, color: Colors.white, size: 28),
          ],
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
          children: List.generate(6, (index) => _NoteCard()),
        ),
      ],
    );
  }
}

class _NoteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23243A),
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
              child: const Center(child: Icon(Icons.image, size: 32, color: Colors.white30)),
            ),
            const SizedBox(height: 8),
            const Text('INTEGRAL CALCULUS', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            const Text('Learn to find areas and reverse derivatives using integrals.', style: TextStyle(color: Colors.white70, fontSize: 11)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.file_copy, color: Colors.white54, size: 16),
                    SizedBox(width: 2),
                    Icon(Icons.volume_up, color: Colors.white54, size: 16),
                  ],
                ),
                const Icon(Icons.bookmark, color: Colors.white54, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedVideos extends StatelessWidget {
  final VoidCallback onBack;
  const _SavedVideos({required this.onBack});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: onBack),
            const Text('Videos', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(width: 8),
            const Icon(Icons.ondemand_video, color: Colors.amber, size: 28),
          ],
        ),
        Column(
          children: List.generate(3, (index) => _VideoCard()),
        ),
      ],
    );
  }
}

class _VideoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF23243A),
        border: Border.all(color: Colors.amber, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Icon(Icons.volume_off, color: Colors.white, size: 18),
                ),
                Positioned(
                  left: 4,
                  bottom: 4,
                  child: Icon(Icons.bookmark, color: Colors.amber, size: 18),
                ),
                Positioned(
                  right: 8,
                  bottom: 4,
                  child: Text('15.30', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Dive into the fascinating world of physics, starting with the foundation............', style: TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _SavedAR extends StatelessWidget {
  final VoidCallback onBack;
  const _SavedAR({required this.onBack});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: onBack),
            const Text('AR/VR', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(width: 8),
            const Icon(Icons.view_in_ar, color: Colors.cyan, size: 28),
          ],
        ),
        Column(
          children: List.generate(3, (index) => _ARCard()),
        ),
      ],
    );
  }
}

class _ARCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
      color: const Color(0xFF23243A),
        border: Border.all(color: Colors.cyan, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Icon(Icons.view_in_ar, size: 32, color: Colors.white30)),
            ),
            const SizedBox(height: 8),
            const Text('Topic Name', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _SettingsOptionsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23243A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.person_outline,
            label: 'Profile',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.lock_outline,
            label: 'Passwords',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.notifications_none,
            label: 'Notifications',
            trailing: Switch(value: true, onChanged: (v) {}),
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.language,
            label: tr('languages'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LanguageSelectionPage()),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.check_circle_outline,
            label: 'Subscriptions',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.help_outline,
            label: 'Help & Support',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.delete_outline,
            label: 'Delete Account',
            onTap: () {},
          ),
          const Divider(color: Colors.blueGrey, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Login Activity', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {},
                  child: const Text('Add Account', style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 2),
                GestureDetector(
                  onTap: () {},
                  child: const Text('Log out', style: TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;
  const _SettingsTile({required this.icon, required this.label, this.trailing, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF374151), width: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 18),
            Expanded(
              child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('languages')),
        backgroundColor: const Color(0xFF23243A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF23243A),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _LanguageOption(
                label: 'Hindi',
                selected: currentLocale.languageCode == 'hi',
                onTap: () async {
                  await context.setLocale(const Locale('hi'));
                  Navigator.of(context).pop();
                },
              ),
              _LanguageOption(
                label: 'English',
                selected: currentLocale.languageCode == 'en',
                onTap: () async {
                  await context.setLocale(const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              _LanguageOption(
                label: 'Marathi',
                selected: currentLocale.languageCode == 'mr',
                onTap: () async {
                  await context.setLocale(const Locale('mr'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LanguageOption({required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 80,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF536DFE) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF536DFE) : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
