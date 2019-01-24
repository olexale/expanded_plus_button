import 'package:flutter/material.dart';

class ExpandedPlusBar extends AnimatedWidget {
  final Animation containerHeightAnimation;
  final Animation containerMarginAnimation;
  final Animation topContainerWidthAnimation;
  final Animation bottomButtonsOpacityAnimation;
  final Animation topContainerOpacityAnimation;

  final List<Widget> leftRowChildren;
  final List<Widget> rightRowChildren;
  final List<Widget> topRowChildren;

  final VoidCallback onPressed;

  static const double plusWidth = 2;
  static const double plusHeight = 48;

  static const double topContainerHeight = 60;

  static final barColor = Color.fromRGBO(170, 170, 190, 1);

  ExpandedPlusBar(
      {Key key,
      @required Listenable animation,
      double maxWidth,
      this.leftRowChildren,
      this.rightRowChildren,
      this.onPressed,
      this.topRowChildren})
      : containerHeightAnimation = Tween(
          begin: topContainerHeight,
          end: topContainerHeight * 2,
        ).animate(CurvedAnimation(parent: animation, curve: Interval(0, 0.4))),
        containerMarginAnimation = Tween(begin: plusHeight / 2, end: 0.0)
            .animate(
                CurvedAnimation(parent: animation, curve: Interval(0, 0.4))),
        bottomButtonsOpacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: animation, curve: Interval(0.4, 0.6))),
        topContainerOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Interval(0.6, 1))),
        topContainerWidthAnimation =
            Tween(begin: plusWidth, end: maxWidth ?? 500).animate(
                CurvedAnimation(parent: animation, curve: Interval(0.5, 1))),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // plusWidth,
      height: containerHeightAnimation.value,
      child: Stack(children: [
        Align(alignment: Alignment.topCenter, child: topContainer()),
        Align(alignment: Alignment.bottomCenter, child: plusButton()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: bottomButtonsOpacityAnimation.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: []
                ..addAll(leftRowChildren)
                ..add(SizedBox(width: plusHeight))
                ..addAll(rightRowChildren),
            ),
          ),
        ),
      ]),
    );
  }

  Widget topContainer() => Container(
      margin: EdgeInsets.only(
          top: containerMarginAnimation.value,
          bottom: containerMarginAnimation.value / 2),
      width: topContainerWidthAnimation.value,
      height: topContainerHeight,
      color: barColor,
      child: Opacity(
          opacity: topContainerOpacityAnimation.value,
          child: topContainerWidthAnimation.value > 200
              ? Row(
                  children: topRowChildren,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )
              : null));

  Widget plusButton() => RawMaterialButton(
        onPressed: this.onPressed,
        shape: CircleBorder(),
        child: Container(
          width: plusHeight / 2,
          height: plusWidth,
          color: barColor,
        ),
      );
}
