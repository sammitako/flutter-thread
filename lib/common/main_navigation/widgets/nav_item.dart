import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.selectedIcon,
    required this.selectedIndex,
    required this.isDark,
  });

  final bool isSelected;
  final Function onTap;
  final IconData icon;
  final IconData selectedIcon;
  final int selectedIndex;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            onTap: () => onTap(),
            child: AnimatedOpacity(
                opacity: isSelected ? 1 : 0.6,
                duration: const Duration(milliseconds: 200),
                child: Container(
                    color: Colors.transparent, // 아이콘 주변을 클릭해도 클릭 가능하게 하기 위해
                    alignment: Alignment.center,
                    child: FaIcon(
                      isSelected ? selectedIcon : icon,
                      color: isSelected
                          ? (isDark ? Colors.white : Colors.black)
                          : (isDark ? Colors.grey[300] : Colors.grey[600]),
                    )))));
  }
}
