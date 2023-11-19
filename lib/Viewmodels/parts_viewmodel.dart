//
//  partsOfHatimViewModel.dart
//  hatimtakipapp
//
//  Created by MrKaplan on 30.08.23.
//

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimmodel.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:uuid/uuid.dart';

class PartsOfHatimViewModel extends Notifier<List<HatimPartModel>> {
  @override
  List<HatimPartModel> build() {
    return allParts;
  }

  List<List<int>> parts = [
    cuz1,
    cuz2,
    cuz3,
    cuz4,
    cuz5,
    cuz6,
    cuz7,
    cuz8,
    cuz9,
    cuz10,
    cuz11,
    cuz12,
    cuz13,
    cuz14,
    cuz15,
    cuz16,
    cuz17,
    cuz18,
    cuz19,
    cuz20,
    cuz21,
    cuz22,
    cuz23,
    cuz24,
    cuz25,
    cuz26,
    cuz27,
    cuz28,
    cuz29,
    cuz30
  ];
  List<HatimPartModel> allParts = [
    c1,
    c2,
    c3,
    c4,
    c5,
    c6,
    c7,
    c8,
    c9,
    c10,
    c11,
    c12,
    c13,
    c14,
    c15,
    c16,
    c17,
    c18,
    c19,
    c20,
    c21,
    c22,
    c23,
    c24,
    c25,
    c26,
    c27,
    c28,
    c29,
    c30
  ];
  final String partText = "Cüz";
  final String pageBetweenText = "sayfalari arasi";
  final String pageText = "sayfa";

  void updateAllPartsWithOwnersList(Hatim hatim, MyUser ownerOfPart) {
    for (int i = 0; i < 30; i++) {
      allParts[i].hatimID = hatim.id;
      allParts[i].hatimName = hatim.hatimName!;
      allParts[i].ownerOfPart = ownerOfPart;
      allParts[i].deadline = hatim.deadline;
    }
  }

  void setIndividualHatim(Hatim hatim) {
    allParts.clear();

    for (int i = 0; i < 30; i++) {
      HatimPartModel a = HatimPartModel(
          hatimID: hatim.id,
          hatimName: hatim.hatimName!,
          pages: parts[i],
          ownerOfPart: hatim.createdBy,
          remainingPages: parts[i],
          deadline: hatim.deadline,
          isPrivate: hatim.isPrivate,
          id: const Uuid().v4().toString());
      allParts.add(a);
    }
  }

  void updateOwnerOfPart(int indexOfselectedPart, MyUser ownerOfPart) {
    allParts[indexOfselectedPart].ownerOfPart = ownerOfPart;
  }

  void sortList() {
    allParts.sort((a, b) => a.pages.first.compareTo(b.pages.first));
  }

  List<MyUser> createParticipantList() {
    Set<MyUser> participantList = {};
    for (var item in allParts) {
      if (item.ownerOfPart != null) {
        participantList.add(item.ownerOfPart!);
      }
    }
    return participantList.toList();
  }

  List<int> controlNonAddedPersonToCuz() {
    List<int> nonAddedPersonToCuzIndexArray = [];
    for (int i = 0; i < allParts.length; i++) {
      if (allParts[i].ownerOfPart == null) {
        nonAddedPersonToCuzIndexArray.add(i);
      }
    }
    return nonAddedPersonToCuzIndexArray;
  }

