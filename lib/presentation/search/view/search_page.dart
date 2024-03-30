import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moniepoint_test/gen/assets.gen.dart';
import 'package:moniepoint_test/presentation/presentation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  double doubleInRange(math.Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> markers = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String? mapStyle;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool showMarker = false;
  bool showMenu = false;
  int currentMenuIndex = 1;
  final searchMenuItems = [
    const SearchMenuItem(icon: Iconsax.shield_tick, text: 'Cosy areas'),
    const SearchMenuItem(icon: Iconsax.empty_wallet, text: 'Price'),
    const SearchMenuItem(icon: Iconsax.bag, text: 'Infrastructure'),
    const SearchMenuItem(icon: Iconsax.layer, text: 'Without any layer'),
  ];

  final prices = [
    '10,3 mn ₽',
    '11 mn ₽',
    '7,8 mn ₽',
    '13,3 mn ₽',
    '8,5 mn ₽',
    '6,95 mn ₽',
  ];

  @override
  void initState() {
    super.initState();

    _animationController = widget.animationController;

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {
          showMarker = true;
        });
      } else {
        setState(() {
          showMarker = false;
        });
      }
    });

    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.ease),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DefaultAssetBundle.of(context)
          .loadString(Assets.json.mapDarkTheme)
          .then((value) {
        mapStyle = value;
        setState(() {});
      });
    });

    Future.microtask(() {
      final r = math.Random();
      for (var x = 0; x < 10; x++) {
        markers.add(
          Marker(
            position:
                LatLng(doubleInRange(r, 37, 55), doubleInRange(r, -9, 30)),
            markerId: MarkerId('$x'),
          ),
        );
      }
      setState(() {});
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.5244, 3.3792),
    zoom: 16,
  );

  // @override
  // void didUpdateWidget(covariant SearchPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _animationController
  //     ..reset()
  //     ..forward();
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                mapType: MapType.normal,
                style: mapStyle,
                myLocationButtonEnabled: false,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _animationController.forward();
                  _controller.complete(controller);
                },
              ),
            ),
            if (_animationController.status != AnimationStatus.dismissed) ...[
              for (var i = 0; i < 6; i++) _buildMarkers(i),
              Positioned(
                top: 0,
                left: 30,
                right: 30,
                child: _buildTopBar(),
              ),
              Positioned(
                bottom: 120,
                right: 30,
                child: _buildVariantListButton(),
              ),
              Positioned(
                bottom: 120,
                left: 30,
                child: _buildSideBarButtons(),
              ),
              _buildMenu(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMarkers(int index) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: MediaQuery.sizeOf(context).height *
          math.sin(((index * 25) * math.pi) / 180),
      left: MediaQuery.sizeOf(context).width /
          2 *
          math.cos(((index * 25) * math.pi) / 180),
      child: AnimatedScale(
        scale: showMarker ? 1 : 0,
        alignment: Alignment.centerLeft,
        duration: const Duration(milliseconds: 500),
        child: AnimatedContainer(
          width: currentMenuIndex == 1 ? 130 : 50,
          height: currentMenuIndex == 1 ? 60 : 50,
          duration: const Duration(milliseconds: 700),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: currentMenuIndex == 1
                ? Text(
                    prices[index],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                : Assets.icons.buliding.svg(
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: showMenu ? 190 : 80,
      left: 30,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 500),
        scale: showMenu ? 1 : 0,
        alignment: Alignment.centerLeft,
        child: SearchMenu(
          currentIndex: currentMenuIndex,
          onTap: (value) {
            setState(() {
              showMenu = false;
              currentMenuIndex = value;
            });
          },
          items: searchMenuItems,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.search_normal_1,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Saint Petersburg',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Iconsax.candle_2,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantListButton() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                  tileMode: TileMode.mirror,
                ),
                child: const ColoredBox(
                  color: Colors.white38,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.textalign_left,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'List of variants',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsButton() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: InkResponse(
        onTap: () => setState(() {
          showMenu = !showMenu;
        }),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipOval(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 100,
                    sigmaY: 100,
                    tileMode: TileMode.mirror,
                  ),
                  child: const ColoredBox(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Icon(
                  Iconsax.layer,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipOval(
              child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 100,
                    sigmaY: 100,
                    tileMode: TileMode.mirror,
                  ),
                  child: const ColoredBox(
                    color: Colors.white38,
                  )),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Transform.rotate(
                angle: (-40 * math.pi) / 180,
                child: const Icon(
                  Iconsax.direct_right,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBarButtons() {
    return Column(
      children: [
        _buildOptionsButton(),
        const SizedBox(height: 5),
        _buildSendButton(),
      ],
    );
  }
}
