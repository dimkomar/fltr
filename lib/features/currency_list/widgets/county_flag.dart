import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getFlag(String iso) {
  switch (iso) {
    case 'EUR':
      return SvgPicture.asset('assets/svg/country_eu.svg', width: 54);
    case 'USD':
      return SvgPicture.asset('assets/svg/country_us.svg', width: 54);
    case 'PLN':
      return SvgPicture.asset('assets/svg/country_pl.svg', width: 54);
    case 'RUB':
      return SvgPicture.asset('assets/svg/country_ru.svg', width: 54);
    case 'BYN':
      return SvgPicture.asset('assets/svg/country_by.svg', width: 54);
    default:
      return SvgPicture.asset('assets/svg/country_eu.svg', width: 54);
  }
}