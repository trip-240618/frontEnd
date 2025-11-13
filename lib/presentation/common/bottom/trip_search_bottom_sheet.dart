import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/trip_area_type.dart';
import 'package:tripStory/core/enum/trip_destination_type.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/models/country.dart';
import 'package:tripStory/presentation/common/bottom/base_bottom_sheet.dart';
import 'package:tripStory/presentation/common/button/app_button.dart';
import 'package:tripStory/presentation/common/button/outline/outline_button.dart';
import 'package:tripStory/presentation/common/image/cached_image.dart';
import 'package:tripStory/presentation/common/text/input/input_text_form_field.dart';

class TripDestinationBottomSheetContent extends StatefulWidget {
  const TripDestinationBottomSheetContent({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return BaseBottomSheet.show<T>(
      context,
      heightRatio: 0.8,
      const TripDestinationBottomSheetContent(),
    );
  }

  @override
  State<TripDestinationBottomSheetContent> createState() => _TripDestinationBottomSheetContentState();
}

class _TripDestinationBottomSheetContentState extends State<TripDestinationBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController citySearchCon = TextEditingController();
  final TextEditingController directSearchCon = TextEditingController();
  TripDestinationTabType _tripDestinationTabType = TripDestinationTabType.search;
  TripAreaType? _selectedAreaType;
  String selectedCountry = "";
  List<CountryRegion> filterCountries = countryRegions;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedCountry = "";
        _selectedAreaType = null;
        _tripDestinationTabType = TripDestinationTabType.values[_tabController.index];
        citySearchCon.clear();
        directSearchCon.clear();
      });
    });
    directSearchCon.addListener(() {
      if (directSearchCon.text.isNotEmpty && _selectedAreaType != null) {
        setState(() {});
      }
    });
  }

  bool get isValid {
    switch (_tripDestinationTabType) {
      case TripDestinationTabType.search:
        return selectedCountry.isNotEmpty;

      case TripDestinationTabType.direct:
        return _selectedAreaType != null && directSearchCon.text.trim().isNotEmpty;
    }
  }

  List<CountryRegion> getFilteredCountries(String searchText) {
    if (searchText.trim().isEmpty) return countryRegions;

    return countryRegions
        .map((region) {
          final filtered = region.countries
              .where((country) => country.name.toLowerCase().contains(searchText.toLowerCase()))
              .toList();
          return filtered.isNotEmpty ? CountryRegion(region: region.region, countries: filtered) : null;
        })
        .whereType<CountryRegion>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _BottomContent(
              tabController: _tabController,
              countrySearchCon: citySearchCon,
              directSearchCon: directSearchCon,
              tripDestinationTabType: _tripDestinationTabType,
              selectedCountry: selectedCountry,
              filterCountries: filterCountries,
              selectedAreaType: _selectedAreaType,
              onCountryPressed: (country) => setState(() {
                selectedCountry = country;
              }),
              onAreaTypeChanged: (areaType) => setState(() {
                _selectedAreaType = areaType;
              }),
              onSearchTextChanged: (text) {
                if (_tripDestinationTabType == TripDestinationTabType.direct) selectedCountry = directSearchCon.text;
                setState(() {
                  filterCountries = getFilteredCountries(text);
                });
              },
            ),
          ),
          SizedBox(
            width: context.screenWidth,
            child: AppButton(
              label: "입력 완료",
              onPressed: () => Get.back(
                result: selectedCountry,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    citySearchCon.dispose();
    directSearchCon.dispose();
    super.dispose();
  }
}

class _BottomContent extends StatelessWidget {
  final TabController tabController;
  final TextEditingController countrySearchCon;
  final TextEditingController directSearchCon;
  final TripDestinationTabType tripDestinationTabType;
  final String selectedCountry;
  final List<CountryRegion> filterCountries;
  final TripAreaType? selectedAreaType;
  final ValueChanged<TripAreaType> onAreaTypeChanged;
  final void Function(String)? onSearchTextChanged;
  final void Function(String)? onCountryPressed;

  const _BottomContent({
    required this.tabController,
    required this.countrySearchCon,
    required this.directSearchCon,
    required this.tripDestinationTabType,
    required this.selectedCountry,
    required this.filterCountries,
    required this.onAreaTypeChanged,
    this.onSearchTextChanged,
    this.onCountryPressed,
    this.selectedAreaType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 33),
        TabBar(
          controller: tabController,
          unselectedLabelStyle: context.style.body1Normal.copyWith(
            color: context.color.gray400,
          ),
          indicatorColor: context.color.gray900,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          tabs: [
            Tab(
              child: Text(
                "여행지 검색",
                style: tripDestinationTabType == TripDestinationTabType.search
                    ? context.style.body1Normal
                    : context.style.body1Normal.copyWith(
                        color: context.color.gray400,
                      ),
              ),
            ),
            Tab(
              child: Text(
                "직접 입력",
                style: tripDestinationTabType == TripDestinationTabType.direct
                    ? context.style.body1Normal
                    : context.style.body1Normal.copyWith(
                        color: context.color.gray400,
                      ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              _TripSearch(
                countrySearchCon: countrySearchCon,
                selectedCountry: selectedCountry,
                filterCountries: filterCountries,
                onSearchChanged: onSearchTextChanged,
                onCountryPressed: onCountryPressed,
              ),
              _TripDirect(
                tripDirectController: directSearchCon,
                selectedAreaType: selectedAreaType,
                onAreaTypeChanged: onAreaTypeChanged,
                onSearchChanged: onSearchTextChanged,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _TripSearch extends StatelessWidget {
  final TextEditingController countrySearchCon;
  final String selectedCountry;
  final List<CountryRegion> filterCountries;
  final void Function(String)? onSearchChanged;
  final void Function(String)? onCountryPressed;

  const _TripSearch({
    required this.countrySearchCon,
    required this.selectedCountry,
    required this.filterCountries,
    this.onCountryPressed,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTextField(
          controller: countrySearchCon,
          hintText: "여행방 제목을 입력해주세요 :)",
          onChanged: onSearchChanged,
          leadingIconPath: IconConstants.search,
          leadingIconColor: context.color.gray800,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: filterCountries.length,
            itemBuilder: (context, regionIndex) {
              final region = filterCountries[regionIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      region.region,
                      style: context.style.caption1.copyWith(
                        color: context.color.gray600,
                      ),
                    ),
                  ),
                  ...region.countries.map(
                    (country) => Material(
                      color: Colors.transparent,
                      child: RadioListTile<String>(
                        title: _CountryListTile(country),
                        value: country.name,
                        groupValue: selectedCountry,
                        onChanged: (newValue) => onCountryPressed?.call(newValue!),
                        dense: true,
                        hoverColor: context.color.gray900,
                        controlAffinity: ListTileControlAffinity.trailing,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            final isSelected = states.contains(WidgetState.selected);

                            if (!isSelected) return context.color.gray400.withValues(alpha: 0.32);
                            if (isSelected) return context.color.gray900;
                            return context.color.gray400.withValues(alpha: 0.32);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CountryListTile extends StatelessWidget {
  final Country country;

  const _CountryListTile(
    this.country,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: CachedImage(
            imageUrl: country.image,
            width: 32,
            height: 24,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          country.name,
          style: context.style.body1Normal.copyWith(
            color: context.color.gray800,
          ),
        ),
      ],
    );
  }
}

class _TripDirect extends StatelessWidget {
  final TextEditingController tripDirectController;
  final TripAreaType? selectedAreaType;
  final ValueChanged<TripAreaType> onAreaTypeChanged;
  final void Function(String)? onSearchChanged;

  const _TripDirect({
    required this.tripDirectController,
    this.selectedAreaType,
    required this.onAreaTypeChanged,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          "여행지 선택",
          style: context.style.caption1.copyWith(
            color: context.color.gray600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlineButton(
                label: "해외",
                selected: selectedAreaType == TripAreaType.international,
                onPressed: () => onAreaTypeChanged(TripAreaType.international),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlineButton(
                label: "국내",
                selected: selectedAreaType == TripAreaType.domestic,
                onPressed: () => onAreaTypeChanged(TripAreaType.domestic),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          "여행지 이름",
          style: context.style.caption1.copyWith(
            color: context.color.gray600,
          ),
        ),
        const SizedBox(height: 8),
        InputTextField(
          controller: tripDirectController,
          hintText: "여행지를 직접 입력해주세요",
          onChanged: onSearchChanged,
          leadingIconPath: IconConstants.search,
          leadingIconColor: context.color.gray800,
        ),
      ],
    );
  }
}
