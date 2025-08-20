import 'package:flutter/material.dart';

class UnauthenticatedLayout extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showAppBar;
  final bool centerContent;
  final EdgeInsets? padding;
  final Widget? backgroundImage;
  final Color? backgroundColor;

  const UnauthenticatedLayout({
    super.key,
    required this.child,
    this.title,
    this.showAppBar = false,
    this.centerContent = true,
    this.padding,
    this.backgroundImage,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: showAppBar ? AppBar(
        title: title != null ? Text(title!) : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ) : null,
      body: Stack(
        children: [
          if (backgroundImage != null) backgroundImage!,
          SafeArea(
            child: Padding(
              padding: padding ?? const EdgeInsets.all(24.0),
              child: centerContent
                  ? Center(child: child)
                  : child,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final double? width;
  final double? height;

  const AuthCard({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 400,
      height: height,
      constraints: const BoxConstraints(
        maxWidth: 400,
        minHeight: 300,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
              if (subtitle != null) ...[
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? logo;

  const WelcomeBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (logo != null) ...[
          logo!,
          const SizedBox(height: 24),
        ],
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}