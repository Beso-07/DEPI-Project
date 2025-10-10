import 'package:flutter/material.dart';


class CustomSettingsItem extends StatelessWidget {
  const CustomSettingsItem({
    super.key,
    required this.title,
    this.optionalText,
    this.hasSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.onTap,
  });

  final String title;
  final String? optionalText;
  final bool hasSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(29),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: hasSwitch
            ? Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeColor: Colors.green,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (optionalText != null) ...[
                    Text(
                      optionalText!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
        onTap: onTap,
      ),
    );
  }
}