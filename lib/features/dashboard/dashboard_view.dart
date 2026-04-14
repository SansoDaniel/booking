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
      backgroundColor: Colors.grey[50],
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
              SectionHeader(
                sectionTitle: 'Recommended Hotel',
                btnText: 'See all',
                rightBtnTap: () {},
              ),
              PopularHotel(),
              SectionHeader(
                sectionTitle: 'Nearby Hotel',
                btnText: 'See all',
                rightBtnTap: () {},
              ),
              NearestHotel(),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.sectionTitle,
    super.key,
    this.btnText,
    this.rightBtnTap,
  });

  final String sectionTitle;
  final String? btnText;
  final VoidCallback? rightBtnTap;

  @override
  Widget build(BuildContext context) {
    final leftText = Text(
      sectionTitle,
      style: AppTextStyles.h6.copyWith(
        fontWeight: .bold,
        fontSize: AppTypography.fontSize.l,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.m),
      child: rightBtnTap == null
          ? leftText
          : Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .end,
              children: [
                Expanded(child: leftText),
                GestureDetector(
                  onTap: rightBtnTap,
                  child: Text(
                    btnText ?? '',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.blue,
                      fontWeight: .w600,
                    ),
                  ),
                ),
              ],
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
            mainAxisAlignment: .center,
            children: [
              Text(
                'Location',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.grey,
                  fontWeight: .bold,
                  fontSize: AppTypography.fontSize.m,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.blue),
                  Text(
                    'New York, USA',
                    style: AppTextStyles.body.copyWith(fontWeight: .bold),
                  ),
                ],
              ),
            ],
          ),
          IconButton.filled(
            onPressed: () {},
            icon: Badge(child: Icon(Icons.notifications)),
            color: Colors.black,
            style: ButtonStyle(
              backgroundColor: .resolveWith((states) {
                return Colors.grey[300];
              }),
            ),
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
              prefixIcon: Icon(Icons.search, color: Colors.blue),
              fillColor: Colors.grey.shade200,
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
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 48, minHeight: 48),
          child: Material(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4),
            clipBehavior: .hardEdge,
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.settings_rounded, color: Colors.white),
            ),
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
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 310),
      child: ListView.builder(
        scrollDirection: .horizontal,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: AppSpacing.m, bottom: AppSpacing.m),
            child: PopularHotelCard(),
          );
        },
      ),
    );
  }
}

class PopularHotelCard extends StatelessWidget {
  const PopularHotelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 250, minWidth: 220, maxWidth: 220),
      child: Material(
        clipBehavior: .hardEdge,
        borderRadius: BorderRadius.circular(8),
        elevation: 1,
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s),
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.xs,
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
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      fit: .fill,
                      image: Image.network(
                        'https://picsum.photos/seed/picsum/200/300',
                      ).image,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.s),
                Row(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  spacing: AppSpacing.xs,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.xxs,
                        horizontal: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '10% Off',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.blue.shade500,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      '4.5',
                      style: AppTextStyles.caption.copyWith(fontWeight: .bold),
                    ),
                  ],
                ),
                Text(
                  'OasisOvertures',
                  style: AppTextStyles.bodyLarge.copyWith(fontWeight: .bold),
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.grey),
                    Text('New York, USA', style: AppTextStyles.caption),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '\$650',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.blue,
                        fontWeight: .bold,
                      ),
                    ),
                    Text('/night', style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),
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
          clipBehavior: .hardEdge,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: Row(
                spacing: AppSpacing.m,
                children: [
                  Image.network(
                    'https://picsum.photos/200',
                    height: 128,
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      spacing: AppSpacing.xs,
                      children: [
                        Row(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .center,
                          spacing: AppSpacing.xs,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSpacing.xxs,
                                horizontal: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '10% Off',
                                style: AppTextStyles.caption.copyWith(
                                  color: Colors.blue.shade500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(
                              '4.5',
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'GoldenValley',
                          style: TextStyle(
                            fontWeight: .bold,
                            fontSize: AppTypography.fontSize.xl,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_pin, color: Colors.grey),
                            Text('New York, USA', style: AppTextStyles.caption),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\$650',
                              style: AppTextStyles.body.copyWith(
                                color: Colors.blue,
                                fontWeight: .bold,
                              ),
                            ),
                            Text('/night', style: AppTextStyles.caption),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
