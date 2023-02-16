import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spotify_ui/assets.gen.dart';
import 'package:flutter_spotify_ui/core/widget/loading_widget.dart';
import 'package:flutter_spotify_ui/feature/home/provider/home_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeSideMenu extends StatelessWidget {
  const HomeSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SpotifyLogo(),
          _SideMenuIcons(),
          SizedBox(height: 12),
          _YourLibraryAndPlaylists(),
        ],
      ),
    );
  }
}

class _SpotifyLogo extends StatelessWidget {
  const _SpotifyLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Image.asset(
        Assets.logo.spotifyLogo.path,
        height: 55,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _SideMenuIcons extends StatelessWidget {
  const _SideMenuIcons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SideMenuIconTab(
          iconData: Icons.home,
          title: 'Home',
          onTap: () {},
        ),
        _SideMenuIconTab(
          iconData: Icons.search,
          title: 'Search',
          onTap: () {},
        ),
        _SideMenuIconTab(
          iconData: Icons.audiotrack,
          title: 'Radio',
          onTap: () {},
        ),
      ],
    );
  }
}

class _SideMenuIconTab extends StatelessWidget {
  const _SideMenuIconTab({
    required this.iconData,
    required this.title,
    required this.onTap,
  });

  final IconData iconData;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: Theme.of(context).iconTheme.color,
        size: 28,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _YourLibraryAndPlaylists extends HookWidget {
  const _YourLibraryAndPlaylists();

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        controller: controller,
        child: ListView(
          controller: controller,
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Text(
                'YOUR LIBRARY',
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const _YourLibrary(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Text(
                'PLAYLIST',
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const _Playlist(),
          ],
        ),
      ),
    );
  }
}

class _YourLibrary extends ConsumerWidget {
  const _YourLibrary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    return state.maybeWhen(
      data: (data) {
        return Column(
          children: [
            for (final library in data.yourLibrary) ...[
              ListTile(
                dense: true,
                title: Text(
                  library.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {},
              ),
            ],
          ],
        );
      },
      orElse: () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < 3; i++) ...[
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: LoadingWidget(),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _Playlist extends ConsumerWidget {
  const _Playlist();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    return state.maybeWhen(
      data: (data) {
        return Column(
          children: [
            for (final playlist in data.playlists) ...[
              ListTile(
                dense: true,
                title: Text(
                  playlist.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {},
              ),
            ],
          ],
        );
      },
      orElse: () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < 3; i++) ...[
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: LoadingWidget(),
              ),
            ],
          ],
        );
      },
    );
  }
}
