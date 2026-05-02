import 'package:flutter/material.dart';

import '../network/dio_helper.dart';

class CountryCodeModel {
  late int id;
  late String code;
  late String name;

  CountryCodeModel({this.id = 0, this.code = "", this.name = ""});

  CountryCodeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    code = (json["code"] ?? "").toString();
    name = json["name_en"] ?? json["name_ar"] ?? json["name"] ?? "";
  }
}

class AppDropMenu extends StatefulWidget {
  const AppDropMenu({super.key, this.onChanged, this.value});

  final ValueChanged<Object?>? onChanged;
  final CountryCodeModel? value;

  @override
  State<AppDropMenu> createState() => _AppDropMenuState();
}

class _AppDropMenuState extends State<AppDropMenu> {
  late List<CountryCodeModel> _countries;
  DataStates _state = DataStates.uninitialized;

  @override
  void initState() {
    _getCountryCode();
    super.initState();
  }

  Future<void> _getCountryCode() async {
    _state = DataStates.loading;
    setState(() {});
    final response = await DioHelper.getData("api/Countries");
    if (response.isSuccess) {
      _state = DataStates.loaded;
      _countries = (response.data as List).map((e) => CountryCodeModel.fromJson(e)).toList();
      widget.onChanged?.call(_countries.first);
    } else {
      _state = DataStates.error;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 6),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Theme.of(context).hintColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: _state == DataStates.uninitialized || _state == DataStates.loading
          ? const CircularProgressIndicator(padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10))
          : _state == DataStates.error
          ? IconButton(
              onPressed: () => _getCountryCode(),
              icon: Icon(Icons.refresh, size: 35, color: color.primary),
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
            )
          : DropdownButton(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 3),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              borderRadius: BorderRadius.circular(13),
              dropdownColor: color.primary.withValues(alpha: 0.95),
              style: theme.textTheme.titleMedium?.copyWith(fontSize: 18, color: theme.scaffoldBackgroundColor),
              onChanged: widget.onChanged,
              value: widget.value,
              items: _countries
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.code, style: theme.textTheme.displayMedium),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