  String setPartName(List<int> part) {
    if (part.first == 0 && part.last == 20) {
      return "$partText 1";
    } else if (part.first == 21 && part.last == 40) {
      return "$partText 2";
    } else if (part.first == 41 && part.last == 60) {
      return "$partText 3";
    } else if (part.first == 61 && part.last == 80) {
      return "$partText 4";
    } else if (part.first == 81 && part.last == 100) {
      return "$partText 5";
    } else if (part.first == 101 && part.last == 120) {
      return "$partText 6";
    } else if (part.first == 121 && part.last == 140) {
      return "$partText 7";
    } else if (part.first == 141 && part.last == 160) {
      return "$partText 8";
    } else if (part.first == 161 && part.last == 180) {
      return "$partText 9";
    } else if (part.first == 181 && part.last == 200) {
      return "$partText 10";
    } else if (part.first == 201 && part.last == 220) {
      return "$partText 11";
    } else if (part.first == 221 && part.last == 240) {
      return "$partText 12";
    } else if (part.first == 241 && part.last == 260) {
      return "$partText 13";
    } else if (part.first == 261 && part.last == 280) {
      return "$partText 14";
    } else if (part.first == 281 && part.last == 300) {
      return "$partText 15";
    } else if (part.first == 301 && part.last == 320) {
      return "$partText 16";
    } else if (part.first == 321 && part.last == 340) {
      return "$partText 17";
    } else if (part.first == 341 && part.last == 360) {
      return "$partText 18";
    } else if (part.first == 361 && part.last == 380) {
      return "$partText 19";
    } else if (part.first == 381 && part.last == 400) {
      return "$partText 20";
    } else if (part.first == 401 && part.last == 420) {
      return "$partText 21";
    } else if (part.first == 421 && part.last == 440) {
      return "$partText 22";
    } else if (part.first == 441 && part.last == 460) {
      return "$partText 23";
    } else if (part.first == 461 && part.last == 480) {
      return "$partText 24";
    } else if (part.first == 481 && part.last == 500) {
      return "$partText 25";
    } else if (part.first == 501 && part.last == 520) {
      return "$partText 26";
    } else if (part.first == 521 && part.last == 540) {
      return "$partText 27";
    } else if (part.first == 541 && part.last == 560) {
      return "$partText 28";
    } else if (part.first == 561 && part.last == 580) {
      return "$partText 29";
    } else if (part.first == 581 && part.last == 603) {
      return "$partText 30";
    } else if (part.first == part.last) {
      return "${part.first.toString()}. sayfa";
    } else {
      return "${part.first.toString()} - ${part.last.toString()}";
    }
  }
}

