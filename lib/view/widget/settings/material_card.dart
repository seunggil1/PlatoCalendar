import 'package:flutter/material.dart';

class MaterialCard extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String? secondSubTitle;
  final List<Widget> children;
  final bool? isFoldable;

  const MaterialCard(
      {super.key,
      required this.title,
      this.subTitle,
      this.secondSubTitle,
      this.isFoldable,
      required this.children});

  @override
  State<StatefulWidget> createState() => _MaterialCard();
}

class _MaterialCard extends State<MaterialCard> {
  late final String title;
  late final String? subTitle;
  late final String? secondSubTitle;
  late final Widget children;
  late final bool isFoldable;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    subTitle = widget.subTitle;
    secondSubTitle = widget.secondSubTitle;
    isFoldable = widget.isFoldable ?? false;
    children =  Card.filled(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card.filled(
        // color: colorScheme.surface,
        child: Column(
          children: [
            // 헤더 부분
            ListTile(
                title: Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary
                    )),
                subtitle: getSubtitle(),
                // 우측에 확장/축소 아이콘
                trailing: isFoldable
                    ? Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      )
                    : SizedBox.shrink(),
                onTap: () {
                  if (isFoldable) {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  }
                }),
            // 확장되는 영역
            isFoldable
                ? AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut,
                    child: isExpanded ? children : const SizedBox.shrink(),
                  )
                : children
          ],
        ));
  }

  Widget? getSubtitle() {
    if (subTitle != null) {
      if (isFoldable && secondSubTitle != null) {
        return AnimatedCrossFade(
            firstChild: Text(subTitle!),
            secondChild: Text(secondSubTitle!),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300));
      } else {
        return Text(subTitle!);
      }
    } else {
      return null;
    }
  }
}
