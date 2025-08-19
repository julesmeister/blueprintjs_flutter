import 'package:flutter/material.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_popover.dart';
import '../../components/blueprint_menu.dart';
import '../../components/blueprint_common.dart';
import '../../theme/blueprint_theme.dart';

class PopoverMenuDemos {
  static Widget buildMenuPopovers(Function(String) showSnackBar) {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.menu(
          items: [
            BlueprintMenuItem(
              text: 'Edit',
              icon: Icons.edit,
              onTap: () => showSnackBar('Edit clicked'),
            ),
            BlueprintMenuItem(
              text: 'Copy',
              icon: Icons.copy,
              onTap: () => showSnackBar('Copy clicked'),
            ),
            BlueprintMenuItem(
              text: 'Share',
              icon: Icons.share,
              onTap: () => showSnackBar('Share clicked'),
            ),
            BlueprintMenuDivider(),
            BlueprintMenuItem(
              text: 'Delete',
              icon: Icons.delete,
              intent: BlueprintIntent.danger,
              onTap: () => showSnackBar('Delete clicked'),
            ),
          ],
          child: const BlueprintButton(
            text: 'Actions',
            icon: Icons.more_vert,
            variant: BlueprintButtonVariant.outlined,
          ),
        ),
        BlueprintPopovers.menu(
          items: [
            BlueprintMenuItem(
              text: 'Inbox (3)',
              icon: Icons.inbox,
              onTap: () => showSnackBar('Inbox opened'),
            ),
            BlueprintMenuItem(
              text: 'Sent',
              icon: Icons.send,
              onTap: () => showSnackBar('Sent opened'),
            ),
            BlueprintMenuItem(
              text: 'Drafts (1)',
              icon: Icons.drafts,
              onTap: () => showSnackBar('Drafts opened'),
            ),
            BlueprintMenuDivider(),
            BlueprintMenuItem(
              text: 'Archive',
              icon: Icons.archive,
              onTap: () => showSnackBar('Archive opened'),
            ),
            BlueprintMenuItem(
              text: 'Folders',
              icon: Icons.folder,
              onTap: () => showSnackBar('Folders opened'),
            ),
          ],
          position: BlueprintPopoverPosition.bottomRight,
          child: const BlueprintButton(
            text: 'Mail Menu',
            icon: Icons.mail,
            intent: BlueprintIntent.primary,
          ),
        ),
      ],
    );
  }
}