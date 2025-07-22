import 'package:flutter/cupertino.dart';

import '../../../../core/auth/presentation/widgets/widgets.dart';
import '../../../../core/shared/data/static_files.dart';

const indexList = [
  {"name": "Home", "icon": CupertinoIcons.home},
  {"name": "Market", "icon": Icons.store},
  {"name": "News", "icon": CupertinoIcons.news},
  {"name": "Account", "icon": CupertinoIcons.person},
];

const legacyData = [
  {
    "illustration": Statics.secure,
    "title": "Enhanced Security",
    "text":
        """Your safety is our priority. We've implemented robust security measures to protect your data and transactions, ensuring peace of mind every time you use the platform.""",
  },
  {
    "illustration": Statics.trading,
    "title": "Easier Way to Trade",
    "text":
        """Trading has never been this simple. With intuitive workflows and streamlined processes, you can now trade faster and more efficiently than ever.""",
  },
  {
    "illustration": Statics.redesign,
    "title": "Sleeker Look and Feel",
    "text":
        """Enjoy a modern and visually appealing interface designed with you in mind. Our refreshed design makes navigation effortless and enhances your overall experience.""",
  },
];
