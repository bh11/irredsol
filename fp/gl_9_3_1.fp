############################################################################
##
##  gl_9_3_1.fp                  IRREDSOL                  Burkhard Hoefling
##
##  @(#)$Id$
##
##  Copyright (C) 2003-2005 by Burkhard Hoefling, 
##  Institut fuer Geometrie, Algebra und Diskrete Mathematik
##  Technische Universitaet Braunschweig, Germany
##


############################################################################
##
#V  IRREDSOL_DATA.FP
##
IRREDSOL_DATA.FP[9][3]{[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 
  25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36 ]} := [
[ [ [ 6, 4, 40150, 1 ], [ 32, 3, 39367, 2 ], [ 36, 4, 26572, 1 ], [ 36, 4, 46501, 1 ] ], 
  [ [  ], [ 1, 2 ], [ 2 ], [ 2, 3 ], [ 2, 4 ], [ 3 ], [ 4 ] ], 
  [ [ 75 ], [ 88 ], [ 66 ], [ 77 ], [ 54 ], [ 65 ], [ 87 ] ] ],
[ [ [ 3, 2, 40852, 3 ], [ 6, 4, 20440, 1 ], [ 36, 4, 26572, 2 ], [ 36, 4, 46501, 1 ], [ 48, 6, 40852, 2 ], 
      [ 64, 3, 39367, 1 ], [ 72, 4, 26572, 2 ], [ 72, 4, 55480, 1 ] ], 
  [ [  ], [ 1 ], [ 2 ], [ 2, 6 ], [ 3, 4 ], [ 3, 4, 8 ], [ 4 ], [ 4, 5 ], [ 4, 5, 6 ], [ 4, 6 ], 
      [ 4, 6, 7, 8 ], [ 4, 6, 8 ], [ 8 ] ], 
  [ [ 196 ], [ 53 ], [ 101 ], [ 105 ], [ 104 ], [ 62 ], [ 73 ], [ 100 ], [ 85 ], [ 63 ], [ 79 ], [ 56 ], [ 84 ] 
     ] ],
[ [ [ 6, 2, 21196, 1 ], [ 6, 2, 40852, 1 ] ], [ [  ], [ 1 ], [ 2 ] ], [ [ 254 ], [ 263 ], [ 266 ] ] ],
[ [ [ 3, 2, 40852, 3 ], [ 6, 2, 21196, 1 ], [ 9, 2, 40852, 3 ], [ 32, 3, 39367, 2 ], [ 36, 2, 49624, 1 ], 
      [ 36, 4, 26572, 1 ], [ 64, 3, 39367, 2 ], [ 72, 4, 58360, 1 ], [ 192, 6, 21196, 1 ] ], 
  [ [  ], [ 1 ], [ 1, 7 ], [ 1, 8 ], [ 2, 4, 5 ], [ 2, 5, 6 ], [ 3 ], [ 3, 7 ], [ 3, 8 ], [ 4 ], [ 4, 8 ], 
      [ 5 ], [ 5, 6 ], [ 5, 7 ], [ 5, 9 ], [ 7 ], [ 9 ] ], 
  [ [ 91 ], [ 78 ], [ 76 ], [ 55 ], [ 97 ], [ 80 ], [ 208 ], [ 204 ], [ 200 ], [ 68 ], [ 90 ], [ 109 ], [ 98 ], 
      [ 89 ], [ 69 ], [ 67 ], [ 108 ] ] ],
[ [ [ 9, 2, 40852, 3 ] ], [ [  ], [ 1 ] ], [ [ 197 ], [ 58 ] ] ],
[ [ [ 3, 2, 40852, 4 ], [ 9, 2, 37528, 1 ], [ 18, 2, 40852, 1 ], [ 36, 2, 49624, 1 ], [ 72, 2, 49624, 1 ], 
      [ 72, 4, 26572, 1 ] ], [ [  ], [ 1 ], [ 2, 3, 5 ], [ 2, 3, 6 ], [ 2, 4 ], [ 2, 5 ], [ 3 ], [ 3, 4 ], 
      [ 3, 4, 5 ], [ 3, 5 ], [ 6 ] ], [ [ 198 ], [ 51 ], [ 74 ], [ 103 ], [ 102 ], [ 212 ], [ 106 ], [ 107 ], 
      [ 86 ], [ 64 ], [ 110 ] ] ],
[ [ [ 39, 2, 21196, 1 ], [ 39, 2, 40852, 1 ] ], [ [  ], [ 1 ], [ 2 ] ], [ [ 256 ], [ 265 ], [ 268 ] ] ],
[ [ [ 27, 2, 40852, 1 ], [ 36, 2, 21196, 1 ], [ 128, 3, 39367, 1 ], [ 216, 4, 26572, 1 ], [ 288, 6, 55264, 1 ] ]
    , [ [  ], [ 1 ], [ 1, 3 ], [ 1, 3, 4 ], [ 2, 5 ], [ 3 ], [ 3, 4 ], [ 3, 4, 5 ], [ 3, 5 ], [ 5 ] ], 
  [ [ 71 ], [ 205 ], [ 201 ], [ 209 ], [ 60 ], [ 57 ], [ 72 ], [ 61 ], [ 83 ], [ 82 ] ] ],
[ [ [ 3, 2, 40852, 1 ], [ 9, 2, 32152, 14 ], [ 18, 2, 40852, 3 ], [ 72, 4, 24040, 1 ], [ 144, 2, 32152, 1 ] ], 
  [ [  ], [ 1 ], [ 1, 2 ], [ 1, 3 ], [ 1, 3, 5 ], [ 2 ], [ 3 ], [ 3, 4 ], [ 5 ] ], 
  [ [ 33 ], [ 99 ], [ 206 ], [ 202 ], [ 210 ], [ 40 ], [ 44 ], [ 37 ], [ 41 ] ] ],
[ [ [ 3, 2, 40852, 1 ] ], [ [  ], [ 1 ] ], [ [ 262 ], [ 258 ] ] ],
[ [ [ 9, 2, 40852, 1 ], [ 27, 2, 40852, 2 ], [ 72, 2, 49624, 1 ], [ 216, 4, 26572, 2 ], [ 576, 6, 40852, 2 ] ], 
  [ [  ], [ 1 ], [ 1, 3 ], [ 1, 3, 4 ], [ 1, 3, 5 ], [ 1, 4 ], [ 1, 4, 5 ], [ 2 ], [ 3 ], [ 5 ] ], 
  [ [ 199 ], [ 95 ], [ 70 ], [ 59 ], [ 81 ], [ 96 ], [ 94 ], [ 34 ], [ 213 ], [ 93 ] ] ],
[ [ [ 18, 2, 21196, 3 ], [ 24, 2, 21196, 2 ], [ 144, 2, 32152, 1 ], [ 144, 4, 58360, 4 ], [ 576, 4, 46501, 2 ] ]
    , [ [  ], [ 1 ], [ 1, 3, 4 ], [ 2 ], [ 3 ], [ 3, 4 ], [ 4 ], [ 5 ] ], 
  [ [ 19 ], [ 49 ], [ 214 ], [ 14 ], [ 50 ], [ 18 ], [ 23 ], [ 10 ] ] ],
[ [ [ 12, 3, 39367, 2 ], [ 36, 2, 40852, 1 ], [ 48, 3, 39367, 2 ], [ 648, 4, 46501, 1 ] ], 
  [ [  ], [ 1 ], [ 1, 2, 3 ], [ 1, 3 ], [ 3 ], [ 3, 4 ], [ 4 ] ], 
  [ [ 136 ], [ 145 ], [ 150 ], [ 132 ], [ 159 ], [ 141 ], [ 154 ] ] ],
[ [ [ 6, 13, 39394, 1 ], [ 78, 2, 40852, 1 ] ], [ [  ], [ 1 ], [ 1, 2 ] ], [ [ 255 ], [ 264 ], [ 267 ] ] ],
[ [ [ 1, 2, 19684, 1 ], [ 9, 2, 40852, 1 ], [ 9, 2, 40852, 3 ], [ 72, 2, 40852, 1 ], [ 144, 2, 32152, 1 ], 
      [ 384, 3, 39367, 3 ] ], [ [  ], [ 1 ], [ 1, 2, 4 ], [ 1, 3 ], [ 2 ], [ 2, 4 ], [ 2, 5, 6 ], [ 2, 6 ], 
      [ 3, 4, 6 ], [ 3, 6 ], [ 5 ] ], [ [ 203 ], [ 207 ], [ 92 ], [ 38 ], [ 36 ], [ 43 ], [ 39 ], [ 12 ], 
      [ 42 ], [ 35 ], [ 211 ] ] ],
[ [ [ 18, 2, 49624, 3 ], [ 144, 4, 46501, 4 ], [ 288, 4, 46501, 1 ], [ 1152, 8, 52492, 2 ], 
      [ 1152, 8, 52492, 6 ] ], [ [  ], [ 1, 4 ], [ 1, 5 ], [ 2 ], [ 2, 4 ], [ 3 ], [ 3, 4 ], [ 3, 5 ], [ 4 ] ], 
  [ [ 20 ], [ 21 ], [ 11 ], [ 27 ], [ 24 ], [ 28 ], [ 16 ], [ 25 ], [ 15 ] ] ],
[ [ [ 9, 13, 39394, 3 ] ], [ [  ], [ 1 ] ], [ [ 246 ], [ 247 ] ] ],
[ [ [ 192, 3, 39367, 1 ], [ 216, 2, 21196, 1 ], [ 216, 2, 49624, 1 ], [ 324, 4, 46501, 1 ], 
      [ 864, 6, 40852, 1 ] ], [ [  ], [ 1 ], [ 1, 4 ], [ 1, 4, 5 ], [ 2 ], [ 2, 3, 5 ], [ 2, 4, 5 ], 
      [ 3, 4, 5 ], [ 3, 5 ], [ 4, 5 ], [ 5 ] ], 
  [ [ 128 ], [ 129 ], [ 131 ], [ 130 ], [ 167 ], [ 180 ], [ 184 ], [ 192 ], [ 176 ], [ 172 ], [ 188 ] ] ],
[ [ [ 9, 2, 40852, 1 ], [ 48, 3, 39367, 2 ], [ 144, 2, 49624, 1 ], [ 432, 4, 58360, 1 ] ], 
  [ [  ], [ 1 ], [ 1, 2, 3, 4 ], [ 1, 3 ], [ 1, 3, 4 ], [ 1, 4 ], [ 2, 3, 4 ] ], 
  [ [ 45 ], [ 47 ], [ 17 ], [ 22 ], [ 13 ], [ 46, 48 ], [ 215 ] ] ],
[ [ [ 12, 2, 21196, 1 ], [ 18, 2, 49624, 1 ], [ 288, 4, 26572, 1 ], [ 2304, 4, 26572, 1 ] ], 
  [ [  ], [ 1 ], [ 1, 2, 3 ], [ 2 ], [ 2, 3 ], [ 2, 3, 4 ], [ 2, 4 ] ], 
  [ [ 29 ], [ 7 ], [ 31 ], [ 8 ], [ 6 ], [ 30 ], [ 32 ] ] ],
[ [ [ 3, 13, 39394, 1 ], [ 3, 13, 39394, 3 ], [ 39, 2, 21196, 1 ] ], [ [  ], [ 1 ], [ 1, 3 ], [ 2 ] ], 
  [ [ 243 ], [ 253 ], [ 251 ], [ 242 ] ] ],
[ [ [ 24, 6, 40852, 3 ], [ 72, 6, 49624, 4 ], [ 108, 2, 40852, 1 ], [ 108, 4, 54382, 1 ], [ 192, 3, 39367, 1 ], 
      [ 432, 4, 51100, 1 ], [ 512, 3, 39367, 1 ], [ 576, 3, 39367, 2 ], [ 648, 4, 46501, 1 ], 
      [ 3456, 6, 21196, 2 ], [ 3456, 6, 32152, 1 ] ], 
  [ [  ], [ 1, 2 ], [ 1, 2, 6 ], [ 1, 2, 8 ], [ 1, 2, 8, 10 ], [ 2 ], [ 2, 9 ], [ 3, 5, 7, 8, 9 ], 
      [ 3, 5, 7, 8, 10 ], [ 3, 5, 8 ], [ 4, 5 ], [ 4, 5, 7 ], [ 4, 5, 7, 8, 9 ], [ 4, 5, 7, 8, 10 ], 
      [ 4, 5, 7, 11 ], [ 4, 5, 8 ], [ 4, 5, 9 ], [ 5 ], [ 5, 7 ], [ 5, 7, 8, 9 ], [ 5, 7, 8, 10 ], 
      [ 5, 7, 11 ], [ 5, 8 ], [ 5, 9 ], [ 8 ] ], 
  [ [ 163 ], [ 160 ], [ 142 ], [ 155 ], [ 137 ], [ 133 ], [ 151 ], [ 157 ], [ 139 ], [ 148 ], [ 135 ], [ 144 ], 
      [ 158 ], [ 140 ], [ 162 ], [ 149 ], [ 153 ], [ 134 ], [ 143 ], [ 156 ], [ 138 ], [ 161 ], [ 147 ], 
      [ 152 ], [ 146 ] ] ],
[ [ [ 1, 2, 19684, 1 ] ], [ [  ], [ 1 ] ], [ [ 5 ], [ 26 ] ] ],
[ [ [ 27, 13, 39394, 1 ] ], [ [  ], [ 1 ] ], [ [ 232 ], [ 233 ] ] ],
[ [ [ 3, 2, 40852, 1 ], [ 3, 13, 39394, 3 ] ], [ [  ], [ 1 ], [ 1, 2 ] ], [ [ 249 ], [ 245 ], [ 244 ] ] ],
[ [ [ 24, 6, 19684, 1 ], [ 27, 2, 21196, 1 ], [ 108, 2, 49624, 1 ], [ 108, 2, 55264, 1 ], [ 162, 4, 58360, 1 ], 
      [ 432, 2, 32152, 1 ], [ 1728, 6, 32152, 1 ] ], 
  [ [  ], [ 1 ], [ 1, 2, 3, 5 ], [ 1, 2, 3, 6 ], [ 1, 2, 3, 7 ], [ 1, 2, 4 ], [ 1, 2, 4, 6 ], [ 1, 2, 4, 7 ], 
      [ 1, 2, 5 ], [ 1, 2, 6 ], [ 2 ], [ 3, 4 ], [ 3, 6 ], [ 3, 7 ], [ 4 ], [ 4, 6 ], [ 4, 6, 7 ], [ 4, 7 ], 
      [ 5 ], [ 5, 6, 7 ], [ 6 ], [ 6, 7 ], [ 7 ] ], 
  [ [ 193 ], [ 168 ], [ 171 ], [ 179 ], [ 175 ], [ 169 ], [ 178 ], [ 174 ], [ 170 ], [ 177 ], [ 173 ], [ 126 ], 
      [ 187 ], [ 183 ], [ 194 ], [ 186 ], [ 190 ], [ 182 ], [ 195 ], [ 191 ], [ 185 ], [ 189 ], [ 181 ] ] ],
[ [ [ 1, 2, 19684, 1 ], [ 288, 2, 40852, 1 ] ], [ [  ], [ 1 ], [ 2 ] ], [ [ 2 ], [ 3 ], [ 4 ] ] ],
[ [ [ 27, 13, 39394, 1 ], [ 54, 13, 40408, 3 ], [ 117, 2, 40852, 1 ] ], [ [  ], [ 1 ], [ 2 ], [ 2, 3 ] ], 
  [ [ 228 ], [ 229 ], [ 237 ], [ 239 ] ] ],
[ [ [ 1, 2, 19684, 1 ], [ 9, 13, 39394, 2 ], [ 78, 2, 21196, 1 ] ], [ [ 1 ], [ 1, 2 ], [ 2 ], [ 2, 3 ] ], 
  [ [ 241 ], [ 240 ], [ 252 ], [ 250 ] ] ],
[ [ [ 216, 4, 40150, 1 ], [ 432, 4, 55480, 1 ], [ 1536, 6, 40852, 1 ], [ 1728, 12, 45640, 1 ], 
      [ 2592, 4, 55480, 1 ] ], [ [  ], [ 1, 2, 4 ], [ 1, 3 ], [ 1, 4 ], [ 1, 4, 5 ], [ 2 ], [ 3 ], [ 3, 4 ], 
      [ 3, 4, 5 ], [ 4 ] ], [ [ 115 ], [ 164 ], [ 117 ], [ 165 ], [ 166 ], [ 116 ], [ 113 ], [ 118 ], [ 114 ], 
      [ 112 ] ] ],
[ [ [ 1, 2, 19684, 1 ], [ 9, 13, 39394, 3 ] ], [ [  ], [ 1, 2 ], [ 2 ] ], [ [ 231 ], [ 235 ], [ 230 ] ] ],
[ [ [ 144, 2, 40852, 1 ], [ 324, 2, 32152, 1 ], [ 864, 2, 32152, 1 ] ], 
  [ [  ], [ 1 ], [ 1, 2 ], [ 1, 2, 3 ], [ 2 ], [ 2, 3 ], [ 3 ] ], 
  [ [ 119 ], [ 125 ], [ 120 ], [ 123 ], [ 122 ], [ 121 ], [ 124 ] ] ],
[ [ [ 54, 13, 43462, 1 ], [ 117, 2, 40852, 1 ] ], [ [  ], [ 1 ], [ 1, 2 ] ], [ [ 221 ], [ 224 ], [ 225 ] ] ],
[ [ [ 9, 26, 19738, 3 ], [ 18, 26, 43045, 1 ], [ 234, 2, 21196, 1 ] ], [ [  ], [ 1 ], [ 2 ], [ 2, 3 ] ], 
  [ [ 227 ], [ 226 ], [ 238 ], [ 236 ] ] ],
[ [ [ 3, 2, 40852, 1 ] ], [ [  ], [ 1 ] ], [ [ 223 ], [ 218 ] ] ],
[ [ [ 1, 2, 19684, 1 ], [ 234, 2, 21196, 1 ] ], [ [  ], [ 1 ], [ 2 ] ], [ [ 220 ], [ 217 ], [ 219 ] ] ],
];


############################################################################
##
#E
##