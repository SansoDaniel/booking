import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: .start,
            spacing: AppSpacing.s,
            children: [
              Header(),
              CustomSearchBar(),
              SectionHeader(sectionTitle: 'Popular'),
              PopularHotel(),
              SectionHeader(sectionTitle: 'Nearest'),
              NearestHotel(),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.sectionTitle, super.key});

  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Text(
        sectionTitle,
        style: AppTextStyles.h6.copyWith(fontWeight: .bold),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: AppSpacing.s,
            children: [
              Text(
                'Walcome Buddy',
                style: AppTextStyles.h6.copyWith(
                  color: Colors.blue,
                  fontWeight: .bold,
                ),
              ),
              Text(
                'Start search your hotel!',
                style: AppTextStyles.body.copyWith(color: Colors.blue),
              ),
            ],
          ),
          CircleAvatar(
            radius: 24,
            foregroundImage: Image.network(
              'https://picsum.photos/id/237/200/300',
            ).image,
          ),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.m,
      mainAxisAlignment: .spaceAround,
      children: [
        Expanded(
          child: TextField(
            style: AppTextStyles.body,
            decoration: InputDecoration(
              fillColor: Color(0xFFDBDBDB),
              filled: true,
              visualDensity: .comfortable,
              hintText: 'Search hotel...',
              hintStyle: AppTextStyles.caption.copyWith(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        InkWell(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.settings_rounded, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class PopularHotel extends StatelessWidget {
  const PopularHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.m,
      children: [PopularHotelCard(), PopularHotelCard()],
    );
  }
}

class PopularHotelCard extends StatelessWidget {
  const PopularHotelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 250,
        minWidth: context.screenWidth / 2 - AppSpacing.m * 1.5,
        maxWidth: context.screenWidth / 2 - AppSpacing.m * 1.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            blurStyle: .outer,
            color: Colors.grey,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.m,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: 150,
                minWidth:
                    (context.screenWidth / 2 - AppSpacing.m * 1.5) -
                    AppSpacing.s,
              ),
              clipBehavior: .hardEdge,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(2),
                image: DecorationImage(
                  fit: .fill,
                  image: Image.network(
                    'https://picsum.photos/seed/picsum/200/300',
                  ).image,
                ),
              ),
              child: Align(
                alignment: .topRight,
                child: Container(
                  width: 55,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    spacing: AppSpacing.xs,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        '4.5',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: .bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Ciletuh Modern Hotel',
              style: AppTextStyles.bodyLarge.copyWith(fontWeight: .bold),
            ),
            Text('Geopark Ciletuh', style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}

class NearestHotel extends StatelessWidget {
  const NearestHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: AppSpacing.s),
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s),
            child: Stack(
              children: [
                Row(
                  spacing: AppSpacing.m,
                  children: [
                    Image.network(
                      'https://picsum.photos/200',
                      width: 64,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                            return Container(
                              clipBehavior: .hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: child,
                            );
                          },
                    ),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Ciletuh Modern Hotel',
                          style: TextStyle(
                            fontWeight: .bold,
                            fontSize: AppTypography.fontSize.xl,
                          ),
                        ),
                        Text('Geopark Ciletuh', style: AppTextStyles.overline),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    spacing: AppSpacing.xs,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        '4.5',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: .bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    '\$150/Night',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.amber,
                      fontWeight: .bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
