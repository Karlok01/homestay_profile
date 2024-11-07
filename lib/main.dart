import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 4;

  static const List<String> _tabTitles = [
    'Booking Calendar',
    'Receipt Generator',
    'Senarai Pelanggan',
    'Senarai Resit',
    'Homestay Profile'
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Receipt Generator')),
    const Center(child: Text('Homestay Profile')),
    const Center(child: Text('Senarai Pelanggan Page')),
    const Center(child: Text('Senarai Resit Page')),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTitles[_selectedIndex]),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booking Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Receipt Generator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Senarai Pelanggan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Senarai Resit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Homestay Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final TextEditingController _homestayNameController = TextEditingController(text: 'Astana Ria D’Raja');
  final TextEditingController _addressController = TextEditingController(text: 'Lot 16786, Jln Tuanku Antah, Jln Rahang Kecil,\nKg Semarak, Seremban, Negeri Sembilan');
  final TextEditingController _phoneController = TextEditingController(text: '010-325 7723');

  bool _isEditingName = false;
  bool _isEditingAddress = false;
  bool _isEditingPhone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Maklumat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildEditableRow('Nama Homestay', _homestayNameController, _isEditingName, () {
            setState(() {
              _isEditingName = !_isEditingName;
            });
          }),
          const Divider(),
          _buildEditableRow('Alamat Homestay', _addressController, _isEditingAddress, () {
            setState(() {
              _isEditingAddress = !_isEditingAddress;
            });
          }),
          const Divider(),
          _buildEditableRow('Nombor Telefon', _phoneController, _isEditingPhone, () {
            setState(() {
              _isEditingPhone = !_isEditingPhone;
            });
          }),
          const Divider(),
          _buildImageRow('Logo Homestay'),
          const Divider(),
          _buildImageRow('Tandatangan'),
          const Divider(),
          const Center(
            child: Text(
              'Peranan Ahli',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildMemberRole('Raja Zainal (1921034) - Admin'),
          const Divider(),
          _buildMemberRole('Azizah (1921035) - Admin'),
          const Divider(),
          _buildMemberRole('Ammar (1921036) - Moderator'),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Send Invitation'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller, bool isEditing, VoidCallback onEdit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: isEditing
              ? TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter $label',
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (_) {
              setState(() {
                isEditing = false;
              });
            },
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(controller.text),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: onEdit,
        ),
      ],
    );
  }

  Widget _buildImageRow(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.grey[300],
              child: const Center(child: Text('No Image')),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMemberRole(String role) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(role)),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: () {},
        ),
      ],
    );
  }
}
