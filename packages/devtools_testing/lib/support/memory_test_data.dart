// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: implementation_imports
import 'dart:convert';

import 'package:devtools_app/src/utils.dart';

import 'test_utils.dart';

/// Little over a 1 minute run starting at 6:08:09 till 6:09:15
/// Contains 2 manual snapshots, 3 auto snapshots, 2 manual GCs,
/// Also contains, 3 allocation profile 2 groups of:
///     - allocation profile followed by an allocation profile reset
///     - allocation profile only
/// 70 VM GC events
/// Dart Heap capacity ~684 MB, Used ~42 MB, External 634 MB, and RSS 534 MB
/// 292 samples
/// 
/// How to create a new test data set. Run DevTools collecting stats then press
/// the Export button. Then copy the contents of the exported file and assign to
/// testHeapSampleData.
final testHeapSampleData = {
  "samples": {
    "version": 1,
    "dartDevToolsScreen": "memory",
    "data": [
      {
        "timestamp": 1595682492441,
        "rss": 329695232,
        "capacity": 202441480,
        "used": 39785240,
        "external": 153432840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181868455,
          "Java Heap": 7564,
          "Native Heap": 114220,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152680,
          "System": 3756,
          "Total": 293000
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682493087,
        "rss": 329682944,
        "capacity": 202441480,
        "used": 39785240,
        "external": 153432840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181869122,
          "Java Heap": 7512,
          "Native Heap": 114292,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152680,
          "System": 3756,
          "Total": 293020
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682493795,
        "rss": 329678848,
        "capacity": 202441480,
        "used": 39785240,
        "external": 153432840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181869813,
          "Java Heap": 7504,
          "Native Heap": 114364,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152680,
          "System": 3756,
          "Total": 293084
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682494426,
        "rss": 329940992,
        "capacity": 202441480,
        "used": 39785240,
        "external": 153432840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181870455,
          "Java Heap": 7504,
          "Native Heap": 114436,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152680,
          "System": 3756,
          "Total": 293156
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682495056,
        "rss": 329936896,
        "capacity": 202441480,
        "used": 39785240,
        "external": 153432840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181871085,
          "Java Heap": 7504,
          "Native Heap": 114508,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152680,
          "System": 3756,
          "Total": 293228
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682495693,
        "rss": 329932800,
        "capacity": 202441480,
        "used": 39785240,
        "external": 153432840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181871717,
          "Java Heap": 7504,
          "Native Heap": 114580,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152684,
          "System": 3756,
          "Total": 293304
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682496204,
        "rss": 329932800,
        "capacity": 202965768,
        "used": 38742704,
        "external": 153432840,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181871717,
          "Java Heap": 7504,
          "Native Heap": 114580,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152684,
          "System": 3756,
          "Total": 293304
        },
        "memory_eventInfo": {
          "timestamp": 1595682496189,
          "gcEvent": true,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": null
        }
      },
      {
        "timestamp": 1595682496247,
        "rss": 329932800,
        "capacity": 199079176,
        "used": 38729064,
        "external": 149546248,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181871717,
          "Java Heap": 7504,
          "Native Heap": 114580,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152684,
          "System": 3756,
          "Total": 293304
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682496448,
        "rss": 327892992,
        "capacity": 199079176,
        "used": 39253352,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181872477,
          "Java Heap": 7504,
          "Native Heap": 112164,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152696,
          "System": 3756,
          "Total": 290900
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682497085,
        "rss": 327888896,
        "capacity": 199079176,
        "used": 39253352,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181873111,
          "Java Heap": 7504,
          "Native Heap": 112236,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152696,
          "System": 3756,
          "Total": 290972
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682497706,
        "rss": 327639040,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181873739,
          "Java Heap": 7504,
          "Native Heap": 111916,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152692,
          "System": 3756,
          "Total": 290648
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682498339,
        "rss": 327634944,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181874369,
          "Java Heap": 7504,
          "Native Heap": 111988,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152696,
          "System": 3756,
          "Total": 290724
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682499681,
        "rss": 335163392,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181875717,
          "Java Heap": 7504,
          "Native Heap": 119184,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152712,
          "System": 3756,
          "Total": 297936
        },
        "memory_eventInfo": {
          "timestamp": 1595682499681,
          "gcEvent": false,
          "snapshotEvent": true,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": null
        }
      },
      {
        "timestamp": 1595682500315,
        "rss": 335159296,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181876341,
          "Java Heap": 7504,
          "Native Heap": 119256,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152712,
          "System": 3756,
          "Total": 298008
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682500974,
        "rss": 337399808,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181877001,
          "Java Heap": 7504,
          "Native Heap": 121284,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152712,
          "System": 3756,
          "Total": 300036
        },
        "memory_eventInfo": {
          "timestamp": 1595682500719,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": true,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682501605,
        "rss": 337395712,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181877631,
          "Java Heap": 7504,
          "Native Heap": 121356,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 300112
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682501906,
        "rss": 337395712,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181877631,
          "Java Heap": 7504,
          "Native Heap": 121356,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 300112
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682502206,
        "rss": 337395712,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181877631,
          "Java Heap": 7504,
          "Native Heap": 121356,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 300112
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682502248,
        "rss": 336998400,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181878261,
          "Java Heap": 7504,
          "Native Heap": 121040,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299796
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682502549,
        "rss": 336998400,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181878261,
          "Java Heap": 7504,
          "Native Heap": 121040,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299796
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682502849,
        "rss": 336998400,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181878261,
          "Java Heap": 7504,
          "Native Heap": 121040,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299796
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682502875,
        "rss": 336732160,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181878904,
          "Java Heap": 7504,
          "Native Heap": 121112,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152712,
          "System": 3756,
          "Total": 299864
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682503179,
        "rss": 336732160,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181878904,
          "Java Heap": 7504,
          "Native Heap": 121112,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152712,
          "System": 3756,
          "Total": 299864
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682503483,
        "rss": 336732160,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181878904,
          "Java Heap": 7504,
          "Native Heap": 121112,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152712,
          "System": 3756,
          "Total": 299864
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682503513,
        "rss": 336728064,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181879536,
          "Java Heap": 7504,
          "Native Heap": 120676,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299432
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682503813,
        "rss": 336728064,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181879536,
          "Java Heap": 7504,
          "Native Heap": 120676,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299432
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682504114,
        "rss": 336728064,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181879536,
          "Java Heap": 7504,
          "Native Heap": 120676,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299432
        },
        "memory_eventInfo": {
          "timestamp": 1595682504087,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": true
          }
        }
      },
      {
        "timestamp": 1595682504171,
        "rss": 338575360,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181880167,
          "Java Heap": 7504,
          "Native Heap": 120748,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299504
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682504473,
        "rss": 338575360,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181880167,
          "Java Heap": 7504,
          "Native Heap": 120748,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299504
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682504778,
        "rss": 338575360,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181880167,
          "Java Heap": 7504,
          "Native Heap": 120748,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 299504
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682504788,
        "rss": 338247680,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181880818,
          "Java Heap": 7504,
          "Native Heap": 122116,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 300872
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682505093,
        "rss": 338247680,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181880818,
          "Java Heap": 7504,
          "Native Heap": 122116,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 300872
        },
        "memory_eventInfo": {
          "timestamp": 1595682504998,
          "gcEvent": false,
          "snapshotEvent": true,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": null
        }
      },
      {
        "timestamp": 1595682505954,
        "rss": 338247680,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181880818,
          "Java Heap": 7504,
          "Native Heap": 122116,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 300872
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682506084,
        "rss": 345878528,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181882108,
          "Java Heap": 7504,
          "Native Heap": 129528,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 308284
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682506385,
        "rss": 345878528,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181882108,
          "Java Heap": 7504,
          "Native Heap": 129528,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 308284
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682506685,
        "rss": 345878528,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181882108,
          "Java Heap": 7504,
          "Native Heap": 129528,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 308284
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682506721,
        "rss": 345837568,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181882743,
          "Java Heap": 7508,
          "Native Heap": 129600,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 308360
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682507022,
        "rss": 345837568,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181882743,
          "Java Heap": 7508,
          "Native Heap": 129600,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 308360
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682507322,
        "rss": 345837568,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181882743,
          "Java Heap": 7508,
          "Native Heap": 129600,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152716,
          "System": 3756,
          "Total": 308360
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682507356,
        "rss": 345833472,
        "capacity": 199079176,
        "used": 39391848,
        "external": 149546248,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181883384,
          "Java Heap": 7504,
          "Native Heap": 129640,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152720,
          "System": 3756,
          "Total": 308400
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682507651,
        "rss": 345833472,
        "capacity": 199633464,
        "used": 40460152,
        "external": 149576248,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181883384,
          "Java Heap": 7504,
          "Native Heap": 129640,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152720,
          "System": 3756,
          "Total": 308400
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682507676,
        "rss": 345833472,
        "capacity": 199633464,
        "used": 41017584,
        "external": 149576248,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181883384,
          "Java Heap": 7504,
          "Native Heap": 129640,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152720,
          "System": 3756,
          "Total": 308400
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682507715,
        "rss": 345833472,
        "capacity": 204014344,
        "used": 40494672,
        "external": 153432840,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181883384,
          "Java Heap": 7504,
          "Native Heap": 129640,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152720,
          "System": 3756,
          "Total": 308400
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682507952,
        "rss": 345833472,
        "capacity": 207879936,
        "used": 40812248,
        "external": 157298432,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181883384,
          "Java Heap": 7504,
          "Native Heap": 129640,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152720,
          "System": 3756,
          "Total": 308400
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682508020,
        "rss": 346656768,
        "capacity": 204107344,
        "used": 41333888,
        "external": 153525840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181884034,
          "Java Heap": 7520,
          "Native Heap": 129884,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153448,
          "System": 3756,
          "Total": 309388
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682508322,
        "rss": 346656768,
        "capacity": 204107344,
        "used": 41333888,
        "external": 153525840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181884034,
          "Java Heap": 7520,
          "Native Heap": 129884,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153448,
          "System": 3756,
          "Total": 309388
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682508622,
        "rss": 346656768,
        "capacity": 204107344,
        "used": 41333888,
        "external": 153525840,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181884034,
          "Java Heap": 7520,
          "Native Heap": 129884,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153448,
          "System": 3756,
          "Total": 309388
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682508663,
        "rss": 346861568,
        "capacity": 212165528,
        "used": 41364232,
        "external": 161584024,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181884688,
          "Java Heap": 7548,
          "Native Heap": 129816,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153480,
          "System": 3756,
          "Total": 309380
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682508963,
        "rss": 346861568,
        "capacity": 212165528,
        "used": 41364232,
        "external": 161584024,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181884688,
          "Java Heap": 7548,
          "Native Heap": 129816,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153480,
          "System": 3756,
          "Total": 309380
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682509144,
        "rss": 346861568,
        "capacity": 215055640,
        "used": 41556176,
        "external": 164474136,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181884688,
          "Java Heap": 7548,
          "Native Heap": 129816,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153480,
          "System": 3756,
          "Total": 309380
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682509235,
        "rss": 346861568,
        "capacity": 213881912,
        "used": 41071232,
        "external": 164348984,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181884688,
          "Java Heap": 7548,
          "Native Heap": 129816,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153480,
          "System": 3756,
          "Total": 309380
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682509369,
        "rss": 352284672,
        "capacity": 213881912,
        "used": 41071272,
        "external": 164348984,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181885384,
          "Java Heap": 7532,
          "Native Heap": 134860,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153168,
          "System": 3756,
          "Total": 314096
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682509670,
        "rss": 352284672,
        "capacity": 213881912,
        "used": 41071272,
        "external": 164348984,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181885384,
          "Java Heap": 7532,
          "Native Heap": 134860,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153168,
          "System": 3756,
          "Total": 314096
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682509971,
        "rss": 352284672,
        "capacity": 213881912,
        "used": 41071272,
        "external": 164348984,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181885384,
          "Java Heap": 7532,
          "Native Heap": 134860,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153168,
          "System": 3756,
          "Total": 314096
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510110,
        "rss": 344522752,
        "capacity": 226313544,
        "used": 42716704,
        "external": 176780616,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181886084,
          "Java Heap": 7556,
          "Native Heap": 135188,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153220,
          "System": 3756,
          "Total": 314500
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510410,
        "rss": 344522752,
        "capacity": 226313544,
        "used": 42716704,
        "external": 176780616,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181886084,
          "Java Heap": 7556,
          "Native Heap": 135188,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153220,
          "System": 3756,
          "Total": 314500
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510451,
        "rss": 344522752,
        "capacity": 226142632,
        "used": 41212424,
        "external": 175561128,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181886084,
          "Java Heap": 7556,
          "Native Heap": 135188,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153220,
          "System": 3756,
          "Total": 314500
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510685,
        "rss": 344522752,
        "capacity": 226666920,
        "used": 40178848,
        "external": 175561128,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181886084,
          "Java Heap": 7556,
          "Native Heap": 135188,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153220,
          "System": 3756,
          "Total": 314500
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510686,
        "rss": 344522752,
        "capacity": 226696920,
        "used": 40703496,
        "external": 175591128,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181886084,
          "Java Heap": 7556,
          "Native Heap": 135188,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153220,
          "System": 3756,
          "Total": 314500
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510765,
        "rss": 344522752,
        "capacity": 226696920,
        "used": 40711544,
        "external": 175591128,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181886766,
          "Java Heap": 7532,
          "Native Heap": 109460,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153300,
          "System": 3756,
          "Total": 288828
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510769,
        "rss": 326037504,
        "capacity": 226666920,
        "used": 41213064,
        "external": 175561128,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181886766,
          "Java Heap": 7532,
          "Native Heap": 109460,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153300,
          "System": 3756,
          "Total": 288828
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510801,
        "rss": 326037504,
        "capacity": 226696920,
        "used": 40720584,
        "external": 175591128,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181886766,
          "Java Heap": 7532,
          "Native Heap": 109460,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153300,
          "System": 3756,
          "Total": 288828
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682510908,
        "rss": 326037504,
        "capacity": 226708920,
        "used": 40722672,
        "external": 175603128,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181886766,
          "Java Heap": 7532,
          "Native Heap": 109460,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153300,
          "System": 3756,
          "Total": 288828
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682511209,
        "rss": 326037504,
        "capacity": 226708920,
        "used": 40722672,
        "external": 175603128,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181886766,
          "Java Heap": 7532,
          "Native Heap": 109460,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153300,
          "System": 3756,
          "Total": 288828
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682511421,
        "rss": 328495104,
        "capacity": 233994696,
        "used": 41886496,
        "external": 182888904,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181887419,
          "Java Heap": 7544,
          "Native Heap": 112240,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153440,
          "System": 3756,
          "Total": 291760
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682511722,
        "rss": 328495104,
        "capacity": 233994696,
        "used": 41886496,
        "external": 182888904,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181887419,
          "Java Heap": 7544,
          "Native Heap": 112240,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153440,
          "System": 3756,
          "Total": 291760
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682511764,
        "rss": 328495104,
        "capacity": 249139936,
        "used": 40976152,
        "external": 198034144,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181887419,
          "Java Heap": 7544,
          "Native Heap": 112240,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153440,
          "System": 3756,
          "Total": 291760
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682512058,
        "rss": 338522112,
        "capacity": 253071256,
        "used": 41513320,
        "external": 201965464,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181888084,
          "Java Heap": 7524,
          "Native Heap": 121900,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153568,
          "System": 3756,
          "Total": 301528
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682512360,
        "rss": 338522112,
        "capacity": 253071256,
        "used": 41513320,
        "external": 201965464,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181888084,
          "Java Heap": 7524,
          "Native Heap": 121900,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153568,
          "System": 3756,
          "Total": 301528
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682512660,
        "rss": 338522112,
        "capacity": 253071256,
        "used": 41513320,
        "external": 201965464,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181888084,
          "Java Heap": 7524,
          "Native Heap": 121900,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153568,
          "System": 3756,
          "Total": 301528
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682512697,
        "rss": 338714624,
        "capacity": 253071256,
        "used": 41513320,
        "external": 201965464,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181888718,
          "Java Heap": 7504,
          "Native Heap": 121972,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153568,
          "System": 3756,
          "Total": 301580
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682512998,
        "rss": 338714624,
        "capacity": 253071256,
        "used": 41513320,
        "external": 201965464,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181888718,
          "Java Heap": 7504,
          "Native Heap": 121972,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153568,
          "System": 3756,
          "Total": 301580
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513298,
        "rss": 338714624,
        "capacity": 253071256,
        "used": 41513320,
        "external": 201965464,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181888718,
          "Java Heap": 7504,
          "Native Heap": 121972,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153568,
          "System": 3756,
          "Total": 301580
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513330,
        "rss": 338710528,
        "capacity": 253071256,
        "used": 41513320,
        "external": 201965464,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513376,
        "rss": 338710528,
        "capacity": 253071256,
        "used": 41544232,
        "external": 201965464,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513382,
        "rss": 338710528,
        "capacity": 253071256,
        "used": 41024360,
        "external": 201965464,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513407,
        "rss": 338710528,
        "capacity": 253071256,
        "used": 41024808,
        "external": 201965464,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513450,
        "rss": 338710528,
        "capacity": 253071256,
        "used": 41038104,
        "external": 201965464,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513527,
        "rss": 338710528,
        "capacity": 253071256,
        "used": 41045424,
        "external": 201965464,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513644,
        "rss": 338710528,
        "capacity": 256927848,
        "used": 41047856,
        "external": 205822056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513684,
        "rss": 338710528,
        "capacity": 256936848,
        "used": 41051384,
        "external": 205831056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513738,
        "rss": 338710528,
        "capacity": 256936848,
        "used": 41051824,
        "external": 205831056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513792,
        "rss": 338710528,
        "capacity": 256936848,
        "used": 41052224,
        "external": 205831056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513839,
        "rss": 338710528,
        "capacity": 256936848,
        "used": 41052624,
        "external": 205831056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682513936,
        "rss": 338710528,
        "capacity": 256936848,
        "used": 41053104,
        "external": 205831056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181889356,
          "Java Heap": 7504,
          "Native Heap": 121968,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153564,
          "System": 3756,
          "Total": 301572
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514010,
        "rss": 336048128,
        "capacity": 256936848,
        "used": 41052624,
        "external": 205831056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181890005,
          "Java Heap": 7552,
          "Native Heap": 118952,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153636,
          "System": 3792,
          "Total": 298712
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514310,
        "rss": 336048128,
        "capacity": 256936848,
        "used": 41052624,
        "external": 205831056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181890005,
          "Java Heap": 7552,
          "Native Heap": 118952,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153636,
          "System": 3792,
          "Total": 298712
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514316,
        "rss": 336048128,
        "capacity": 256936848,
        "used": 41064152,
        "external": 205831056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181890005,
          "Java Heap": 7552,
          "Native Heap": 118952,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153636,
          "System": 3792,
          "Total": 298712
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514617,
        "rss": 336048128,
        "capacity": 256936848,
        "used": 41064152,
        "external": 205831056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181890005,
          "Java Heap": 7552,
          "Native Heap": 118952,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153636,
          "System": 3792,
          "Total": 298712
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514643,
        "rss": 336175104,
        "capacity": 256936848,
        "used": 41064192,
        "external": 205831056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181890672,
          "Java Heap": 7528,
          "Native Heap": 118832,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153652,
          "System": 3792,
          "Total": 298584
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514777,
        "rss": 336175104,
        "capacity": 256936848,
        "used": 41067816,
        "external": 205831056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181890672,
          "Java Heap": 7528,
          "Native Heap": 118832,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153652,
          "System": 3792,
          "Total": 298584
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514816,
        "rss": 336175104,
        "capacity": 260793440,
        "used": 41072264,
        "external": 209687648,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181890672,
          "Java Heap": 7528,
          "Native Heap": 118832,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153652,
          "System": 3792,
          "Total": 298584
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514895,
        "rss": 336175104,
        "capacity": 260793440,
        "used": 41073920,
        "external": 209687648,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181890672,
          "Java Heap": 7528,
          "Native Heap": 118832,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153652,
          "System": 3792,
          "Total": 298584
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682514957,
        "rss": 336175104,
        "capacity": 260802440,
        "used": 41076688,
        "external": 209696648,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181890672,
          "Java Heap": 7528,
          "Native Heap": 118832,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153652,
          "System": 3792,
          "Total": 298584
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682515257,
        "rss": 336175104,
        "capacity": 260802440,
        "used": 41076688,
        "external": 209696648,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181890672,
          "Java Heap": 7528,
          "Native Heap": 118832,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153652,
          "System": 3792,
          "Total": 298584
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682515298,
        "rss": 335724544,
        "capacity": 260922440,
        "used": 41610568,
        "external": 209816648,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181891307,
          "Java Heap": 7548,
          "Native Heap": 118564,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153672,
          "System": 3792,
          "Total": 298356
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682515599,
        "rss": 335724544,
        "capacity": 260922440,
        "used": 41610568,
        "external": 209816648,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181891307,
          "Java Heap": 7548,
          "Native Heap": 118564,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153672,
          "System": 3792,
          "Total": 298356
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682515688,
        "rss": 335724544,
        "capacity": 268638872,
        "used": 41115880,
        "external": 217533080,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181891307,
          "Java Heap": 7548,
          "Native Heap": 118564,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153672,
          "System": 3792,
          "Total": 298356
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682515987,
        "rss": 341716992,
        "capacity": 268638872,
        "used": 41115920,
        "external": 217533080,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181891963,
          "Java Heap": 7532,
          "Native Heap": 124228,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153700,
          "System": 3792,
          "Total": 304032
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682516287,
        "rss": 341716992,
        "capacity": 268638872,
        "used": 41115920,
        "external": 217533080,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181891963,
          "Java Heap": 7532,
          "Native Heap": 124228,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153700,
          "System": 3792,
          "Total": 304032
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682516588,
        "rss": 341716992,
        "capacity": 268638872,
        "used": 41115920,
        "external": 217533080,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181891963,
          "Java Heap": 7532,
          "Native Heap": 124228,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153700,
          "System": 3792,
          "Total": 304032
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682516729,
        "rss": 339648512,
        "capacity": 269391848,
        "used": 42744144,
        "external": 218286056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181892655,
          "Java Heap": 7556,
          "Native Heap": 121828,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153756,
          "System": 3822,
          "Total": 301742
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682517030,
        "rss": 339648512,
        "capacity": 269391848,
        "used": 42744144,
        "external": 218286056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181892655,
          "Java Heap": 7556,
          "Native Heap": 121828,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153756,
          "System": 3822,
          "Total": 301742
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682517331,
        "rss": 339648512,
        "capacity": 269391848,
        "used": 42744144,
        "external": 218286056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181892655,
          "Java Heap": 7556,
          "Native Heap": 121828,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153756,
          "System": 3822,
          "Total": 301742
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682517626,
        "rss": 424865792,
        "capacity": 273658168,
        "used": 47117616,
        "external": 221053240,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181893544,
          "Java Heap": 7552,
          "Native Heap": 165836,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156396,
          "System": 3826,
          "Total": 348390
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682517675,
        "rss": 424865792,
        "capacity": 343303000,
        "used": 43457536,
        "external": 290206552,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181893544,
          "Java Heap": 7552,
          "Native Heap": 165836,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156396,
          "System": 3826,
          "Total": 348390
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682517678,
        "rss": 424865792,
        "capacity": 343304080,
        "used": 43636952,
        "external": 290207632,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181893544,
          "Java Heap": 7552,
          "Native Heap": 165836,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156396,
          "System": 3826,
          "Total": 348390
        },
        "memory_eventInfo": {
          "timestamp": 1595682517677,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": true,
          "allocationAccumulatorEvent": null
        }
      },
      {
        "timestamp": 1595682517734,
        "rss": 424865792,
        "capacity": 396981672,
        "used": 42682400,
        "external": 343885224,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181893544,
          "Java Heap": 7552,
          "Native Heap": 165836,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156396,
          "System": 3826,
          "Total": 348390
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682517735,
        "rss": 424865792,
        "capacity": 358038968,
        "used": 40487608,
        "external": 306408888,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181893544,
          "Java Heap": 7552,
          "Native Heap": 165836,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156396,
          "System": 3826,
          "Total": 348390
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682518878,
        "rss": 424865792,
        "capacity": 432908656,
        "used": 43829160,
        "external": 378739056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181893544,
          "Java Heap": 7552,
          "Native Heap": 165836,
          "Code": 14728,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156396,
          "System": 3826,
          "Total": 348390
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682519029,
        "rss": 496730112,
        "capacity": 432908656,
        "used": 43829200,
        "external": 378739056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181895059,
          "Java Heap": 7516,
          "Native Heap": 280124,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156292,
          "System": 3538,
          "Total": 456798
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682519330,
        "rss": 496730112,
        "capacity": 432908656,
        "used": 43829200,
        "external": 378739056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181895059,
          "Java Heap": 7516,
          "Native Heap": 280124,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156292,
          "System": 3538,
          "Total": 456798
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682519631,
        "rss": 496730112,
        "capacity": 432908656,
        "used": 43829200,
        "external": 378739056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181895059,
          "Java Heap": 7516,
          "Native Heap": 280124,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156292,
          "System": 3538,
          "Total": 456798
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682519664,
        "rss": 496726016,
        "capacity": 432908656,
        "used": 43829200,
        "external": 378739056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181895691,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682519965,
        "rss": 496726016,
        "capacity": 432908656,
        "used": 43829200,
        "external": 378739056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181895691,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682520266,
        "rss": 496726016,
        "capacity": 432908656,
        "used": 43829200,
        "external": 378739056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181895691,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682520297,
        "rss": 443445248,
        "capacity": 432908656,
        "used": 43829200,
        "external": 378739056,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682520399,
        "rss": 443445248,
        "capacity": 432908688,
        "used": 43508112,
        "external": 378739088,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682520542,
        "rss": 443445248,
        "capacity": 432950656,
        "used": 43009752,
        "external": 378781056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682520581,
        "rss": 443445248,
        "capacity": 432980656,
        "used": 44061800,
        "external": 378811056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682520605,
        "rss": 443445248,
        "capacity": 432980656,
        "used": 43548904,
        "external": 378811056,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682520666,
        "rss": 443445248,
        "capacity": 455176160,
        "used": 43549344,
        "external": 401006560,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682521644,
        "rss": 443445248,
        "capacity": 455185160,
        "used": 43551296,
        "external": 401015560,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": 1595682521644,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": true,
          "allocationAccumulatorEvent": null
        }
      },
      {
        "timestamp": 1595682521645,
        "rss": 443445248,
        "capacity": 503281752,
        "used": 44080928,
        "external": 449112152,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682521645,
        "rss": 443445248,
        "capacity": 503281696,
        "used": 44082736,
        "external": 449112096,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682521653,
        "rss": 443445248,
        "capacity": 503326664,
        "used": 43046704,
        "external": 449157064,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682521784,
        "rss": 443445248,
        "capacity": 421908384,
        "used": 40309768,
        "external": 371851168,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181896323,
          "Java Heap": 7504,
          "Native Heap": 280196,
          "Code": 9276,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156296,
          "System": 3538,
          "Total": 456862
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682521788,
        "rss": 447680512,
        "capacity": 455239160,
        "used": 43550184,
        "external": 401069560,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181897780,
          "Java Heap": 7576,
          "Native Heap": 235244,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 154532,
          "System": 3538,
          "Total": 410286
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682522089,
        "rss": 447680512,
        "capacity": 455239160,
        "used": 43550184,
        "external": 401069560,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181897780,
          "Java Heap": 7576,
          "Native Heap": 235244,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 154532,
          "System": 3538,
          "Total": 410286
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682522390,
        "rss": 447680512,
        "capacity": 455239160,
        "used": 43550184,
        "external": 401069560,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181897780,
          "Java Heap": 7576,
          "Native Heap": 235244,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 154532,
          "System": 3538,
          "Total": 410286
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682522405,
        "rss": 422363136,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181898437,
          "Java Heap": 7512,
          "Native Heap": 210536,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384362
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682522706,
        "rss": 422363136,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181898437,
          "Java Heap": 7512,
          "Native Heap": 210536,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384362
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682523007,
        "rss": 422363136,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181898437,
          "Java Heap": 7512,
          "Native Heap": 210536,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384362
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682523020,
        "rss": 422359040,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181899053,
          "Java Heap": 7504,
          "Native Heap": 210536,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384354
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682523322,
        "rss": 422359040,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181899053,
          "Java Heap": 7504,
          "Native Heap": 210536,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384354
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682523622,
        "rss": 422359040,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181899053,
          "Java Heap": 7504,
          "Native Heap": 210536,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384354
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682523648,
        "rss": 422354944,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181899670,
          "Java Heap": 7504,
          "Native Heap": 210552,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384370
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682523948,
        "rss": 422354944,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181899670,
          "Java Heap": 7504,
          "Native Heap": 210552,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 384370
        },
        "memory_eventInfo": {
          "timestamp": 1595682523655,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": true,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682524275,
        "rss": 423596032,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181900305,
          "Java Heap": 7504,
          "Native Heap": 211784,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 385602
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682524576,
        "rss": 423596032,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181900305,
          "Java Heap": 7504,
          "Native Heap": 211784,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 385602
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682524876,
        "rss": 423596032,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181900305,
          "Java Heap": 7504,
          "Native Heap": 211784,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153380,
          "System": 3538,
          "Total": 385602
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682524942,
        "rss": 423596032,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181900962,
          "Java Heap": 7504,
          "Native Heap": 211856,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153384,
          "System": 3538,
          "Total": 385678
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682525242,
        "rss": 423596032,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181900962,
          "Java Heap": 7504,
          "Native Heap": 211856,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153384,
          "System": 3538,
          "Total": 385678
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682525543,
        "rss": 423596032,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181900962,
          "Java Heap": 7504,
          "Native Heap": 211856,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153384,
          "System": 3538,
          "Total": 385678
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682525583,
        "rss": 423272448,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181901610,
          "Java Heap": 7508,
          "Native Heap": 211552,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153388,
          "System": 3538,
          "Total": 385382
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682525883,
        "rss": 423272448,
        "capacity": 421908384,
        "used": 40834096,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181901610,
          "Java Heap": 7508,
          "Native Heap": 211552,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153388,
          "System": 3538,
          "Total": 385382
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682525980,
        "rss": 423272448,
        "capacity": 422432672,
        "used": 40310048,
        "external": 371851168,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181901610,
          "Java Heap": 7508,
          "Native Heap": 211552,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153388,
          "System": 3538,
          "Total": 385382
        },
        "memory_eventInfo": {
          "timestamp": 1595682525974,
          "gcEvent": true,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": null
        }
      },
      {
        "timestamp": 1595682526029,
        "rss": 423272448,
        "capacity": 422432672,
        "used": 40310008,
        "external": 371851168,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181901610,
          "Java Heap": 7508,
          "Native Heap": 211552,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153388,
          "System": 3538,
          "Total": 385382
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682526216,
        "rss": 425201664,
        "capacity": 422432672,
        "used": 40834296,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181902249,
          "Java Heap": 7504,
          "Native Heap": 213436,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387266
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682526516,
        "rss": 425201664,
        "capacity": 422432672,
        "used": 40834296,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181902249,
          "Java Heap": 7504,
          "Native Heap": 213436,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387266
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682526818,
        "rss": 425201664,
        "capacity": 422432672,
        "used": 40834296,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181902249,
          "Java Heap": 7504,
          "Native Heap": 213436,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387266
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682526848,
        "rss": 425058304,
        "capacity": 422432672,
        "used": 40834672,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181902870,
          "Java Heap": 7504,
          "Native Heap": 213116,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 386946
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682527148,
        "rss": 425058304,
        "capacity": 422432672,
        "used": 40834672,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181902870,
          "Java Heap": 7504,
          "Native Heap": 213116,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 386946
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682527449,
        "rss": 425058304,
        "capacity": 422432672,
        "used": 40834672,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181902870,
          "Java Heap": 7504,
          "Native Heap": 213116,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 386946
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682527479,
        "rss": 425054208,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181903503,
          "Java Heap": 7504,
          "Native Heap": 213204,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387034
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682527780,
        "rss": 425054208,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181903503,
          "Java Heap": 7504,
          "Native Heap": 213204,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387034
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682528080,
        "rss": 425054208,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181903503,
          "Java Heap": 7504,
          "Native Heap": 213204,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387034
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682528123,
        "rss": 425050112,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181904137,
          "Java Heap": 7504,
          "Native Heap": 213276,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387106
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682528423,
        "rss": 425050112,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181904137,
          "Java Heap": 7504,
          "Native Heap": 213276,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387106
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682528725,
        "rss": 425050112,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181904137,
          "Java Heap": 7504,
          "Native Heap": 213276,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387106
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682528741,
        "rss": 425046016,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181904778,
          "Java Heap": 7504,
          "Native Heap": 213352,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387182
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682529041,
        "rss": 425046016,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181904778,
          "Java Heap": 7504,
          "Native Heap": 213352,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387182
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682529377,
        "rss": 425046016,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181904778,
          "Java Heap": 7504,
          "Native Heap": 213352,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387182
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682529510,
        "rss": 425308160,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181905542,
          "Java Heap": 7504,
          "Native Heap": 213424,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153388,
          "System": 3538,
          "Total": 387250
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682529811,
        "rss": 425308160,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181905542,
          "Java Heap": 7504,
          "Native Heap": 213424,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153388,
          "System": 3538,
          "Total": 387250
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682530112,
        "rss": 425308160,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181905542,
          "Java Heap": 7504,
          "Native Heap": 213424,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153388,
          "System": 3538,
          "Total": 387250
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682530147,
        "rss": 425345024,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181906169,
          "Java Heap": 7504,
          "Native Heap": 213492,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387322
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682530447,
        "rss": 425345024,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181906169,
          "Java Heap": 7504,
          "Native Heap": 213492,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387322
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682530748,
        "rss": 425345024,
        "capacity": 422432672,
        "used": 40835128,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181906169,
          "Java Heap": 7504,
          "Native Heap": 213492,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 387322
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682530779,
        "rss": 424706048,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181906796,
          "Java Heap": 7504,
          "Native Heap": 212944,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 386774
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682531080,
        "rss": 424706048,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181906796,
          "Java Heap": 7504,
          "Native Heap": 212944,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 386774
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682531381,
        "rss": 424706048,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181906796,
          "Java Heap": 7504,
          "Native Heap": 212944,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 386774
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682531414,
        "rss": 424701952,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181907441,
          "Java Heap": 7504,
          "Native Heap": 213020,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 386854
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682531715,
        "rss": 424701952,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181907441,
          "Java Heap": 7504,
          "Native Heap": 213020,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 386854
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682532016,
        "rss": 424701952,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181907441,
          "Java Heap": 7504,
          "Native Heap": 213020,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 386854
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682532046,
        "rss": 424964096,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181908064,
          "Java Heap": 7504,
          "Native Heap": 213092,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 386926
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682532346,
        "rss": 424964096,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181908064,
          "Java Heap": 7504,
          "Native Heap": 213092,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 386926
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682532664,
        "rss": 424964096,
        "capacity": 422432672,
        "used": 40835504,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181908064,
          "Java Heap": 7504,
          "Native Heap": 213092,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 386926
        },
        "memory_eventInfo": {
          "timestamp": 1595682532446,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": true
          }
        }
      },
      {
        "timestamp": 1595682532807,
        "rss": 426835968,
        "capacity": 422432672,
        "used": 40835880,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181908833,
          "Java Heap": 7504,
          "Native Heap": 215124,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388958
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682533109,
        "rss": 426835968,
        "capacity": 422432672,
        "used": 40835880,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181908833,
          "Java Heap": 7504,
          "Native Heap": 215124,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388958
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682533411,
        "rss": 426835968,
        "capacity": 422432672,
        "used": 40835880,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181908833,
          "Java Heap": 7504,
          "Native Heap": 215124,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388958
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682533443,
        "rss": 426610688,
        "capacity": 422432672,
        "used": 40836256,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181909465,
          "Java Heap": 7504,
          "Native Heap": 214748,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388582
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682533744,
        "rss": 426610688,
        "capacity": 422432672,
        "used": 40836256,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181909465,
          "Java Heap": 7504,
          "Native Heap": 214748,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388582
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682534051,
        "rss": 426610688,
        "capacity": 422432672,
        "used": 40836256,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181909465,
          "Java Heap": 7504,
          "Native Heap": 214748,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388582
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682534081,
        "rss": 426606592,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181910100,
          "Java Heap": 7504,
          "Native Heap": 214820,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388654
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682534381,
        "rss": 426606592,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181910100,
          "Java Heap": 7504,
          "Native Heap": 214820,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388654
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682534682,
        "rss": 426606592,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181910100,
          "Java Heap": 7504,
          "Native Heap": 214820,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388654
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682534717,
        "rss": 426602496,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181910743,
          "Java Heap": 7504,
          "Native Heap": 214904,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 388734
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682535017,
        "rss": 426602496,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181910743,
          "Java Heap": 7504,
          "Native Heap": 214904,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 388734
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682535318,
        "rss": 426602496,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181910743,
          "Java Heap": 7504,
          "Native Heap": 214904,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153392,
          "System": 3538,
          "Total": 388734
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682535393,
        "rss": 426864640,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181911423,
          "Java Heap": 7504,
          "Native Heap": 214976,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388810
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682535694,
        "rss": 426864640,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181911423,
          "Java Heap": 7504,
          "Native Heap": 214976,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388810
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682535995,
        "rss": 426864640,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181911423,
          "Java Heap": 7504,
          "Native Heap": 214976,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388810
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682536031,
        "rss": 426860544,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181912050,
          "Java Heap": 7504,
          "Native Heap": 215048,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388882
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682536331,
        "rss": 426860544,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181912050,
          "Java Heap": 7504,
          "Native Heap": 215048,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388882
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682536632,
        "rss": 426860544,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181912050,
          "Java Heap": 7504,
          "Native Heap": 215048,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388882
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682536663,
        "rss": 426856448,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181912689,
          "Java Heap": 7504,
          "Native Heap": 215124,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388958
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682536964,
        "rss": 426856448,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181912689,
          "Java Heap": 7504,
          "Native Heap": 215124,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388958
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682537265,
        "rss": 426856448,
        "capacity": 422432672,
        "used": 40836632,
        "external": 371851168,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181912689,
          "Java Heap": 7504,
          "Native Heap": 215124,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153396,
          "System": 3538,
          "Total": 388958
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682537410,
        "rss": 430829568,
        "capacity": 422783800,
        "used": 41930272,
        "external": 372202296,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181913380,
          "Java Heap": 7532,
          "Native Heap": 218560,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153444,
          "System": 3538,
          "Total": 392470
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682537710,
        "rss": 430829568,
        "capacity": 422783800,
        "used": 41930272,
        "external": 372202296,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181913380,
          "Java Heap": 7532,
          "Native Heap": 218560,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153444,
          "System": 3538,
          "Total": 392470
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538011,
        "rss": 430829568,
        "capacity": 422783800,
        "used": 41930272,
        "external": 372202296,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181913380,
          "Java Heap": 7532,
          "Native Heap": 218560,
          "Code": 9344,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153444,
          "System": 3538,
          "Total": 392470
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538083,
        "rss": 427892736,
        "capacity": 424002448,
        "used": 43616424,
        "external": 373420944,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181914096,
          "Java Heap": 7544,
          "Native Heap": 215972,
          "Code": 9448,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153592,
          "System": 3538,
          "Total": 390146
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538383,
        "rss": 427892736,
        "capacity": 424002448,
        "used": 43616424,
        "external": 373420944,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181914096,
          "Java Heap": 7544,
          "Native Heap": 215972,
          "Code": 9448,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153592,
          "System": 3538,
          "Total": 390146
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538603,
        "rss": 427892736,
        "capacity": 463750824,
        "used": 42841944,
        "external": 411104936,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914096,
          "Java Heap": 7544,
          "Native Heap": 215972,
          "Code": 9448,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153592,
          "System": 3538,
          "Total": 390146
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538632,
        "rss": 427892736,
        "capacity": 464274424,
        "used": 43472312,
        "external": 411104248,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914096,
          "Java Heap": 7544,
          "Native Heap": 215972,
          "Code": 9448,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153592,
          "System": 3538,
          "Total": 390146
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538633,
        "rss": 427892736,
        "capacity": 502354952,
        "used": 42955376,
        "external": 449184776,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914096,
          "Java Heap": 7544,
          "Native Heap": 215972,
          "Code": 9448,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153592,
          "System": 3538,
          "Total": 390146
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538633,
        "rss": 427892736,
        "capacity": 502354928,
        "used": 42431728,
        "external": 449184752,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914096,
          "Java Heap": 7544,
          "Native Heap": 215972,
          "Code": 9448,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 153592,
          "System": 3538,
          "Total": 390146
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538839,
        "rss": 488157184,
        "capacity": 502418152,
        "used": 42956936,
        "external": 449247976,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682538887,
        "rss": 488157184,
        "capacity": 502541272,
        "used": 43050776,
        "external": 449371096,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539188,
        "rss": 488157184,
        "capacity": 502541272,
        "used": 43050776,
        "external": 449371096,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539452,
        "rss": 488157184,
        "capacity": 512360944,
        "used": 44148008,
        "external": 458437104,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539652,
        "rss": 488157184,
        "capacity": 602320064,
        "used": 44699128,
        "external": 547871936,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539653,
        "rss": 488157184,
        "capacity": 602843664,
        "used": 44436656,
        "external": 547871248,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539706,
        "rss": 488157184,
        "capacity": 464265648,
        "used": 41243120,
        "external": 411062704,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539707,
        "rss": 488157184,
        "capacity": 553701728,
        "used": 42291696,
        "external": 500498784,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539723,
        "rss": 488157184,
        "capacity": 553701672,
        "used": 41767584,
        "external": 500498728,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181914787,
          "Java Heap": 7536,
          "Native Heap": 272704,
          "Code": 9716,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155472,
          "System": 3538,
          "Total": 449018
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682539763,
        "rss": 571727872,
        "capacity": 513043592,
        "used": 45452760,
        "external": 459119752,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181915758,
          "Java Heap": 7544,
          "Native Heap": 372792,
          "Code": 6904,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155608,
          "System": 1494,
          "Total": 544394
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682540063,
        "rss": 571727872,
        "capacity": 513043592,
        "used": 45452760,
        "external": 459119752,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181915758,
          "Java Heap": 7544,
          "Native Heap": 372792,
          "Code": 6904,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155608,
          "System": 1494,
          "Total": 544394
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682540630,
        "rss": 571727872,
        "capacity": 513043592,
        "used": 45452760,
        "external": 459119752,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181915758,
          "Java Heap": 7544,
          "Native Heap": 372792,
          "Code": 6904,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 155608,
          "System": 1494,
          "Total": 544394
        },
        "memory_eventInfo": {
          "timestamp": 1595682540206,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": true,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682540908,
        "rss": 571727872,
        "capacity": 636414768,
        "used": 46165240,
        "external": 581671728,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181916861,
          "Java Heap": 7572,
          "Native Heap": 288164,
          "Code": 7224,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 157032,
          "System": 1512,
          "Total": 461556
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682540909,
        "rss": 571727872,
        "capacity": 637990344,
        "used": 46731152,
        "external": 581674440,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181916861,
          "Java Heap": 7572,
          "Native Heap": 288164,
          "Code": 7224,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 157032,
          "System": 1512,
          "Total": 461556
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682540909,
        "rss": 539840512,
        "capacity": 579762592,
        "used": 45558248,
        "external": 526064032,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181916861,
          "Java Heap": 7572,
          "Native Heap": 288164,
          "Code": 7224,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 157032,
          "System": 1512,
          "Total": 461556
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682540911,
        "rss": 539840512,
        "capacity": 636425496,
        "used": 43391608,
        "external": 581649688,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181916861,
          "Java Heap": 7572,
          "Native Heap": 288164,
          "Code": 7224,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 157032,
          "System": 1512,
          "Total": 461556
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682541213,
        "rss": 539840512,
        "capacity": 636425496,
        "used": 43391608,
        "external": 581649688,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181916861,
          "Java Heap": 7572,
          "Native Heap": 288164,
          "Code": 7224,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 157032,
          "System": 1512,
          "Total": 461556
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682541514,
        "rss": 539840512,
        "capacity": 636425496,
        "used": 43391608,
        "external": 581649688,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181916861,
          "Java Heap": 7572,
          "Native Heap": 288164,
          "Code": 7224,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 157032,
          "System": 1512,
          "Total": 461556
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682541652,
        "rss": 495013888,
        "capacity": 637654944,
        "used": 44504968,
        "external": 582354848,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181917641,
          "Java Heap": 7548,
          "Native Heap": 295544,
          "Code": 7308,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156188,
          "System": 1512,
          "Total": 468152
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682541947,
        "rss": 495013888,
        "capacity": 637474360,
        "used": 43758392,
        "external": 581649976,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181917641,
          "Java Heap": 7548,
          "Native Heap": 295544,
          "Code": 7308,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156188,
          "System": 1512,
          "Total": 468152
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682542031,
        "rss": 495013888,
        "capacity": 637477360,
        "used": 44294824,
        "external": 581652976,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181917641,
          "Java Heap": 7548,
          "Native Heap": 295544,
          "Code": 7308,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156188,
          "System": 1512,
          "Total": 468152
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682542220,
        "rss": 495013888,
        "capacity": 637477360,
        "used": 44510072,
        "external": 581652976,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181917641,
          "Java Heap": 7548,
          "Native Heap": 295544,
          "Code": 7308,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156188,
          "System": 1512,
          "Total": 468152
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682542364,
        "rss": 503357440,
        "capacity": 637723984,
        "used": 44834112,
        "external": 581899600,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181918353,
          "Java Heap": 7544,
          "Native Heap": 295052,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156744,
          "System": 1512,
          "Total": 468636
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682542431,
        "rss": 503357440,
        "capacity": 646101536,
        "used": 48899336,
        "external": 585701920,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181918353,
          "Java Heap": 7544,
          "Native Heap": 295052,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156744,
          "System": 1512,
          "Total": 468636
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682542490,
        "rss": 503357440,
        "capacity": 636277424,
        "used": 41004448,
        "external": 585695920,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181918353,
          "Java Heap": 7544,
          "Native Heap": 295052,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156744,
          "System": 1512,
          "Total": 468636
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682542724,
        "rss": 503357440,
        "capacity": 684801744,
        "used": 40482760,
        "external": 633695952,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181918353,
          "Java Heap": 7544,
          "Native Heap": 295052,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156744,
          "System": 1512,
          "Total": 468636
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682543824,
        "rss": 503357440,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": true,
        "adb_memoryInfo": {
          "Realtime": 181918353,
          "Java Heap": 7544,
          "Native Heap": 295052,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 156744,
          "System": 1512,
          "Total": 468636
        },
        "memory_eventInfo": {
          "timestamp": 1595682543824,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": true,
          "allocationAccumulatorEvent": null
        }
      },
      {
        "timestamp": 1595682543932,
        "rss": 534048768,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181919964,
          "Java Heap": 7512,
          "Native Heap": 337004,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506260
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682544233,
        "rss": 534048768,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181919964,
          "Java Heap": 7512,
          "Native Heap": 337004,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506260
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682544534,
        "rss": 534048768,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181919964,
          "Java Heap": 7512,
          "Native Heap": 337004,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506260
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682544564,
        "rss": 534044672,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181920589,
          "Java Heap": 7504,
          "Native Heap": 337076,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506325
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682544864,
        "rss": 534044672,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181920589,
          "Java Heap": 7504,
          "Native Heap": 337076,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506325
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682545165,
        "rss": 534044672,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181920589,
          "Java Heap": 7504,
          "Native Heap": 337076,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506325
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682545191,
        "rss": 533749760,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181921213,
          "Java Heap": 7504,
          "Native Heap": 336864,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152444,
          "System": 1512,
          "Total": 506108
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682545492,
        "rss": 533749760,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181921213,
          "Java Heap": 7504,
          "Native Heap": 336864,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152444,
          "System": 1512,
          "Total": 506108
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682545793,
        "rss": 533749760,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181921213,
          "Java Heap": 7504,
          "Native Heap": 336864,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152444,
          "System": 1512,
          "Total": 506108
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682545825,
        "rss": 533745664,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181921849,
          "Java Heap": 7504,
          "Native Heap": 336936,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506184
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682546131,
        "rss": 533745664,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181921849,
          "Java Heap": 7504,
          "Native Heap": 336936,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506184
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682546431,
        "rss": 533745664,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181922468,
          "Java Heap": 7504,
          "Native Heap": 336952,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506201
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682546434,
        "rss": 533950464,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181922468,
          "Java Heap": 7504,
          "Native Heap": 336952,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506201
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682546739,
        "rss": 533950464,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181922468,
          "Java Heap": 7504,
          "Native Heap": 336952,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506201
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682547039,
        "rss": 533950464,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181922468,
          "Java Heap": 7504,
          "Native Heap": 336952,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506201
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682547081,
        "rss": 533946368,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181923096,
          "Java Heap": 7504,
          "Native Heap": 337024,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506272
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682547382,
        "rss": 533946368,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181923096,
          "Java Heap": 7504,
          "Native Heap": 337024,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506272
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682547683,
        "rss": 533946368,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181923096,
          "Java Heap": 7504,
          "Native Heap": 337024,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506272
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682547712,
        "rss": 533942272,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181923737,
          "Java Heap": 7504,
          "Native Heap": 337096,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506345
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682548013,
        "rss": 533942272,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181923737,
          "Java Heap": 7504,
          "Native Heap": 337096,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506345
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682548314,
        "rss": 533942272,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181923737,
          "Java Heap": 7504,
          "Native Heap": 337096,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506345
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682548345,
        "rss": 533938176,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181924364,
          "Java Heap": 7504,
          "Native Heap": 337168,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506416
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682548645,
        "rss": 533938176,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181924364,
          "Java Heap": 7504,
          "Native Heap": 337168,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506416
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682548947,
        "rss": 533938176,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181924364,
          "Java Heap": 7504,
          "Native Heap": 337168,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506416
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682548982,
        "rss": 533934080,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181925008,
          "Java Heap": 7504,
          "Native Heap": 337168,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506416
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682549282,
        "rss": 533934080,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181925008,
          "Java Heap": 7504,
          "Native Heap": 337168,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506416
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682549583,
        "rss": 533934080,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181925008,
          "Java Heap": 7504,
          "Native Heap": 337168,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506416
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682549611,
        "rss": 534048768,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181925641,
          "Java Heap": 7504,
          "Native Heap": 337092,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506340
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682549912,
        "rss": 534048768,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181925641,
          "Java Heap": 7504,
          "Native Heap": 337092,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506340
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682550212,
        "rss": 534048768,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181925641,
          "Java Heap": 7504,
          "Native Heap": 337092,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1512,
          "Total": 506340
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682550251,
        "rss": 534044672,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181926272,
          "Java Heap": 7504,
          "Native Heap": 337164,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506413
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682550551,
        "rss": 534044672,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181926272,
          "Java Heap": 7504,
          "Native Heap": 337164,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506413
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682550860,
        "rss": 534044672,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181926272,
          "Java Heap": 7504,
          "Native Heap": 337164,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1513,
          "Total": 506413
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682550899,
        "rss": 534224896,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181926911,
          "Java Heap": 7504,
          "Native Heap": 337220,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506473
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682551199,
        "rss": 534224896,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181926911,
          "Java Heap": 7504,
          "Native Heap": 337220,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506473
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682551500,
        "rss": 534224896,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181926911,
          "Java Heap": 7504,
          "Native Heap": 337220,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506473
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682551534,
        "rss": 534220800,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181927558,
          "Java Heap": 7504,
          "Native Heap": 337292,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506544
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682551834,
        "rss": 534220800,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181927558,
          "Java Heap": 7504,
          "Native Heap": 337292,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506544
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682552229,
        "rss": 534220800,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181927558,
          "Java Heap": 7504,
          "Native Heap": 337292,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506544
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682552235,
        "rss": 534216704,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181928184,
          "Java Heap": 7504,
          "Native Heap": 337364,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506617
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682552535,
        "rss": 534216704,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181928184,
          "Java Heap": 7504,
          "Native Heap": 337364,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506617
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682552836,
        "rss": 534216704,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181928184,
          "Java Heap": 7504,
          "Native Heap": 337364,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506617
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682552869,
        "rss": 534212608,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181928897,
          "Java Heap": 7504,
          "Native Heap": 337436,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506689
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682553169,
        "rss": 534212608,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181928897,
          "Java Heap": 7504,
          "Native Heap": 337436,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506689
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682553470,
        "rss": 534212608,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181928897,
          "Java Heap": 7504,
          "Native Heap": 337436,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506689
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682553510,
        "rss": 534474752,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181929537,
          "Java Heap": 7504,
          "Native Heap": 337508,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506760
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682553811,
        "rss": 534474752,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181929537,
          "Java Heap": 7504,
          "Native Heap": 337508,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506760
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682554112,
        "rss": 534474752,
        "capacity": 684301456,
        "used": 41531640,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181929537,
          "Java Heap": 7504,
          "Native Heap": 337508,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506760
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682554145,
        "rss": 534437888,
        "capacity": 684301456,
        "used": 41533480,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181930172,
          "Java Heap": 7504,
          "Native Heap": 337520,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506773
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682554446,
        "rss": 534437888,
        "capacity": 684301456,
        "used": 41533480,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181930172,
          "Java Heap": 7504,
          "Native Heap": 337520,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506773
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682554746,
        "rss": 534437888,
        "capacity": 684301456,
        "used": 41533480,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181930172,
          "Java Heap": 7504,
          "Native Heap": 337520,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1513,
          "Total": 506773
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682554779,
        "rss": 535035904,
        "capacity": 684301456,
        "used": 41533480,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181930806,
          "Java Heap": 7504,
          "Native Heap": 337560,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506812
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682555079,
        "rss": 535035904,
        "capacity": 684301456,
        "used": 41533480,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181930806,
          "Java Heap": 7504,
          "Native Heap": 337560,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506812
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682555380,
        "rss": 535035904,
        "capacity": 684301456,
        "used": 41533480,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181930806,
          "Java Heap": 7504,
          "Native Heap": 337560,
          "Code": 7732,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152452,
          "System": 1512,
          "Total": 506812
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682555646,
        "rss": 534978560,
        "capacity": 684301456,
        "used": 41533816,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181931512,
          "Java Heap": 7508,
          "Native Heap": 337584,
          "Code": 7900,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1523,
          "Total": 507015
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682555947,
        "rss": 534978560,
        "capacity": 684301456,
        "used": 41533816,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181931512,
          "Java Heap": 7508,
          "Native Heap": 337584,
          "Code": 7900,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1523,
          "Total": 507015
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      },
      {
        "timestamp": 1595682556248,
        "rss": 534978560,
        "capacity": 684301456,
        "used": 41533816,
        "external": 633719952,
        "gc": false,
        "adb_memoryInfo": {
          "Realtime": 181931512,
          "Java Heap": 7508,
          "Native Heap": 337584,
          "Code": 7900,
          "Stack": 52,
          "Graphics": 0,
          "Private Other": 152448,
          "System": 1523,
          "Total": 507015
        },
        "memory_eventInfo": {
          "timestamp": -1,
          "gcEvent": false,
          "snapshotEvent": false,
          "snapshotAutoEvent": false,
          "allocationAccumulatorEvent": {
            "start": false,
            "continues": false,
            "reset": false
          }
        }
      }
    ]
  }
};
