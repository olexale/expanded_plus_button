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
        vsync: this, duration: const Duration(milliseconds: 500));
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
        color: Color.fromRGBO(237, 237, 237, 1),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Half_Dome_from_Glacier_Point%2C_Yosemite_NP_-_Diliff.jpg/640px-Half_Dome_from_Glacier_Point%2C_Yosemite_NP_-_Diliff.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ExpandedPlusBar(
                topRowChildren: [
                  _buildIconButton(Icons.photo_camera,
                      color: Color.fromRGBO(237, 237, 237, 1), size: 48),
                  _buildIconButton(Icons.photo_library,
                      color: Color.fromRGBO(237, 237, 237, 1), size: 48),
                  _buildIconButton(Icons.video_library,
                      color: Color.fromRGBO(237, 237, 237, 1), size: 48),
                ],
                onPressed: _toggleAnimation,
                maxWidth: MediaQuery.of(context).size.width - 48,
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

  Widget _buildIconButton(IconData icon, {Color color, double size}) =>
      IconButton(
          icon: Icon(icon),
          iconSize: size ?? 24,
          onPressed: () {},
          color: color ?? Color.fromRGBO(211, 217, 221, 1));

  Future _toggleAnimation() async {
    if (_plusButtonController.status == AnimationStatus.dismissed)
      await _plusButtonController.forward();
    else if (_plusButtonController.status == AnimationStatus.completed)
      await _plusButtonController.reverse();
  }
}
