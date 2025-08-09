import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/views/ui/login/screen/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String name = "";
  String email = "";
  void getMyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    setState(() {
      email = payload['email'];
      name = prefs.getString("name") ?? "";
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Snackbar konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logout berhasil")),
    );

    // Arahkan ke halaman login (ganti sesuai kebutuhan)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
      (route) => false,
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin logout dari akun ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup dialog
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                _logout();
              },
              child: const Text("Ya, Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.person,
              size: 70.sp,
            ),
          ),
          Gap(20.sp),
          Text(
            "${name}",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Gap(15.sp),
          Text(
            "$email",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Gap(10.sp),
          ElevatedButton(
            onPressed: () {},
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