List<int> cuz1 = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20
];
List<int> cuz2 = [
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40
];
List<int> cuz3 = [
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  56,
  57,
  58,
  59,
  60
];
List<int> cuz4 = [
  61,
  62,
  63,
  64,
  65,
  66,
  67,
  68,
  69,
  70,
  71,
  72,
  73,
  74,
  75,
  76,
  77,
  78,
  79,
  80
];
List<int> cuz5 = [
  81,
  82,
  83,
  84,
  85,
  86,
  87,
  88,
  89,
  90,
  91,
  92,
  93,
  94,
  95,
  96,
  97,
  98,
  99,
  100
];
List<int> cuz6 = [
  101,
  102,
  103,
  104,
  105,
  106,
  107,
  108,
  109,
  110,
  111,
  112,
  113,
  114,
  115,
  116,
  117,
  118,
  119,
  120
];
List<int> cuz7 = [
  121,
  122,
  123,
  124,
  125,
  126,
  127,
  128,
  129,
  130,
  131,
  132,
  133,
  134,
  135,
  136,
  137,
  138,
  139,
  140
];
List<int> cuz8 = [
  141,
  142,
  143,
  144,
  145,
  146,
  147,
  148,
  149,
  150,
  151,
  152,
  153,
  154,
  155,
  156,
  157,
  158,
  159,
  160
];
List<int> cuz9 = [
  161,
  162,
  163,
  164,
  165,
  166,
  167,
  168,
  169,
  170,
  171,
  172,
  173,
  174,
  175,
  176,
  177,
  178,
  179,
  180
];
List<int> cuz10 = [
  181,
  182,
  183,
  184,
  185,
  186,
  187,
  188,
  189,
  190,
  191,
  192,
  193,
  194,
  195,
  196,
  197,
  198,
  199,
  200
];
List<int> cuz11 = [
  201,
  202,
  203,
  204,
  205,
  206,
  207,
  208,
  209,
  210,
  211,
  212,
  213,
  214,
  215,
  216,
  217,
  218,
  219,
  220
];
List<int> cuz12 = [
  221,
  222,
  223,
  224,
  225,
  226,
  227,
  228,
  229,
  230,
  231,
  232,
  233,
  234,
  235,
  236,
  237,
  238,
  239,
  240
];
List<int> cuz13 = [
  241,
  242,
  243,
  244,
  245,
  246,
  247,
  248,
  249,
  250,
  251,
  252,
  253,
  254,
  255,
  256,
  257,
  258,
  259,
  260
];
List<int> cuz14 = [
  261,
  262,
  263,
  264,
  265,
  266,
  267,
  268,
  269,
  270,
  271,
  272,
  273,
  274,
  275,
  276,
  277,
  278,
  279,
  280
];
List<int> cuz15 = [
  281,
  282,
  283,
  284,
  285,
  286,
  287,
  288,
  289,
  290,
  291,
  292,
  293,
  294,
  295,
  296,
  297,
  298,
  299,
  300
];
List<int> cuz16 = [
  301,
  302,
  303,
  304,
  305,
  306,
  307,
  308,
  309,
  310,
  311,
  312,
  313,
  314,
  315,
  316,
  317,
  318,
  319,
  320
];
List<int> cuz17 = [
  321,
  322,
  323,
  324,
  325,
  326,
  327,
  328,
  329,
  330,
  331,
  332,
  333,
  334,
  335,
  336,
  337,
  338,
  339,
  340
];
List<int> cuz18 = [
  341,
  342,
  343,
  344,
  345,
  346,
  347,
  348,
  349,
  350,
  351,
  352,
  353,
  354,
  355,
  356,
  357,
  358,
  359,
  360
];
List<int> cuz19 = [
  361,
  362,
  363,
  364,
  365,
  366,
  367,
  368,
  369,
  370,
  371,
  372,
  373,
  374,
  375,
  376,
  377,
  378,
  379,
  380
];
List<int> cuz20 = [
  381,
  382,
  383,
  384,
  385,
  386,
  387,
  388,
  389,
  390,
  391,
  392,
  393,
  394,
  395,
  396,
  397,
  398,
  399,
  400
];
List<int> cuz21 = [
  401,
  402,
  403,
  404,
  405,
  406,
  407,
  408,
  409,
  410,
  411,
  412,
  413,
  414,
  415,
  416,
  417,
  418,
  419,
  420
];
List<int> cuz22 = [
  421,
  422,
  423,
  424,
  425,
  426,
  427,
  428,
  429,
  430,
  431,
  432,
  433,
  434,
  435,
  436,
  437,
  438,
  439,
  440
];
List<int> cuz23 = [
  441,
  442,
  443,
  444,
  445,
  446,
  447,
  448,
  449,
  450,
  451,
  452,
  453,
  454,
  455,
  456,
  457,
  458,
  459,
  460
];
List<int> cuz24 = [
  461,
  462,
  463,
  464,
  465,
  466,
  467,
  468,
  469,
  470,
  471,
  472,
  473,
  474,
  475,
  476,
  477,
  478,
  479,
  480
];
List<int> cuz25 = [
  481,
  482,
  483,
  484,
  485,
  486,
  487,
  488,
  489,
  490,
  491,
  492,
  493,
  494,
  495,
  496,
  497,
  498,
  499,
  500
];
List<int> cuz26 = [
  501,
  502,
  503,
  504,
  505,
  506,
  507,
  508,
  509,
  510,
  511,
  512,
  513,
  514,
  515,
  516,
  517,
  518,
  519,
  520
];
List<int> cuz27 = [
  521,
  522,
  523,
  524,
  525,
  526,
  527,
  528,
  529,
  530,
  531,
  532,
  533,
  534,
  535,
  536,
  537,
  538,
  539,
  540
];
List<int> cuz28 = [
  541,
  542,
  543,
  544,
  545,
  546,
  547,
  548,
  549,
  550,
  551,
  552,
  553,
  554,
  555,
  556,
  557,
  558,
  559,
  560
];
List<int> cuz29 = [
  561,
  562,
  563,
  564,
  565,
  566,
  567,
  568,
  569,
  570,
  571,
  572,
  573,
  574,
  575,
  576,
  577,
  578,
  579,
  580
];
List<int> cuz30 = [
  581,
  582,
  583,
  584,
  585,
  586,
  587,
  588,
  589,
  590,
  591,
  592,
  593,
  594,
  595,
  596,
  597,
  598,
  599,
  600,
  601,
  602,
  603
];

HatimPartModel c1 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz1,
    ownerOfPart: null,
    remainingPages: cuz1,
    deadline: null,
    isPrivate: false);
HatimPartModel c2 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz2,
    ownerOfPart: null,
    remainingPages: cuz2,
    deadline: null,
    isPrivate: false);
HatimPartModel c3 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz3,
    ownerOfPart: null,
    remainingPages: cuz3,
    deadline: null,
    isPrivate: false);
