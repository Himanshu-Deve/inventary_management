import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/config/session_manager.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/utils/app_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Random professional color pairs: [light, dark]
  final List<List<Color>> gradientColors = [
    [Colors.grey.shade600, Colors.grey.shade800],
    [Colors.blue.shade400, Colors.blue.shade900],
    [Colors.red.shade400, Colors.red.shade900],
    [Colors.teal.shade300, Colors.teal.shade800],
    [Colors.orange.shade300, Colors.orange.shade800],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inventory Management",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
        actions: [
          IconButton(onPressed: (){
            AppUtils.showCustomPopup(
              title: "Log Out!",
              content: Text("Are You Really Want to Logout ?"),
              confirmText: "Yes",
              onConfirm: ()async{
                await SessionManager.instance.clearAll();
                context.go(MyRoutes.login);
              },
              cancelText: "No",
              onCancel: (){
                context.pop();
              }
            );
          }, icon: Icon(Icons.logout)),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.95, // adjust height
          children: [
            buildInOutCard(
              onTap: (){context.push(MyRoutes.inScreen);},
              context,
              title: "IN",
              colors: [
                const Color(0xFF7BC6FF), // Light Blue
                const Color(0xFF0D8CDC), // Very Light Blue
              ],
              icon: Icons.login_rounded,
            ),
            buildInOutCard(
              onTap: (){context.push(MyRoutes.outScreen);},
              context,
              title: "OUT",
              colors: [
                const Color(0xFFFFAB91), // Soft Peach
                const Color(0xFFE4210A), // Very Light Peach
              ],
              icon: Icons.logout_rounded,
            ),
          ],

        ),
      ),
    );
  }
  Widget buildInOutCard(
      BuildContext context, {
        required String title,
        required List<Color> colors,
        required IconData icon,
        required Function onTap
      }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔵 CIRCLE ICON ABOVE CARD
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: colors[0],  // match primary color of the card
                size: 28,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "POS MACHINE",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
