import 'package:flutter/material.dart';

import '../../../../shared/theme/app_theme.dart';

enum AuthRole { owner, employee }

class AuthRoleSelector extends StatelessWidget {
  final AuthRole selectedRole;
  final ValueChanged<AuthRole> onRoleChanged;

  const AuthRoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onRoleChanged(AuthRole.owner),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: selectedRole == AuthRole.owner
                    ? const LinearGradient(
                        colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                      )
                    : null,
                color: selectedRole == AuthRole.owner 
                    ? null 
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: selectedRole == AuthRole.owner 
                    ? null 
                    : Border.all(color: Colors.grey.shade300),
                boxShadow: selectedRole == AuthRole.owner
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person, 
                    color: selectedRole == AuthRole.owner 
                        ? Colors.white 
                        : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Owner',
                    style: TextStyle(
                      color: selectedRole == AuthRole.owner 
                          ? Colors.white 
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onRoleChanged(AuthRole.employee),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: selectedRole == AuthRole.employee
                    ? const LinearGradient(
                        colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                      )
                    : null,
                color: selectedRole == AuthRole.employee 
                    ? null 
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: selectedRole == AuthRole.employee 
                    ? null 
                    : Border.all(color: Colors.grey.shade300),
                boxShadow: selectedRole == AuthRole.employee
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group, 
                    color: selectedRole == AuthRole.employee 
                        ? Colors.white 
                        : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Employee',
                    style: TextStyle(
                      color: selectedRole == AuthRole.employee 
                          ? Colors.white 
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}