import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pub_riverpod_code_gen/feature/home/provider/home_provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePackageList extends ConsumerWidget {
  const HomePackageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageList = ref.watch(homePackagesProvider);

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(homeNotifierProvider)
            ..invalidate(homePackagesProvider);
        },
        child: packageList.when(
          skipLoadingOnRefresh: false,
          error: (error, _) => Text('Error $error'),
          loading: () => ListView.builder(
            itemCount: 100,
            itemBuilder: (_, __) => const _PackageItemShimmer(),
          ),
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final package = data[index];

                return _PackageItem(
                  name: package.name,
                  description: package.latest.pubspec.description,
                  version: package.latest.version,
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _PackageItem extends StatelessWidget {
  const _PackageItem({
    required this.name,
    required this.version,
    required this.description,
    required this.onTap,
  });

  final String name;
  final String version;
  final String? description;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final description = this.description;

    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Expanded(
            child: Text(
              name,
              maxLines: 3,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0175C2),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Text(version),
        ],
      ),
      subtitle: description != null ? Text(description) : null,
    );
  }
}

class _PackageItemShimmer extends StatelessWidget {
  const _PackageItemShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: ListTile(
        title: Row(
          children: [
            Container(
              height: DefaultTextStyle.of(context).style.fontSize! * .8,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: DefaultTextStyle.of(context).style.fontSize! * .8,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Container(
                height: DefaultTextStyle.of(context).style.fontSize! * .8,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: DefaultTextStyle.of(context).style.fontSize! * .8,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
