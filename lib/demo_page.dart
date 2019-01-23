import 'package:expanded_plus_button/expanded_plus_bar.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage>
    with SingleTickerProviderStateMixin {
  AnimationController _plusButtonController;

  @override
  void initState() {
    super.initState();
    _plusButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
  }

  @override
  void dispose() {
    super.dispose();
    _plusButtonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Half_Dome_from_Glacier_Point%2C_Yosemite_NP_-_Diliff.jpg/640px-Half_Dome_from_Glacier_Point%2C_Yosemite_NP_-_Diliff.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ExpandedPlusBar(
                topRowChildren: [
                  _buildIconButton(Icons.photo_camera, color: Colors.white),
                  _buildIconButton(Icons.photo_library, color: Colors.white),
                  _buildIconButton(Icons.video_library, color: Colors.white),
                ],
                onPressed: _toggleAnimation,
                maxWidth: MediaQuery.of(context).size.width - 24,
                animation: _plusButtonController,
                leftRowChildren: [
                  _buildIconButton(Icons.home),
                  _buildIconButton(Icons.search),
                ],
                rightRowChildren: [
                  _buildIconButton(Icons.notifications),
                  _buildIconButton(Icons.account_box),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {Color color}) => IconButton(
      icon: Icon(icon),
      onPressed: () {},
      color: color ?? ExpandedPlusBar.barColor);

  Future _toggleAnimation() async {
    if (_plusButtonController.status == AnimationStatus.dismissed)
      await _plusButtonController.forward();
    else if (_plusButtonController.status == AnimationStatus.completed)
      await _plusButtonController.reverse();
  }
}
