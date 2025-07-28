import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/bottom/base_bottom_sheet.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/image/cached_image.dart';
import 'package:tripStory/common/text/common_text_form_field.dart';
import 'package:tripStory/core/enum/trip_area_type.dart';
import 'package:tripStory/core/enum/trip_destination_type.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/util/models/country.dart';

class TripDestinationBottomSheetContent extends StatefulWidget {
  const TripDestinationBottomSheetContent({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return BaseBottomSheet.show<T>(
      context,
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
      // 여행지 선택 하고 텍스트 입력시 유효성 검사
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _BottomHeader(),
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
        RoundedBoxButton(
          text: "입력 완료",
          textStyle: isValid ? f16Whitew700 : f16gray400w700,
          width: MediaQuery.of(context).size.width,
          height: 58,
          borderRadius: 4,
          backgroundColor: isValid ? gray900 : gray300,
          enabled: isValid,
          onTap: () => Get.back(
            result: selectedCountry,
          ),
        )
      ],
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

class _BottomHeader extends StatelessWidget {
  const _BottomHeader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: greyColor,
        ),
      ),
    );
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
          unselectedLabelStyle: f16gray300w600,
          indicatorColor: gray900,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          tabs: [
            Tab(
              child: Text(
                "여행지 검색",
                style: tripDestinationTabType == TripDestinationTabType.search ? f16gray900w700 : f16gray400w700,
              ),
            ),
            Tab(
              child: Text(
                "직접 입력",
                style: tripDestinationTabType == TripDestinationTabType.direct ? f16gray900w700 : f16gray400w700,
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
        CommonTextField(
          controller: countrySearchCon,
          textStyle: f16gray800w600,
          hintText: "여행방 제목을 입력해주세요 :)",
          onChanged: onSearchChanged,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(
              "assets/icon/search.svg",
              fit: BoxFit.none,
              colorFilter: ColorFilter.mode(gray800, BlendMode.srcIn),
            ),
          ),
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
                      style: f12gray400W700,
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
                        hoverColor: gray900,
                        controlAffinity: ListTileControlAffinity.trailing,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            final isSelected = states.contains(WidgetState.selected);

                            if (!isSelected) return gray400.withValues(alpha: 0.32);
                            if (isSelected) return gray900;
                            return gray400.withValues(alpha: 0.32);
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
          style: f16gray800w500,
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
        Text("여행지 선택", style: f12gray600w600),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RoundedBoxButton(
                onTap: () => onAreaTypeChanged(TripAreaType.international),
                text: "해외",
                height: 52,
                borderRadius: 4,
                borderColor: selectedAreaType == TripAreaType.international ? gray900 : gray200,
                textStyle: selectedAreaType == TripAreaType.international ? f15gray900w600 : f15gray300w600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RoundedBoxButton(
                onTap: () => onAreaTypeChanged(TripAreaType.domestic),
                text: "국내",
                height: 52,
                borderRadius: 4,
                borderColor: selectedAreaType == TripAreaType.domestic ? gray900 : gray200,
                textStyle: selectedAreaType == TripAreaType.domestic ? f15gray900w600 : f15gray300w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text("여행지 이름", style: f12gray600w600),
        const SizedBox(height: 8),
        CommonTextField(
          controller: tripDirectController,
          textStyle: f16gray800w600,
          hintText: "여행지를 직접 입력해주세요",
          onChanged: onSearchChanged,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(
              "assets/icon/search.svg",
              fit: BoxFit.none,
              colorFilter: ColorFilter.mode(gray800, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
