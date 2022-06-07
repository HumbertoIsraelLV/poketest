import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

import 'components.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    Key? key,
    this.title,
    this.selection = const Selection.empty(),
  }) : super(key: key);

  final Widget? title;
  final Selection selection;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: selection.isSelecting
          ? AppBar(
              key: const Key('selecting'),
              titleSpacing: 0,
              leading: const CloseButton(),
              title: Text('${selection.amount} pokemon selected'),
              backgroundColor: Colors.grey,
              actions: const [
                Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: 'Select six of them to create a team.',
                  child: IconButton(
                    disabledColor: Colors.white,
                    onPressed: null,
                    icon: Icon(Icons.info_outline_rounded)
                  ),
                ),
              ],
            )
          : AppBar(
              key: const Key('not-selecting'),
              title: title,
              backgroundColor: Colors.grey,
              actions: const [
                Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: 'Select six of them to create a team.',
                  child: IconButton(
                    disabledColor: Colors.white,
                    onPressed: null,
                    icon: Icon(Icons.info_outline_rounded)
                  ),
                ),
              ],
            ),
    );
  }
}
