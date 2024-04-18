library appsizeconstants;

import 'package:demo_app/constants/device_screentype.dart';
import 'package:flutter/material.dart';

double mediaWidth = 0.0;
double mediaHeight = 0.0;
double multiplicationFactor = 0.0;
double multiplicationHeightFactor = 0.0;
double multiplicationWidthFactor = 0.0;
double multiplicationFontFactor = 0.0;
EdgeInsets? iconPadding;
DeviceScreenType deviceScreenType = DeviceScreenType.Mobile;
double blockSizeHeight = 0.0;
double blockSizeWidth = 0.0;
const Color appColor = Color(0xff2C659B);

double screenWidth = 0.0;
double screenHeight = 0.0;
double fontSize = 0.0;

/// Set Device variables as per device type
setDeviceConfiguration(BuildContext context) //
{
  mediaWidth = (MediaQuery.of(context).size).width;
  mediaHeight = (MediaQuery.of(context).size).height;
  blockSizeHeight = mediaHeight / 100;
  blockSizeWidth = mediaWidth / 100;

  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  iconPadding = const EdgeInsets.all(0);

  if (deviceWidth > 950) // Desktop
  {
    deviceScreenType = DeviceScreenType.Desktop;
    multiplicationFontFactor = 0.15;
    multiplicationWidthFactor = 0.15;
    multiplicationHeightFactor = 0.15;
  } else if (deviceWidth > 600) // Tablet
  {
    deviceScreenType = DeviceScreenType.Tablet;
    multiplicationFontFactor = 0.15;
    multiplicationWidthFactor = 0.15;
    multiplicationHeightFactor = 0.15;
  } else // Mobile
  {
    deviceScreenType = DeviceScreenType.Mobile;
    setMobileSizeConstants(deviceScreenType);
  }

  screenWidth = blockSizeWidth * multiplicationWidthFactor;
  screenHeight = blockSizeHeight * multiplicationHeightFactor;
  fontSize = blockSizeWidth * multiplicationFontFactor;
}

/// Set Mobile size variables
setMobileSizeConstants(deviceScreenType) {
  multiplicationFontFactor = 0.255;

  if (mediaHeight < 645) //Moto
  {
    multiplicationHeightFactor = 0.22;
  } else if (mediaHeight < 740) //Pixel3, MI
  {
    multiplicationHeightFactor = 0.20;
  } else if (mediaHeight < 800) // Pixel3 - XL, Pixel 2
  {
    multiplicationHeightFactor = 0.19;
  } else if (mediaHeight < 813) // //IPhone X,
  {
    multiplicationHeightFactor = 0.18;
  } else if (mediaHeight < 875) // //Nokia,
  {
    multiplicationHeightFactor = 0.195;
  } else if (mediaHeight < 910) // //Nokia,
  {
    multiplicationHeightFactor = 0.21;
  } else //
  {
    multiplicationHeightFactor = 0.15;
  }

  if (mediaWidth < 365) //Moto
  {
    multiplicationWidthFactor = 0.27;
  } //
  else if (mediaWidth < 375) //IPhone X,
  {
    multiplicationWidthFactor = 0.281;
  } else if (mediaWidth < 395) //Pixel3, MI
  {
    multiplicationWidthFactor = 0.281;
  } //
  else // Pixel3 - XL, Pixel 2
  {
    multiplicationWidthFactor = 0.28;
  }
}
