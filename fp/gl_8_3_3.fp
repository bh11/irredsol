############################################################################
##
##  gl_8_3_3.fp                IRREDSOL                  Burkhard Höfling
##
##  Copyright © Burkhard Höfling (burkhard@hoefling.name)
##


IRREDSOL_DATA.FP[8][3]{[ 16,24,60,70 ]} := 
[ [ [ [ 0,0 ],[ 0,0,0 ],[ 0,0,1 ],[ 0,1 ],[ 0,1,0 ],[ 0,1,1 ],[ 0,2 ],[ 0,11,0 ],[ 0,12 ],[ 0,12,0 ],
          [ 0,111 ],[ 0,112 ],[ 1,0 ],[ 1,0,0 ],[ 1,0,1 ],[ 1,1 ],[ 1,1,0 ],[ 1,1,1 ],[ 1,2 ],[ 1,2,0 ],[ 1,11 ],[ 1,11,0 ],[ 1,12 ],[ 1,13 ],
          [ 1,22 ],[ 1,111 ],[ 2,0 ],[ 2,0,0 ],[ 2,1,0 ],[ 2,11 ],[ 2,22 ],[ 11,0 ],[ 11,0,0 ],[ 11,0,1 ],[ 11,1,0 ],
          [ 11,2,0 ],[ 11,11 ],[ 11,11,0 ],[ 11,22 ] ],
      [ 5,[ [ [ 813642,4 ],[ 883324,2 ],[ 972613,2 ],[ 972612,2 ],[ 813639,1 ],[ 1522204,1 ],[ 972614,1 ],[ 803831,2 ],[ 1522205,1 ],[ 883325,3 ],
                  [ 803828,1 ],[ 972613,3 ],[ 883324,1 ],[ 803830,3 ],[ 883323,2 ],[ 803829,6 ],[ 1465565,1 ],[ 883326,4 ],[ 972612,4 ],[ 813641,2 ],
                  [ 1366480,3 ],[ 803830,8 ],[ 883326,3 ],[ 972613,4 ],[ 803831,4 ],[ 972613,5 ],[ 813642,12 ] ],
              [ [ 1,2,6,7,9,20,24 ],[ 1,2,6,9,20,26 ],[ 1,2,6,16,18,20,25,26 ],[ 1,2,6,20,24,25 ],
                  [ 1,2,8,9,17,23 ],[ 1,3 ],[ 1,3,5,6,7,8,11,13,14,15,19 ],[ 1,3,5,6,8,11,13,15,19 ],[ 1,3,5,6,11,13,15,19 ],
                  [ 1,3,6,7,9,11,15,18 ],[ 1,3,7,9,17,19,25 ],[ 1,5,6,7,9,12,13,14,15,19,23 ],[ 1,5,6,15,26 ],
                  [ 1,6,7,9,11,13,15,19,24 ],[ 1,6,8,9,10,13,14,15,20 ],[ 1,6,8,9,10,13,14,15,20,26 ],[ 1,6,8,10,13,14,15,20 ],
                  [ 1,6,8,10,13,14,15,20,24 ],[ 1,7,17 ],[ 1,8,12,17,19 ],[ 1,8,12,17,19,21,23 ],[ 1,8,17,22,24 ],
                  [ 1,17,19,25 ],[ 2,3,4,8,17,23 ],[ 2,3,4,10,17,25 ],[ 2,3,4,16,17,18 ],[ 2,3,17 ],[ 2,4,8,10,17 ],[ 2,7,8,9,10,12,17 ],
                  [ 2,10,12,17,19,25 ],[ 2,12,14,17,20 ],[ 2,14,17,19,20,25 ],[ 2,14,17,20,23,25,26 ],[ 2,14,17,20,26 ],[ 2,17,18,19,25 ],
                  [ 2,17,24 ],[ 2,17,24,25 ],[ 3,4,5,6,7,8,9,13,15 ],[ 3,4,5,7,13,15 ],[ 3,4,6,7,8,9,13,15 ],[ 3,4,6,7,15 ],
                  [ 3,4,8,9,10,13,15,16,17 ],[ 3,4,8,10,13,15,16,17,20 ],[ 3,4,8,10,13,15,17,18 ],[ 3,6,7,9,11,13,15,18,19 ],
                  [ 3,6,8,10,11,13,15,18 ],[ 3,6,9,11,15,16 ],[ 3,6,11,13,15,20 ],[ 3,7,9,17,19,25 ],
                  [ 3,8,17 ],[ 3,9,17 ],[ 3,14,17 ],[ 3,15 ],[ 3,15,19 ],[ 3,17,27 ],[ 4,5,6,7,11,13,15 ],[ 4,5,6,8,11,13,15 ],
                  [ 4,5,6,11,13,15 ],[ 4,6,7,8,9,10,13,15,24 ],[ 4,6,7,9,12,14 ],[ 4,6,7,9,12,15 ],[ 4,6,7,9,13,15 ],
                  [ 4,6,7,9,13,15,20,26 ],[ 4,6,8,10,13,15,18 ],[ 4,6,10,11,12,13,14,15 ],[ 4,6,10,11,13,15,23,26 ],
                  [ 4,7,8,9,13,15,17,20,23,26 ],[ 4,7,8,10,13,15,16,17,20 ],[ 4,7,8,10,13,15,16,17,20,24 ],
                  [ 4,7,8,10,13,15,17,24 ],[ 4,8,9,10,13,15,16,17 ],[ 4,8,9,12,13,15,17,20 ],[ 4,8,10,11,12,13,14,15,16,17 ],
                  [ 4,8,10,11,13,14,15,16,17,23 ],[ 4,8,10,13,15,16,17,18,20 ],[ 5,6,15,18,24 ],[ 5,14,15,16,26 ],[ 5,15,18,24 ],
                  [ 6,7,8,10,11,12,13,15,23 ],[ 6,7,8,11,12,15,23 ],[ 6,7,8,12,15 ],[ 6,7,9,10,11,12,13,14,15,20 ],
                  [ 6,7,9,10,11,12,13,15,20 ],[ 6,7,9,10,11,13,14,15,20,23 ],[ 6,7,9,10,11,13,15,20,23 ],
                  [ 6,7,9,10,11,13,15,20,24 ],[ 6,7,9,11,13,15,16,23,26 ],[ 6,7,9,11,15,24 ],[ 6,7,10,11,13,15,18,20,22,24 ],
                  [ 6,7,10,11,13,15,20,26 ],[ 6,7,11,15,23 ],[ 6,8,9,15,18 ],[ 6,8,10,11,12,13,15,23 ],[ 6,8,10,11,13,15,24 ],
                  [ 6,8,11,12,15,23 ],[ 6,9,11,13,15,20 ],[ 6,9,13,18,24 ],[ 6,9,15,18,24 ],[ 6,9,15,23,26 ],[ 6,10,11,13,15,18,20,22,24 ],
                  [ 6,11,12,13,15,19 ],[ 6,11,12,15 ],[ 6,11,14,15,23,26 ],[ 6,12,13,18,22 ],[ 6,12,15,18,22 ],[ 6,15,23,24 ],
                  [ 6,23,24 ],[ 7,9,17,18,19,25 ],[ 7,13,15 ],[ 7,13,15,25 ],[ 8,9,17,26 ],[ 8,9,24 ],[ 8,17,23,26 ],[ 8,18,22,24 ],[ 8,18,24 ],
                  [ 9,17,24 ],[ 12,14,17,19,21,23 ],[ 12,14,17,23 ],[ 12,14,17,23,27 ],[ 12,17,19 ],[ 14,17 ],[ 15,16,17,18 ],[ 15,16,17,24 ],
                  [ 15,17 ],[ 17 ],[ 17,19 ],[ 17,27 ] ],[ 3143,3144,3446,3445,100,98,4077,4103,4100,4235,110,4079,1759,4025,4069,4045,4065,4041,862,121,
                  113,105,1047,2038,2290,959,953,2039,114,2289,951,1103,559,863,118,955,120,4078,4029,4028,4038,1938,1957,2058,4234,4049,4197,4198,112,
                  109,956,119,147,1939,952,4076,4102,4101,4044,3145,4043,4030,4032,4064,4053,4096,531,533,1747,1751,532,1951,1749,1753,2054,1760,4034,
                  4035,4054,4051,4039,4024,4026,4237,4236,528,527,4027,4052,530,529,4068,4099,4095,4098,4196,4067,3142,4066,4097,4199,4050,4094,4040,
                  3442,4063,3443,117,4033,4031,106,107,99,111,116,966,103,972,973,958,122,2046,1748,1750,971,123,960 ] ],
          [ [ [ 813642,2 ],[ 992237,2 ],[ 902940,2 ],[ 972611,1 ],[ 803829,4 ],[ 972614,1 ],[ 883324,2 ],[ 902940,1 ],[ 883326,4 ],[ 803831,2 ],[ 794051,4 ],
                  [ 803831,5 ],[ 803831,4 ],[ 883327,2 ] ],[ [ 1,2,3,4,5,7,10 ],[ 1,2,4,5,6,7,8,13 ],[ 1,2,4,5,6,7,9,13 ],
                  [ 1,2,4,5,6,7,10 ],[ 1,2,4,5,7,8 ],[ 1,2,4,5,10 ],[ 1,2,4,5,11,13 ],[ 1,2,4,6,7,9,10 ],[ 1,2,4,7,8 ],
                  [ 1,2,4,7,8,10 ],[ 1,2,4,10 ],[ 1,2,4,11 ],[ 1,3,4,5,6,11 ],[ 1,3,4,5,6,11,13 ],[ 1,3,4,5,7,9,13 ],[ 1,3,4,5,10 ],
                  [ 1,3,4,7,10 ],[ 1,3,4,10 ],[ 1,3,4,11 ],[ 1,3,5,7,10 ],[ 1,3,5,7,10,11 ],[ 1,3,6,7,10,11 ],
                  [ 1,3,7,10 ],[ 1,4,5,6,7,10 ],[ 1,4,5,7,8,10 ],[ 1,4,5,7,8,13 ],[ 1,4,5,8,10 ],[ 1,4,5,8,11,13 ],[ 1,4,6,7 ],
                  [ 1,4,6,7,8 ],[ 1,4,6,7,8,10 ],[ 1,4,9 ],[ 1,4,9,10,11 ],[ 1,4,9,10,11,14 ],
                  [ 1,4,9,13 ],[ 1,4,9,13,14 ],[ 1,4,9,14 ],[ 1,5,6,7,8,10,11 ],[ 1,5,7,8,10 ],[ 2,4 ],[ 2,4,6 ],[ 2,4,6,9 ],[ 2,4,6,9,11 ],
                  [ 2,4,6,9,12 ],[ 2,4,6,11 ],[ 2,4,6,11,12 ],[ 2,4,9 ],[ 2,4,9,11 ],[ 2,4,9,12 ],[ 2,4,11 ],
                  [ 2,4,11,12 ],[ 4,10 ],[ 4,10,14 ],[ 4,11 ],[ 4,11,13 ],[ 4,11,13,14 ],[ 4,11,14 ] ],
              [ 3515,4379,651,3507,4091,3510,4360,653,4121,3509,3514,4120,4119,4382,4346,[ 3513,4383 ],3508,4362,4122,3497,3496,3305,3304,3511,3506,4365,
                  4357,4356,4074,4118,3512,4415,4413,4387,4412,4389,4386,3490,3489,[ 4390,4394 ],[ 4405,4409 ],4406,[ 4403,4407 ],4402,4404,4408,4393,
                  [ 4392,4396 ],4397,4395,4391,4411,4385,4410,4414,4384,4388 ] ],[ [ [ 1465565,1 ],[ 813641,24 ],[ 972612,10 ],[ 972613,6 ] ],
              [ [  ],[ 1 ],[ 1,2 ],[ 1,2,4 ],[ 1,3 ],[ 2 ],[ 3 ] ],[ 3151,858,962,104,860,3150,3152 ] ],
          [ [ [ 813643,2 ],[ 883324,1 ],[ 991159,2 ],[ 972612,2 ],[ 1678297,2 ],[ 1319663,2 ],[ 813642,2 ],[ 803830,2 ],[ 972614,1 ],
                  [ 813641,6 ],[ 813641,4 ],[ 883327,3 ],[ 972612,1 ],[ 813643,3 ],[ 992238,4 ] ],
              [ [ 1,2,3,4 ],[ 1,2,3,4,8,9 ],[ 1,2,9,11,13 ],[ 1,3,7,13 ],[ 1,5,8 ],[ 1,5,9,13 ],
                  [ 1,6 ],[ 1,6,8 ],[ 2 ],[ 2,3,4 ],[ 2,3,4,7,8 ],[ 2,3,4,7,8,14 ],[ 2,3,4,7,9 ],[ 2,3,4,7,9,14 ],[ 2,3,4,8,9 ],[ 2,4,7,9 ],
                  [ 2,4,8,9 ],[ 2,4,9 ],[ 2,6 ],[ 2,6,9 ],[ 2,7 ],[ 2,7,9 ],[ 2,7,11,13 ],[ 2,7,15 ],[ 2,9 ],
                  [ 2,9,10,13 ],[ 2,10 ],[ 2,10,12 ],[ 2,11,13 ],[ 2,15 ],[ 3,7 ],[ 3,9,13 ],[ 3,9,14 ],[ 4,6,9,12 ],[ 4,7,8,14 ],[ 5 ],
                  [ 5,8,13 ],[ 5,9 ],[ 6,8 ],[ 7 ],[ 7,8 ],[ 7,8,10,13 ],[ 7,9,12,14 ] ],
              [ 4351,4375,2286,2284,216,210,2040,2288,1745,4353,4377,4376,4350,4352,4374,4020,4019,4018,2048,1744,596,4017,2285,1936,4021,1761,283,1943,
                  1762,1757,4349,2283,4348,2287,285,208,214,206,2041,281,1942,1746,1941 ] ],
          [ [ [ 904040,2 ],[ 859015,1 ],[ 972614,1 ],[ 902939,2 ],[ 992239,1 ],[ 902941,2 ],[ 813642,1 ],[ 1522205,1 ],[ 883326,2 ],[ 972614,2 ] ],
              [ [ 1,2 ],[ 1,2,3,6 ],[ 1,3 ],[ 1,10 ],[ 2 ],[ 2,6 ],[ 2,6,10 ],[ 2,10 ],[ 3 ],[ 3,4,5,8 ],
                  [ 3,4,7,9 ],[ 3,4,8 ],[ 3,5,8 ],[ 3,7,8,9 ],[ 3,8 ],[ 4,5,8 ],[ 4,7,8,9 ],[ 4,8,9 ],[ 4,8,10 ],[ 4,9 ],[ 5,8 ],[ 7,9 ],
                  [ 8,9 ],[ 8,10 ],[ 9 ],[ 10 ] ],[ [ 4417,4418 ],[ 4371,4372 ],4366,4369,4419,4370,4373,4416,4367,4010,4194,4230,4013,4192,4233,4012,638,
                  639,4232,4195,4011,640,4193,4231,641,4368 ] ],[ [ [ 794050,4 ],[ 803828,7 ],[ 813641,16 ],[ 883326,4 ],[ 883326,2 ],[ 813639,6 ] ],
              [ [  ],[ 1 ],[ 1,2 ],[ 1,2,4 ],[ 1,4,6 ],[ 1,5 ],[ 1,5,6 ],[ 2 ],[ 2,3 ],[ 4,6 ],[ 5 ],[ 5,6 ] ],
              [ 3417,3422,3423,3420,1100,3419,1101,3418,3421,1105,3424,1106 ] ],[ [ [ 803828,2 ],[ 883325,1 ],[ 972613,3 ],[ 1475026,2 ] ],
              [ [ 1 ],[ 1,2 ],[ 1,2,3 ],[ 1,2,3,4 ],[ 1,2,4 ],[ 2 ],[ 2,3 ] ],[ 4088,597,1955,2056,1743,4087,4086 ] ],
          [ [ [ 813642,4 ],[ 803828,1 ],[ 1522204,1 ],[ 1574123,2 ],[ 794051,4 ],[ 904040,2 ],[ 813640,4 ],[ 803829,4 ],[ 972613,2 ],
                  [ 794050,4 ],[ 992236,2 ],[ 964284,1 ],[ 972613,1 ],[ 794051,8 ],[ 813642,1 ] ],
              [ [  ],[ 1,2,3,4,5,6,7,8,12 ],[ 1,2,3,4,5,6,8,9,10,11 ],[ 1,2,3,4,5,6,8,9,11,12 ],
                  [ 1,2,3,4,5,8,10,13 ],[ 1,2,3,4,5,9,10 ],[ 1,2,3,4,6,10,11 ],[ 1,2,3,4,9,10 ],[ 1,2,3,4,10,11 ],[ 1,2,3,4,10,11,14 ],
                  [ 1,2,3,4,10,13 ],[ 1,2,3,4,11,12,14 ],[ 1,3,4,5,6,8,11 ],[ 1,3,4,5,8 ],[ 1,4,5,6,8 ],
                  [ 1,4,5,6,9 ],[ 1,5 ],[ 1,5,8,10,13 ],[ 1,5,9,10 ],[ 1,6 ],[ 1,6,8,10,13 ],[ 1,6,9,10 ],[ 2,3,4,5,6 ],[ 2,3,4,5,6,7 ],
                  [ 2,3,4,5,6,9,11,12 ],[ 2,3,4,5,6,10 ],[ 2,3,4,5,9,10,11 ],[ 2,3,4,5,9,12 ],[ 2,3,4,5,10 ],
                  [ 2,3,4,6,8,10 ],[ 2,3,4,6,10 ],[ 2,3,4,7 ],[ 2,3,4,7,9 ],[ 2,3,4,8,9,10,14 ],[ 2,3,4,9,11 ],[ 2,3,4,9,11,12 ],
                  [ 2,3,4,10 ],[ 2,3,4,10,11 ],[ 2,3,4,11,12 ],[ 2,3,4,11,12,13 ],[ 2,3,4,11,13 ],[ 2,3,4,13 ],[ 2,3,4,14 ],
                  [ 3,4,5,6,7,12 ],[ 3,4,5,6,9 ],[ 3,4,5,6,11 ],[ 3,4,5,7,9,11 ],[ 3,4,7,8,12,13 ],[ 3,4,7,11,14 ],[ 3,4,8,13 ],
                  [ 3,4,9 ],[ 3,4,9,12 ],[ 3,4,12 ],[ 4,5,6 ],[ 4,5,6,8 ],[ 4,6,10,13 ],[ 4,6,10,13,15 ],[ 5,6,8,9 ],
                  [ 5,6,13 ],[ 5,7 ],[ 5,9 ],[ 6,7 ],[ 6,9 ],[ 8,9 ],[ 8,9,14 ],[ 9 ],[ 13,14 ] ],
              [ 3427,3458,3599,3602,3588,3589,3607,3587,3604,3597,3590,3608,3459,3465,1050,1109,3572,3311,3309,3571,3308,3310,3462,3461,3606,3593,3600,
                  3450,3586,3585,3594,3464,3505,3592,3501,3595,3591,3601,3603,3598,3499,3502,3463,3456,3460,3457,3451,3498,3453,3503,3504,3500,3452,1107,
                  1054,1218,1217,3429,3570,3566,3565,3568,3567,3426,3425,[ 3428,3430 ],3569 ] ],[ [ [ 991160,2 ] ],[ [  ],[ 1 ] ],[ 4577,4579 ] ],
          [ [ [ 813639,9 ],[ 803828,3 ],[ 972614,4 ],[ 883326,6 ] ],[ [  ],[ 1,2 ],[ 1,2,4 ],[ 2 ],[ 3 ] ],[ 961,3149,3147,3148,553 ] ],
          [ [ [ 972614,1 ],[ 992237,4 ],[ 904040,4 ],[ 883328,1 ],[ 972614,2 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 1,2,3 ],[ 2 ],[ 3,4 ],[ 4 ],[ 5 ] ],
              [ 3437,[ 3435,3438 ],3573,3574,[ 3575,3576 ],3318,3319,3436 ] ],[ [ [ 1587922,8 ],[ 883325,6 ] ],[ [  ],[ 1 ],[ 2 ] ],[ 6,166,108 ] ],
          [ [ [ 803829,2 ],[ 1522204,1 ],[ 972610,1 ],[ 1319662,1 ],[ 1465566,1 ],[ 803830,6 ],[ 813641,2 ],[ 1475027,1 ],[ 883326,3 ],[ 992237,8 ],
                  [ 972614,1 ],[ 883326,2 ],[ 794051,8 ],[ 883326,4 ],[ 972612,6 ],[ 972612,4 ],[ 1574124,1 ],[ 1257214,2 ],[ 883327,1 ],[ 1465565,5 ],
                  [ 813643,4 ],[ 972611,3 ],[ 902939,4 ],[ 992238,2 ],[ 883326,7 ],[ 972613,1 ],[ 883326,8 ] ],
              [ [ 1,2,3,4,14,22,24 ],[ 1,2,3,6,7,12,17,21 ],[ 1,2,3,6,7,17 ],[ 1,2,3,7,11,12,13,17,19,21 ],
                  [ 1,2,3,7,11,13,17,19 ],[ 1,2,3,11,19,26 ],[ 1,3,4,7,10,11,17,19 ],[ 1,3,4,7,11,17,19 ],[ 1,3,6,12,18 ],[ 1,3,6,12,18,22 ],
                  [ 1,3,6,14,18,22 ],[ 1,3,7,11,13,19,26 ],[ 1,3,9,18,19,21,26 ],[ 1,3,11,18 ],[ 1,10,12,18,23 ],[ 1,14,18 ],
                  [ 2,3,4,6,7,11,12,13,17,19 ],[ 2,3,4,6,7,11,12,17,19 ],[ 2,3,4,6,9,16,24 ],[ 2,3,4,9,16,24 ],[ 2,3,4,14,22,24 ],
                  [ 2,3,5,7 ],[ 2,3,5,7,8,9,17,19,22,24 ],[ 2,3,5,7,8,11,17,25 ],[ 2,3,5,7,8,12,19,24 ],[ 2,3,5,7,8,13,17,22,24 ],
                  [ 2,3,5,7,8,13,17,22,25 ],[ 2,3,5,7,14,21 ],[ 2,3,5,8,14,15,17,22,24 ],[ 2,3,5,8,14,17,22 ],[ 2,3,5,8,15,19,22,24 ],
                  [ 2,3,5,8,17,22,25 ],[ 2,3,5,9,11,22 ],[ 2,3,5,15,19,22 ],[ 2,3,7,8 ],[ 2,3,7,8,14,21,24 ],[ 2,3,7,9,11,19,26 ],
                  [ 2,3,7,9,17,19 ],[ 2,3,7,11 ],[ 2,3,7,11,12,13,17 ],[ 2,3,7,11,12,17,19 ],[ 2,3,7,11,12,17,19,22 ],[ 2,3,7,11,14,17,19 ],
                  [ 2,3,7,11,14,17,19,22 ],[ 2,3,7,11,17,22,25 ],[ 2,3,7,11,19 ],[ 2,3,7,12,13,17,19 ],[ 2,3,7,13,17,22 ],
                  [ 2,3,7,13,17,22,25 ],[ 2,3,8,9,11,22,26 ],[ 2,3,8,15,19,22,24 ],[ 2,3,9,11,21 ],[ 2,3,9,11,22,26 ],[ 2,3,9,19 ],
                  [ 2,3,11,12,17,22 ],[ 2,3,12,17,19,22 ],[ 2,3,14,15,17,22 ],[ 2,3,14,17,22 ],[ 2,3,17,22 ],[ 2,5,7,8,9,17,21,24 ],
                  [ 2,5,7,8,13,17,24 ],[ 2,5,8,14,15,17,24 ],[ 2,5,8,17,24 ],[ 2,7,13,17,25 ],[ 2,7,17 ],[ 2,14,17 ],[ 2,17,25 ],
                  [ 3 ],[ 3,4,11,12,17,19 ],[ 3,4,11,12,17,19,21 ],[ 3,5,6,22 ],[ 3,5,7,11,12,18 ],[ 3,5,7,14,18,19,21 ],[ 3,6,12,18 ],
                  [ 3,6,14,16,18 ],[ 3,7 ],[ 3,7,8,9,18,19,21 ],[ 3,7,8,11,18 ],[ 3,7,9,18 ],[ 3,7,11,18 ],[ 3,7,16,18,24 ],
                  [ 3,7,18,19,21,25,26 ],[ 3,7,18,23,25 ],[ 3,7,18,24,26 ],[ 3,7,26 ],[ 3,12,17,18 ],[ 3,12,18 ],[ 3,15 ],[ 3,16 ],[ 3,16,18 ],
                  [ 3,17,18 ],[ 3,18 ],[ 3,18,20 ],[ 3,18,27 ],[ 7,9,18 ],[ 7,9,18,24 ],[ 7,18,21,23,25 ],[ 7,18,21,24,25 ],
                  [ 11,12 ],[ 11,17,18,21,24 ],[ 11,17,18,24 ],[ 12 ],[ 12,18 ],[ 12,18,24 ],[ 14,16,18 ],[ 14,17,18,19,21,24 ],[ 14,17,18,19,24 ],
                  [ 18,21,23,24 ],[ 19,21,27 ] ],[ 4055,4060,4301,4105,4287,4276,4023,4275,1754,1752,2050,4022,2059,2143,1102,859,4279,4277,4057,4058,
                  4056,4282,4295,4284,3909,3908,4281,4083,3898,4042,3897,4285,4046,4293,4283,4085,4104,4296,3830,4305,4292,4290,4302,4303,4286,4288,4289,
                  4084,3831,4048,4294,4059,3821,4300,4304,4291,4070,3820,4297,3472,3471,3444,3470,3264,3265,3146,3263,149,4278,4280,204,616,1952,148,
                  1949,609,2055,2139,1662,617,625,1958,1561,1632,1937,2145,277,1630,1940,280,2141,1628,143,1631,1104,560,865,957,243,864,1013,101,102,
                  1108,954,1048,1051,861,967 ] ],
          [ [ [ 813643,2 ],[ 813642,2 ],[ 972611,1 ],[ 1408960,1 ],[ 992238,1 ],[ 1522205,1 ],[ 972613,4 ],[ 1233246,1 ],[ 883327,1 ],[ 883326,4 ],
                  [ 803831,4 ] ],[ [ 1,2,3,4,5,7 ],[ 1,2,3,4,5,7,9,10 ],[ 1,2,3,4,5,7,10 ],[ 1,2,3,4,9 ],
                  [ 1,2,3,5,6 ],[ 1,2,3,5,8,9 ],[ 1,2,3,6 ],[ 1,2,3,7,8,9 ],[ 1,2,4,7,10 ],[ 1,2,5,6 ],[ 1,2,5,6,9 ],[ 1,2,7,8 ],
                  [ 1,2,7,8,9 ],[ 1,2,7,10 ],[ 1,3,5,6 ],[ 1,3,6 ],[ 1,3,7,8 ],[ 1,3,7,10 ],[ 1,3,8 ],
                  [ 2,3,4 ],[ 2,3,4,5,6,8,11 ],[ 2,3,4,6,8,9 ],[ 2,3,4,7,9,10 ],[ 2,3,4,7,10,11 ],[ 2,3,4,11 ],[ 2,3,5,6 ],
                  [ 2,3,5,8,9,11 ],[ 2,3,6,9,11 ],[ 2,3,8,10 ],[ 3,4,7,9,10 ],[ 3,4,7,9,10,11 ],[ 3,5,6,11 ],[ 3,6,11 ],[ 3,7,8 ],[ 3,8 ] ],
              [ 652,4092,4378,4201,4238,4364,4075,4347,3494,3307,3306,3487,3488,3495,4363,3930,4359,[ 3929,4381 ],3926,4524,654,3925,3931,3923,4526,3928,
                  3922,3924,3927,4380,4314,4316,4315,4358,4361 ] ],[ [ [ 972610,3 ],[ 972614,2 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 2 ] ],[ 1554,965,115,1557 ] ],
          [ [ [ 883326,2 ],[ 972612,2 ],[ 803830,3 ],[ 992238,4 ],[ 813641,2 ],[ 883325,2 ],[ 972613,2 ],[ 1233246,1 ],[ 1765416,2 ],[ 972614,1 ],
                  [ 972610,1 ],[ 803830,2 ],[ 972613,1 ],[ 1475026,2 ],[ 1134160,3 ],[ 813643,4 ],[ 991160,4 ],[ 794051,12 ] ],
              [ [  ],[ 1,2,4,7,11,12 ],[ 1,3,10,11,13 ],[ 1,4,6,11 ],[ 1,4,10,11,12,14 ],[ 1,5,7,10,11,12 ],
                  [ 1,5,7,10,11,12,17 ],[ 1,5,11,12,16 ],[ 1,7,10,11,12 ],[ 1,7,10,11,12,16 ],[ 1,10,11,12 ],[ 1,11 ],[ 1,11,12,16 ],
                  [ 1,11,13,16 ],[ 2,3,5,6,10,11 ],[ 2,3,6,7,10,11 ],[ 2,3,6,11 ],[ 2,3,9,11,13 ],[ 2,3,11,13 ],
                  [ 2,5,6,10,11,12,13 ],[ 2,5,6,10,11,12,13,14 ],[ 2,5,6,11,12,13 ],[ 2,5,6,11,12,13,14 ],[ 2,6,7,8,11 ],[ 2,6,10,11,12,13 ],
                  [ 2,6,10,11,12,13,16 ],[ 2,6,11,13 ],[ 2,10,11,12,13 ],[ 3,4,11,13 ],[ 3,5,10,11 ],[ 3,8,11,13 ],[ 3,11,13 ],
                  [ 4,5,10,11,13 ],[ 4,5,11,12 ],[ 4,7,11,12 ],[ 4,10,11,12 ],[ 5,6,11 ],[ 5,6,11,18 ],[ 5,7,11,12 ],[ 5,11,12 ],
                  [ 6,8,10,11,13 ],[ 6,11 ],[ 6,11,13 ],[ 6,11,13,16 ],[ 6,11,15 ],[ 7,10,11,12 ],[ 7,11 ],
                  [ 7,11,12,14 ],[ 8 ],[ 8,10,11 ],[ 11,12 ],[ 11,13 ] ],[ 209,1758,2042,1948,1756,4273,4272,1944,4015,4016,284,2047,2049,1620,4271,
                  2516,637,602,601,4400,4398,4401,4399,286,4270,4269,211,215,629,4274,217,1935,4014,2149,1945,1947,2136,2140,287,2137,282,2517,2043,
                  1625,636,2134,2138,2052,165,207,200,212 ] ],
          [ [ [ 803831,1 ],[ 1111300,1 ],[ 904040,2 ] ],[ [ 1 ],[ 1,2 ],[ 1,2,3 ],[ 1,3 ],[ 2 ],[ 2,3 ] ],[ 4554,4555,4556,4553,4528,4527 ] ],
          [ [ [ 813642,4 ] ],[ [  ],[ 1 ] ],[ 1665,1664 ] ],[ [ [ 813642,4 ],[ 1765417,4 ] ],[ [  ],[ 1 ],[ 1,2 ] ],[ 2759,2741,2740 ] ],
          [ [ [ 883323,4 ],[ 803829,2 ],[ 972612,2 ],[ 883325,1 ],[ 1574124,1 ],[ 1319662,2 ],[ 972610,3 ],[ 1233245,1 ],[ 972613,3 ],[ 883327,2 ],
                  [ 813643,8 ] ],[ [  ],[ 1,2,3,6,7,8,10 ],[ 1,2,3,7,10 ],[ 1,2,7,10 ],[ 1,3,7,10 ],[ 1,4,7,8 ],
                  [ 1,4,7,8,10 ],[ 1,6,7,8 ],[ 2,3,6,8,10 ],[ 2,4,5,6,7,8,10 ],[ 2,4,5,6,7,8,11 ],[ 2,4,5,6,8,10 ],[ 2,5,9 ],[ 4,7,8 ],
                  [ 4,7,8,11 ],[ 4,8 ],[ 4,8,10 ],[ 5,6,7,8 ],[ 5,6,7,8,9 ],[ 5,6,8 ],[ 5,6,8,9 ],[ 5,9 ],[ 6,8 ],[ 8 ],[ 8,10 ] ],
              [ 3825,1015,3269,3270,3271,242,963,1012,1562,1014,867,[ 1559,1564 ],3827,244,964,276,1624,866,1011,1556,1560,3826,1565,145,1622 ] ],
          [ [ [ 883326,3 ],[ 813641,4 ],[ 883324,2 ],[ 883324,1 ],[ 1475026,2 ] ],[ [  ],[ 1,2,3 ],[ 1,2,3,5 ],[ 1,2,4 ],[ 1,3 ],[ 1,4 ],
                  [ 2,3 ],[ 2,3,5 ],[ 2,4 ],[ 3 ],[ 4 ] ],[ 4299,1956,2057,595,4093,1755,635,2135,1953,4298,2060 ] ],
          [ [ [ 1406055,1 ],[ 803830,2 ],[ 883325,1 ],[ 972610,1 ],[ 1574124,1 ],[ 813639,2 ],[ 803830,4 ],[ 972614,1 ],[ 803828,3 ],[ 1587556,2 ],
                  [ 1557790,1 ],[ 813643,4 ],[ 991160,4 ],[ 904039,2 ],[ 813642,1 ] ],[ [ 1,3,5,6,7,8,12 ],[ 1,4 ],[ 1,4,5,6,7,8,9,12 ],
                  [ 1,4,5,6,9 ],[ 1,5,6,9 ],[ 1,7 ],[ 1,7,9 ],[ 2,3,4,5,6,9,12 ],[ 2,3,5,6,12 ],[ 2,4,5,6,8,9 ],
                  [ 2,4,6,8,9 ],[ 2,8,9 ],[ 3,4,5,6,7 ],[ 3,4,5,6,8,10 ],[ 3,4,5,6,10 ],[ 3,4,5,6,12 ],[ 3,4,8,10 ],[ 3,4,10 ],
                  [ 3,5,6,8,12 ],[ 3,5,6,9,12 ],[ 3,10 ],[ 3,10,15 ],[ 4,5,6,8,9 ],[ 4,5,6,8,10 ],
                  [ 4,5,6,10 ],[ 4,5,7,9,11 ],[ 4,5,7,9,11,12 ],[ 4,5,7,11,12,15 ],[ 4,5,7,11,15 ],[ 4,6,8,9 ],[ 4,7,9 ],[ 4,9 ],[ 5,6,8,9 ],
                  [ 7 ],[ 7,9,11 ],[ 7,11 ],[ 7,11,13 ],[ 9,11 ],[ 9,11,13,14 ],[ 9,11,14 ],[ 9,15 ] ],
              [ 3479,3902,3916,3914,3477,3605,3454,3915,1049,3917,3904,3455,1668,3921,3919,1666,3905,3906,1053,3480,3481,3482,3913,3918,3920,3891,3892,
                  3890,3889,3903,3888,3893,3478,3596,3433,3432,3431,[ 3561,3562 ],3563,3564,3434 ] ],[ [ [ 991157,2 ] ],[ [  ],[ 1 ] ],[ 4578,4580 ] ],
          [ [ [ 803831,2 ] ],[ [  ],[ 1 ] ],[ [ 4325,4326 ],[ 4327,4328 ] ] ],
          [ [ [ 813641,2 ],[ 902939,4 ],[ 883327,4 ],[ 813643,4 ],[ 813642,2 ],[ 991160,4 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 1,2,4 ],[ 1,3 ],[ 2 ],[ 2,5 ],[ 2,6 ] 
                 ],[ 3823,620,3822,3824,1621,3266,3268,3267 ] ],[ [ [ 972612,10 ] ],[ [  ],[ 1 ] ],[ 278,203 ] ],
          [ [ [ 1522205,1 ],[ 813643,2 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 2 ] ],[ 2514,202,1627,2044 ] ],[ [ [ 883326,1 ],[ 813643,2 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 2 ] ],
              [ 279,2515,205,2045 ] ],[ [ [ 813642,4 ] ],[ [  ],[ 1 ] ],[ 201,1623 ] ],
          [ [ [ 964284,1 ],[ 972611,1 ],[ 883328,1 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 2 ],[ 2,3 ],[ 3 ] ],[ 4557,[ 4559,4560 ],[ 4332,4333 ],4573,4574,4558 ] ],
          167,[ [ [ 883327,2 ],[ 813643,12 ],[ 883324,2 ],[ 992238,2 ],[ 1475026,2 ],[ 813641,2 ],[ 1257214,4 ],[ 972612,3 ],[ 972613,6 ],[ 883326,2 ] ],
              [ [  ],[ 1,3,4 ],[ 1,3,4,6 ],[ 1,3,6 ],[ 1,4 ],[ 2 ],[ 3 ],[ 3,4 ],[ 3,4,6 ],[ 3,6 ],[ 3,10 ],
                  [ 4,10 ],[ 5 ],[ 5,8,10 ],[ 7 ],[ 7,10 ],[ 8,10 ],[ 9 ] ],[ 1661,1558,1629,1563,1016,970,146,1667,626,1663,1626,1052,2142,2051,246,
                  968,1555,247 ] ],[ [ [ 803831,4 ] ],[ [  ],[ 1 ] ],[ 4525,4523 ] ],
          [ [ [ 902940,4 ],[ 1233245,1 ],[ 1522204,2 ],[ 813643,2 ],[ 972613,2 ],[ 813642,1 ],[ 803830,4 ],[ 1678297,8 ] ],
              [ [  ],[ 1,2,3 ],[ 1,2,3,5 ],[ 1,2,3,5,6 ],[ 1,2,3,6 ],[ 1,2,3,7 ],[ 2,3,5,6 ],[ 2,3,6 ],[ 2,3,7 ],[ 2,4 ],[ 4 ],[ 4,8 ] ],
              [ 144,2144,150,288,2053,2148,2146,1946,1950,169,213,168 ] ],2758,[ [ [ 972614,2 ] ],[ [  ],[ 1 ] ],[ 969,245 ] ],
          [ [ [ 1134159,2 ],[ 992238,4 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 2 ] ],[ 2061,634,1954,2147 ] ],
          [ [ [ 1283724,1 ],[ 803831,10 ],[ 803831,2 ] ],[ [ 1 ],[ 1,2 ],[ 1,3 ],[ 3 ] ],[ 4329,4330,4331,[ 4575,4576 ] ] ] ] ],
  [ [ [ 0,0,88,0,0 ],[ 0,9,0,0 ],[ 0,88,0,0 ],[ 1,88,0,0 ],[ 8,8,0,0 ],[ 88,0,0 ] ],
      [ [ [ [ 5859794,1 ],[ 5859829,1 ],[ 5321872,1 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 1,3 ],[ 2 ],[ 3 ] ],[ 5969,5315,5326,5976,5973,5316 ] ],6045,
          [ [ [ 7174125,2 ],[ 5859788,1 ],[ 5321869,1 ],[ 5321867,1 ],[ 5321873,1 ],[ 5859797,1 ],[ 4902049,2 ],[ 5321901,2 ],[ 5859793,4 ],[ 5859794,2 ],
                  [ 5321902,2 ],[ 4842923,2 ],[ 5859790,4 ],[ 5321872,3 ] ],[ [ 1,2,3,4,10,11 ],[ 1,2,4,5,7,8,11,12 ],[ 1,2,4,5,7,11 ],
                  [ 1,2,4,5,8,11 ],[ 1,2,4,5,8,11,13 ],[ 1,2,4,6,7,11 ],[ 1,2,4,6,11 ],[ 1,2,4,6,11,12 ],[ 1,2,4,8 ],
                  [ 1,2,4,11 ],[ 1,2,11 ],[ 1,3,5 ],[ 1,4,5,8 ],[ 1,10 ],[ 2,3,4,5,8 ],[ 2,3,4,5,8,9 ],[ 2,3,4,6,8,12 ],[ 2,3,4,8 ],
                  [ 2,3,4,8,10 ],[ 2,3,4,8,12 ],[ 2,3,4,8,14 ],[ 3,6,11 ],[ 4,6 ],[ 4,6,11 ],[ 5 ],[ 10 ] ],
              [ 5323,5898,5913,5917,5322,5900,5899,5915,5912,5891,5916,4958,4771,4769,5953,5317,5954,5955,5318,5956,5952,3721,5928,3722,4828,4773 ] ],
          [ [ [ 5859788,1 ],[ 5440055,4 ] ],[ [  ],[ 1 ],[ 1,2 ] ],[ 4816,5327,5962 ] ],
          [ [ [ 7174131,1 ],[ 5321905,2 ],[ 4902053,1 ],[ 7174125,2 ],[ 7174137,2 ],[ 5859787,2 ],[ 5321870,1 ],[ 5321904,4 ] ],
              [ [  ],[ 1,2,4 ],[ 1,3,4 ],[ 1,3,4,7 ],[ 1,4 ],[ 1,4,8 ],[ 1,5 ],[ 1,5,7 ],[ 2,3,5,7 ],
                  [ 2,3,7 ],[ 2,5 ],[ 2,6 ],[ 2,6,8 ],[ 6 ],[ 6,7 ],[ 7 ] ],[ 5936,4827,5957,5937,5935,5958,3710,3711,3646,5938,3645,5911,5914,4955,
                  5897,5883 ] ],[ [ [ 8829735,1 ] ],[ [  ],[ 1 ] ],[ 5920,1365 ] ] ] ],
  [ [ [ 0,15,154 ],[ 0,28,154 ],[ 1,1,323 ],[ 1,28,154 ],[ 1,29,154 ],[ 1,26055 ],[ 2,29,154 ],[ 2,26055 ],[ 11,11,0,0 ] ],
      [ [ [ [ 8714636,4 ] ],[ [  ],[ 1 ] ],[ 5348,5335 ] ],[ [ [ 15911472,2 ],[ 18081091,4 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 2 ] ],[ 5611,5610,5612,5608 ] ],
          [ [ [ 11902795,2 ],[ 11447830,2 ] ],[ [  ],[ 1 ],[ 1,2 ],[ 2 ] ],[ 5350,5334,5349,5336 ] ],[ [ [ 17112944,4 ],[ 8714648,4 ] ],[ [  ],[ 1,2 ],[ 2 ] ],
              [ 5341,5340,5337 ] ],5609,5607,5632,5631,5862 ] ],[ [ [ 0,11,0,0,176,11,0,0 ],[ 0,11,0,2651,0,0 ],[ 176,176,0,0 ] ],[ 6070,6030,4642 ] ] 
 ];
