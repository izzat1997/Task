import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RightFlow extends StatelessWidget {
  RightFlow({super.key, required this.text, required this.isSelected, this.onTap});

  final String text;
  final bool isSelected;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color color = isSelected ? Colors.orange : Colors.grey;
    return SizedBox(
      height: 20.h,
      width: 100.w,
      child: LayoutBuilder(builder: (context, constrains) {
        double height = constrains.maxHeight;
        double width = constrains.maxWidth;
        return Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.linear,
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 1.5.w),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: height,
                width: width / 2,
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color,
                      width: 5,
                    ),
                  ),
                  child: const ImageIcon(
                    NetworkImage(
                      "https://d87z789irltav.cloudfront.net/img/vimigo-img/vimigo_logo_mini.png",
                    ),
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              height: height,
              width: width,
              child: Center(
                child: Text(text),
              ),
            ),
          ],
        );
      }),
    );
  }
}
