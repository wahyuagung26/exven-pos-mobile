import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final Color? backgroundColor;
  final double displacement;
  final double edgeOffset;
  final String? semanticsLabel;
  final String? semanticsValue;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? Theme.of(context).colorScheme.primary,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      displacement: displacement,
      edgeOffset: edgeOffset,
      semanticsLabel: semanticsLabel ?? 'Pull to refresh',
      semanticsValue: semanticsValue,
      child: child,
    );
  }
}

class ScrollableRefreshWrapper extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final bool alwaysScrollable;

  const ScrollableRefreshWrapper({
    super.key,
    required this.child,
    required this.onRefresh,
    this.alwaysScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      child: alwaysScrollable
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: child,
              ),
            )
          : child,
    );
  }
}

class ListViewWithRefresh<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onRefresh;
  final Widget? emptyState;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Widget Function(BuildContext context)? separatorBuilder;

  const ListViewWithRefresh({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    this.emptyState,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && emptyState != null) {
      return ScrollableRefreshWrapper(
        onRefresh: onRefresh,
        child: emptyState!,
      );
    }

    final listView = separatorBuilder != null
        ? ListView.separated(
            padding: padding,
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: items.length,
            itemBuilder: (context, index) => itemBuilder(context, items[index], index),
            separatorBuilder: separatorBuilder!,
          )
        : ListView.builder(
            padding: padding,
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: items.length,
            itemBuilder: (context, index) => itemBuilder(context, items[index], index),
          );

    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      child: listView,
    );
  }
}

class GridViewWithRefresh<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onRefresh;
  final SliverGridDelegate gridDelegate;
  final Widget? emptyState;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const GridViewWithRefresh({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    required this.gridDelegate,
    this.emptyState,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && emptyState != null) {
      return ScrollableRefreshWrapper(
        onRefresh: onRefresh,
        child: emptyState!,
      );
    }

    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: padding,
        physics: physics,
        shrinkWrap: shrinkWrap,
        gridDelegate: gridDelegate,
        itemCount: items.length,
        itemBuilder: (context, index) => itemBuilder(context, items[index], index),
      ),
    );
  }
}

class SliverRefreshWrapper extends StatelessWidget {
  final List<Widget> slivers;
  final Future<void> Function() onRefresh;
  final ScrollPhysics? physics;

  const SliverRefreshWrapper({
    super.key,
    required this.slivers,
    required this.onRefresh,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: physics,
        slivers: slivers,
      ),
    );
  }
}