HatimPartModel c4 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz4,
    ownerOfPart: null,
    remainingPages: cuz4,
    deadline: null,
    isPrivate: false);
HatimPartModel c5 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz5,
    ownerOfPart: null,
    remainingPages: cuz5,
    deadline: null,
    isPrivate: false);
HatimPartModel c6 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz6,
    ownerOfPart: null,
    remainingPages: cuz6,
    deadline: null,
    isPrivate: false);
HatimPartModel c7 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz7,
    ownerOfPart: null,
    remainingPages: cuz7,
    deadline: null,
    isPrivate: false);
HatimPartModel c8 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz8,
    ownerOfPart: null,
    remainingPages: cuz8,
    deadline: null,
    isPrivate: false);
HatimPartModel c9 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz9,
    ownerOfPart: null,
    remainingPages: cuz9,
    deadline: null,
    isPrivate: false);
HatimPartModel c10 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz10,
    ownerOfPart: null,
    remainingPages: cuz10,
    deadline: null,
    isPrivate: false);
HatimPartModel c11 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz11,
    ownerOfPart: null,
    remainingPages: cuz11,
    deadline: null,
    isPrivate: false);
HatimPartModel c12 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz12,
    ownerOfPart: null,
    remainingPages: cuz12,
    deadline: null,
    isPrivate: false);
HatimPartModel c13 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz13,
    ownerOfPart: null,
    remainingPages: cuz13,
    deadline: null,
    isPrivate: false);
HatimPartModel c14 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz14,
    ownerOfPart: null,
    remainingPages: cuz14,
    deadline: null,
    isPrivate: false);
HatimPartModel c15 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz15,
    ownerOfPart: null,
    remainingPages: cuz15,
    deadline: null,
    isPrivate: false);
HatimPartModel c16 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz16,
    ownerOfPart: null,
    remainingPages: cuz16,
    deadline: null,
    isPrivate: false);
HatimPartModel c17 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz17,
    ownerOfPart: null,
    remainingPages: cuz17,
    deadline: null,
    isPrivate: false);
HatimPartModel c18 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz18,
    ownerOfPart: null,
    remainingPages: cuz18,
    deadline: null,
    isPrivate: false);
HatimPartModel c19 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz19,
    ownerOfPart: null,
    remainingPages: cuz19,
    deadline: null,
    isPrivate: false);
HatimPartModel c20 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz20,
    ownerOfPart: null,
    remainingPages: cuz20,
    deadline: null,
    isPrivate: false);
HatimPartModel c21 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz21,
    ownerOfPart: null,
    remainingPages: cuz21,
    deadline: null,
    isPrivate: false);
HatimPartModel c22 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz22,
    ownerOfPart: null,
    remainingPages: cuz22,
    deadline: null,
    isPrivate: false);
HatimPartModel c23 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz23,
    ownerOfPart: null,
    remainingPages: cuz23,
    deadline: null,
    isPrivate: false);
HatimPartModel c24 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz24,
    ownerOfPart: null,
    remainingPages: cuz24,
    deadline: null,
    isPrivate: false);
HatimPartModel c25 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz25,
    ownerOfPart: null,
    remainingPages: cuz25,
    deadline: null,
    isPrivate: false);
HatimPartModel c26 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.id",
    hatimName: "hatim.hatimName",
    pages: cuz26,
    ownerOfPart: null,
    remainingPages: cuz26,
    deadline: null,
    isPrivate: false);
HatimPartModel c27 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.hatimID",
    hatimName: "hatim.hatimName",
    pages: cuz27,
    ownerOfPart: null,
    remainingPages: cuz27,
    deadline: null,
    isPrivate: false);
HatimPartModel c28 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.hatimID",
    hatimName: "hatim.hatimName",
    pages: cuz28,
    ownerOfPart: null,
    remainingPages: cuz28,
    deadline: null,
    isPrivate: false);
HatimPartModel c29 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.hatimID",
    hatimName: "hatim.hatimName",
    pages: cuz29,
    ownerOfPart: null,
    remainingPages: cuz29,
    deadline: null,
    isPrivate: false);
HatimPartModel c30 = HatimPartModel(
    id: const Uuid().v4().toString(),
    hatimID: "hatim.hatimID",
    hatimName: "hatim.hatimName",
    pages: cuz30,
    ownerOfPart: null,
    remainingPages: cuz30,
    deadline: null,
    isPrivate: false);
