
# line 1 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
require 'gherkin/lexer/i18n_lexer'

module Gherkin
  module RbLexer
    class Zh_cn #:nodoc:
      
# line 123 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"

 
      def initialize(listener)
        @listener = listener
        
# line 16 "lib/gherkin/rb_lexer/zh_cn.rb"
class << self
	attr_accessor :_lexer_actions
	private :_lexer_actions, :_lexer_actions=
end
self._lexer_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 16, 1, 
	17, 1, 18, 1, 19, 1, 20, 1, 
	21, 1, 22, 1, 23, 2, 2, 18, 
	2, 3, 4, 2, 13, 0, 2, 14, 
	15, 2, 17, 0, 2, 17, 1, 2, 
	17, 16, 2, 17, 19, 2, 18, 6, 
	2, 18, 7, 2, 18, 8, 2, 18, 
	9, 2, 18, 10, 2, 18, 16, 2, 
	20, 21, 2, 22, 0, 2, 22, 1, 
	2, 22, 16, 2, 22, 19, 3, 4, 
	14, 15, 3, 5, 14, 15, 3, 11, 
	14, 15, 3, 12, 14, 15, 3, 13, 
	14, 15, 3, 14, 15, 18, 3, 17, 
	0, 11, 3, 17, 14, 15, 4, 2, 
	14, 15, 18, 4, 3, 4, 14, 15, 
	4, 17, 0, 14, 15, 5, 17, 0, 
	11, 14, 15
]

class << self
	attr_accessor :_lexer_key_offsets
	private :_lexer_key_offsets, :_lexer_key_offsets=
end
self._lexer_key_offsets = [
	0, 0, 15, 17, 18, 19, 20, 21, 
	23, 25, 39, 43, 44, 45, 46, 47, 
	48, 49, 50, 51, 52, 53, 54, 64, 
	66, 68, 70, 72, 74, 76, 90, 92, 
	93, 94, 95, 96, 97, 98, 99, 100, 
	101, 102, 103, 115, 117, 119, 121, 123, 
	125, 130, 132, 134, 136, 138, 140, 142, 
	144, 146, 148, 150, 152, 154, 156, 159, 
	161, 163, 165, 167, 169, 171, 173, 175, 
	177, 179, 181, 183, 185, 187, 189, 191, 
	193, 195, 197, 199, 201, 203, 205, 207, 
	209, 211, 213, 215, 217, 219, 221, 222, 
	223, 224, 225, 226, 227, 228, 230, 232, 
	237, 242, 247, 252, 256, 260, 262, 263, 
	264, 265, 266, 267, 268, 269, 270, 271, 
	272, 273, 274, 275, 276, 277, 278, 283, 
	290, 295, 299, 305, 308, 310, 316, 330, 
	333, 335, 337, 339, 341, 343, 345, 347, 
	349, 352, 354, 356, 358, 360, 362, 364, 
	366, 368, 370, 372, 374, 376, 378, 380, 
	382, 384, 386, 388, 390, 392, 394, 396, 
	398, 400, 401, 402, 403, 404, 406, 407, 
	408, 409, 410, 411, 412, 413, 414, 426, 
	428, 430, 432, 434, 436, 441, 443, 445, 
	447, 449, 451, 453, 455, 457, 459, 461, 
	463, 465, 467, 469, 471, 473, 475, 477, 
	479, 481, 483, 485, 487, 489, 491, 493, 
	495, 497, 499, 501, 503, 505, 507, 509, 
	511, 513, 515, 517, 519, 520, 521, 533, 
	535, 537, 539, 541, 543, 548, 550, 552, 
	554, 556, 558, 560, 562, 564, 566, 568, 
	570, 572, 574, 577, 579, 581, 583, 585, 
	587, 589, 592, 594, 596, 598, 600, 602, 
	604, 606, 608, 610, 612, 614, 616, 618, 
	620, 622, 624, 626, 628, 630, 632, 634, 
	636, 638, 640, 642, 644, 646, 648, 649, 
	650, 651, 652, 653, 654, 655, 656, 663, 
	665, 667, 669, 671, 673, 675, 676, 677
]

class << self
	attr_accessor :_lexer_trans_keys
	private :_lexer_trans_keys, :_lexer_trans_keys=
end
self._lexer_trans_keys = [
	-28, -27, -24, -23, -17, 10, 32, 34, 
	35, 37, 42, 64, 124, 9, 13, -67, 
	-66, -122, -26, -104, -81, 10, 13, 10, 
	13, -28, -27, -24, -23, 10, 32, 34, 
	35, 37, 42, 64, 124, 9, 13, -127, 
	-118, -100, -67, -121, -27, -90, -126, -97, 
	-24, -125, -67, 58, 10, 10, -28, -27, 
	-24, 10, 32, 35, 37, 64, 9, 13, 
	-66, 10, -117, 10, -27, 10, -83, 10, 
	-112, 10, 10, 58, -28, -27, -24, -23, 
	10, 32, 34, 35, 37, 42, 64, 124, 
	9, 13, -128, -125, -116, -28, -72, -108, 
	-116, -26, -103, -81, 58, 10, 10, -28, 
	-27, -24, -23, 10, 32, 35, 37, 42, 
	64, 9, 13, -67, 10, -122, 10, -26, 
	10, -104, 10, -81, 10, -127, -118, -100, 
	-67, 10, -121, 10, -27, 10, -90, 10, 
	-126, 10, -97, 10, -24, 10, -125, 10, 
	-67, 10, 10, 58, -70, 10, -26, 10, 
	-103, 10, -81, 10, -27, 10, 58, -92, 
	10, -89, 10, -25, 10, -70, 10, -78, 
	10, -109, 10, -128, 10, -116, 10, -28, 
	10, -72, 10, -108, 10, -126, 10, -93, 
	10, -28, 10, -71, 10, -120, 10, 10, 
	95, 10, 70, 10, 69, 10, 65, 10, 
	84, 10, 85, 10, 82, 10, 69, 10, 
	95, 10, 69, 10, 78, 10, 68, 10, 
	95, 10, 37, 10, 32, -126, -93, -28, 
	-71, -120, 34, 34, 10, 13, 10, 13, 
	10, 32, 34, 9, 13, 10, 32, 34, 
	9, 13, 10, 32, 34, 9, 13, 10, 
	32, 34, 9, 13, 10, 32, 9, 13, 
	10, 32, 9, 13, 10, 13, 10, 95, 
	70, 69, 65, 84, 85, 82, 69, 95, 
	69, 78, 68, 95, 37, 32, 13, 32, 
	64, 9, 10, 9, 10, 13, 32, 64, 
	11, 12, 10, 32, 64, 9, 13, 32, 
	124, 9, 13, 10, 32, 92, 124, 9, 
	13, 10, 92, 124, 10, 92, 10, 32, 
	92, 124, 9, 13, -28, -27, -24, -23, 
	10, 32, 34, 35, 37, 42, 64, 124, 
	9, 13, -118, -100, 10, -97, 10, -24, 
	10, -125, 10, -67, 10, -70, 10, -26, 
	10, -103, 10, -81, 10, -27, 10, 58, 
	-92, 10, -89, 10, -25, 10, -70, 10, 
	-78, 10, -125, 10, -116, 10, -26, 10, 
	-103, 10, -81, 10, 10, 95, 10, 70, 
	10, 69, 10, 65, 10, 84, 10, 85, 
	10, 82, 10, 69, 10, 95, 10, 69, 
	10, 78, 10, 68, 10, 95, 10, 37, 
	-70, -26, -103, -81, -27, 58, -92, -89, 
	-25, -70, -78, 58, 10, 10, -28, -27, 
	-24, -23, 10, 32, 35, 37, 42, 64, 
	9, 13, -67, 10, -122, 10, -26, 10, 
	-104, 10, -81, 10, -127, -118, -100, -67, 
	10, -121, 10, -27, 10, -90, 10, -126, 
	10, -97, 10, -24, 10, -125, 10, -67, 
	10, 10, 58, -70, 10, -26, 10, -103, 
	10, -81, 10, -109, 10, -128, 10, -116, 
	10, -28, 10, -72, 10, -108, 10, -126, 
	10, -93, 10, -28, 10, -71, 10, -120, 
	10, 10, 95, 10, 70, 10, 69, 10, 
	65, 10, 84, 10, 85, 10, 82, 10, 
	69, 10, 95, 10, 69, 10, 78, 10, 
	68, 10, 95, 10, 37, 10, 32, 10, 
	10, -28, -27, -24, -23, 10, 32, 35, 
	37, 42, 64, 9, 13, -67, 10, -122, 
	10, -26, 10, -104, 10, -81, 10, -127, 
	-118, -100, -67, 10, -121, 10, -27, 10, 
	-90, 10, -126, 10, -97, 10, -24, 10, 
	-125, 10, -67, 10, 10, 58, -70, 10, 
	-26, 10, -103, 10, -81, 10, -27, 10, 
	58, -92, 10, -89, 10, -25, 10, -70, 
	10, -78, 10, -109, 10, -128, -125, 10, 
	-116, 10, -28, 10, -72, 10, -108, 10, 
	-116, 10, -26, 10, -103, 10, -81, 10, 
	-126, 10, -93, 10, -28, 10, -71, 10, 
	-120, 10, 10, 95, 10, 70, 10, 69, 
	10, 65, 10, 84, 10, 85, 10, 82, 
	10, 69, 10, 95, 10, 69, 10, 78, 
	10, 68, 10, 95, 10, 37, 10, 32, 
	-109, -117, -27, -83, -112, 58, 10, 10, 
	-27, 10, 32, 35, 124, 9, 13, -118, 
	10, -97, 10, -24, 10, -125, 10, -67, 
	10, 10, 58, -69, -65, 0
]

class << self
	attr_accessor :_lexer_single_lengths
	private :_lexer_single_lengths, :_lexer_single_lengths=
end
self._lexer_single_lengths = [
	0, 13, 2, 1, 1, 1, 1, 2, 
	2, 12, 4, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 8, 2, 
	2, 2, 2, 2, 2, 12, 2, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 10, 2, 2, 2, 2, 2, 
	5, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 3, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 1, 1, 
	1, 1, 1, 1, 1, 2, 2, 3, 
	3, 3, 3, 2, 2, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 3, 5, 
	3, 2, 4, 3, 2, 4, 12, 3, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	3, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 1, 1, 1, 1, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 10, 2, 
	2, 2, 2, 2, 5, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 1, 10, 2, 
	2, 2, 2, 2, 5, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 3, 2, 2, 2, 2, 2, 
	2, 3, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 5, 2, 
	2, 2, 2, 2, 2, 1, 1, 0
]

class << self
	attr_accessor :_lexer_range_lengths
	private :_lexer_range_lengths, :_lexer_range_lengths=
end
self._lexer_range_lengths = [
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	1, 1, 1, 1, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 1, 
	1, 1, 1, 0, 0, 1, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0
]

class << self
	attr_accessor :_lexer_index_offsets
	private :_lexer_index_offsets, :_lexer_index_offsets=
end
self._lexer_index_offsets = [
	0, 0, 15, 18, 20, 22, 24, 26, 
	29, 32, 46, 51, 53, 55, 57, 59, 
	61, 63, 65, 67, 69, 71, 73, 83, 
	86, 89, 92, 95, 98, 101, 115, 118, 
	120, 122, 124, 126, 128, 130, 132, 134, 
	136, 138, 140, 152, 155, 158, 161, 164, 
	167, 173, 176, 179, 182, 185, 188, 191, 
	194, 197, 200, 203, 206, 209, 212, 216, 
	219, 222, 225, 228, 231, 234, 237, 240, 
	243, 246, 249, 252, 255, 258, 261, 264, 
	267, 270, 273, 276, 279, 282, 285, 288, 
	291, 294, 297, 300, 303, 306, 309, 311, 
	313, 315, 317, 319, 321, 323, 326, 329, 
	334, 339, 344, 349, 353, 357, 360, 362, 
	364, 366, 368, 370, 372, 374, 376, 378, 
	380, 382, 384, 386, 388, 390, 392, 397, 
	404, 409, 413, 419, 423, 426, 432, 446, 
	450, 453, 456, 459, 462, 465, 468, 471, 
	474, 478, 481, 484, 487, 490, 493, 496, 
	499, 502, 505, 508, 511, 514, 517, 520, 
	523, 526, 529, 532, 535, 538, 541, 544, 
	547, 550, 552, 554, 556, 558, 561, 563, 
	565, 567, 569, 571, 573, 575, 577, 589, 
	592, 595, 598, 601, 604, 610, 613, 616, 
	619, 622, 625, 628, 631, 634, 637, 640, 
	643, 646, 649, 652, 655, 658, 661, 664, 
	667, 670, 673, 676, 679, 682, 685, 688, 
	691, 694, 697, 700, 703, 706, 709, 712, 
	715, 718, 721, 724, 727, 729, 731, 743, 
	746, 749, 752, 755, 758, 764, 767, 770, 
	773, 776, 779, 782, 785, 788, 791, 794, 
	797, 800, 803, 807, 810, 813, 816, 819, 
	822, 825, 829, 832, 835, 838, 841, 844, 
	847, 850, 853, 856, 859, 862, 865, 868, 
	871, 874, 877, 880, 883, 886, 889, 892, 
	895, 898, 901, 904, 907, 910, 913, 915, 
	917, 919, 921, 923, 925, 927, 929, 936, 
	939, 942, 945, 948, 951, 954, 956, 958
]

class << self
	attr_accessor :_lexer_indicies
	private :_lexer_indicies, :_lexer_indicies=
end
self._lexer_indicies = [
	1, 2, 3, 4, 5, 7, 6, 8, 
	9, 10, 11, 12, 13, 6, 0, 14, 
	15, 0, 16, 0, 17, 0, 18, 0, 
	19, 0, 21, 22, 20, 24, 25, 23, 
	1, 2, 3, 4, 7, 6, 8, 9, 
	10, 11, 12, 13, 6, 0, 26, 27, 
	28, 29, 0, 30, 0, 31, 0, 32, 
	0, 19, 0, 33, 0, 34, 0, 35, 
	0, 36, 0, 37, 0, 39, 38, 41, 
	40, 42, 43, 44, 41, 45, 46, 47, 
	46, 45, 40, 48, 41, 40, 49, 41, 
	40, 50, 41, 40, 51, 41, 40, 52, 
	41, 40, 41, 53, 40, 54, 55, 56, 
	57, 59, 58, 60, 61, 62, 63, 64, 
	65, 58, 0, 66, 67, 0, 68, 0, 
	69, 0, 70, 0, 19, 0, 71, 0, 
	72, 0, 73, 0, 74, 0, 75, 0, 
	77, 76, 79, 78, 80, 81, 82, 83, 
	79, 84, 85, 86, 87, 85, 84, 78, 
	88, 79, 78, 89, 79, 78, 90, 79, 
	78, 91, 79, 78, 92, 79, 78, 93, 
	94, 95, 96, 79, 78, 97, 79, 78, 
	98, 79, 78, 99, 79, 78, 92, 79, 
	78, 100, 79, 78, 101, 79, 78, 102, 
	79, 78, 103, 79, 78, 79, 92, 78, 
	104, 79, 78, 105, 79, 78, 106, 79, 
	78, 107, 79, 78, 108, 79, 92, 78, 
	109, 79, 78, 110, 79, 78, 111, 79, 
	78, 112, 79, 78, 103, 79, 78, 92, 
	79, 78, 113, 79, 78, 114, 79, 78, 
	115, 79, 78, 116, 79, 78, 92, 79, 
	78, 117, 79, 78, 118, 79, 78, 119, 
	79, 78, 120, 79, 78, 92, 79, 78, 
	79, 121, 78, 79, 122, 78, 79, 123, 
	78, 79, 124, 78, 79, 125, 78, 79, 
	126, 78, 79, 127, 78, 79, 128, 78, 
	79, 129, 78, 79, 130, 78, 79, 131, 
	78, 79, 132, 78, 79, 133, 78, 79, 
	134, 78, 79, 92, 78, 135, 0, 136, 
	0, 137, 0, 138, 0, 19, 0, 139, 
	0, 140, 0, 142, 143, 141, 145, 146, 
	144, 149, 148, 150, 148, 147, 153, 152, 
	154, 152, 151, 153, 152, 155, 152, 151, 
	153, 152, 156, 152, 151, 158, 157, 157, 
	0, 7, 159, 159, 0, 161, 162, 160, 
	7, 0, 163, 0, 164, 0, 165, 0, 
	166, 0, 167, 0, 168, 0, 169, 0, 
	170, 0, 171, 0, 172, 0, 173, 0, 
	174, 0, 175, 0, 176, 0, 19, 0, 
	0, 0, 0, 0, 177, 178, 179, 178, 
	178, 181, 180, 177, 7, 182, 12, 182, 
	0, 183, 184, 183, 0, 187, 186, 188, 
	189, 186, 185, 0, 191, 192, 190, 0, 
	191, 190, 187, 193, 191, 192, 193, 190, 
	194, 195, 196, 197, 187, 198, 199, 200, 
	201, 202, 203, 204, 198, 0, 205, 206, 
	41, 40, 207, 41, 40, 208, 41, 40, 
	209, 41, 40, 52, 41, 40, 210, 41, 
	40, 211, 41, 40, 212, 41, 40, 213, 
	41, 40, 214, 41, 53, 40, 215, 41, 
	40, 216, 41, 40, 217, 41, 40, 218, 
	41, 40, 52, 41, 40, 219, 41, 40, 
	220, 41, 40, 221, 41, 40, 222, 41, 
	40, 52, 41, 40, 41, 223, 40, 41, 
	224, 40, 41, 225, 40, 41, 226, 40, 
	41, 227, 40, 41, 228, 40, 41, 229, 
	40, 41, 230, 40, 41, 231, 40, 41, 
	232, 40, 41, 233, 40, 41, 234, 40, 
	41, 235, 40, 41, 236, 40, 237, 0, 
	238, 0, 239, 0, 240, 0, 241, 242, 
	0, 243, 0, 244, 0, 245, 0, 246, 
	0, 247, 0, 248, 0, 250, 249, 252, 
	251, 253, 254, 255, 256, 252, 257, 258, 
	259, 260, 258, 257, 251, 261, 252, 251, 
	262, 252, 251, 263, 252, 251, 264, 252, 
	251, 265, 252, 251, 266, 267, 268, 269, 
	252, 251, 270, 252, 251, 271, 252, 251, 
	272, 252, 251, 265, 252, 251, 273, 252, 
	251, 274, 252, 251, 275, 252, 251, 276, 
	252, 251, 252, 265, 251, 277, 252, 251, 
	278, 252, 251, 279, 252, 251, 276, 252, 
	251, 265, 252, 251, 280, 252, 251, 281, 
	252, 251, 282, 252, 251, 283, 252, 251, 
	265, 252, 251, 284, 252, 251, 285, 252, 
	251, 286, 252, 251, 287, 252, 251, 265, 
	252, 251, 252, 288, 251, 252, 289, 251, 
	252, 290, 251, 252, 291, 251, 252, 292, 
	251, 252, 293, 251, 252, 294, 251, 252, 
	295, 251, 252, 296, 251, 252, 297, 251, 
	252, 298, 251, 252, 299, 251, 252, 300, 
	251, 252, 301, 251, 252, 265, 251, 303, 
	302, 305, 304, 306, 307, 308, 309, 305, 
	310, 311, 312, 313, 311, 310, 304, 314, 
	305, 304, 315, 305, 304, 316, 305, 304, 
	317, 305, 304, 318, 305, 304, 319, 320, 
	321, 322, 305, 304, 323, 305, 304, 324, 
	305, 304, 325, 305, 304, 318, 305, 304, 
	326, 305, 304, 327, 305, 304, 328, 305, 
	304, 329, 305, 304, 305, 318, 304, 330, 
	305, 304, 331, 305, 304, 332, 305, 304, 
	333, 305, 304, 334, 305, 318, 304, 335, 
	305, 304, 336, 305, 304, 337, 305, 304, 
	338, 305, 304, 329, 305, 304, 318, 305, 
	304, 339, 340, 305, 304, 341, 305, 304, 
	342, 305, 304, 343, 305, 304, 318, 305, 
	304, 344, 305, 304, 345, 305, 304, 346, 
	305, 304, 329, 305, 304, 347, 305, 304, 
	348, 305, 304, 349, 305, 304, 350, 305, 
	304, 318, 305, 304, 305, 351, 304, 305, 
	352, 304, 305, 353, 304, 305, 354, 304, 
	305, 355, 304, 305, 356, 304, 305, 357, 
	304, 305, 358, 304, 305, 359, 304, 305, 
	360, 304, 305, 361, 304, 305, 362, 304, 
	305, 363, 304, 305, 364, 304, 305, 318, 
	304, 19, 0, 365, 0, 366, 0, 367, 
	0, 368, 0, 369, 0, 371, 370, 373, 
	372, 374, 373, 375, 376, 376, 375, 372, 
	377, 373, 372, 378, 373, 372, 379, 373, 
	372, 380, 373, 372, 381, 373, 372, 373, 
	382, 372, 383, 0, 6, 0, 384, 0
]

class << self
	attr_accessor :_lexer_trans_targs
	private :_lexer_trans_targs, :_lexer_trans_targs=
end
self._lexer_trans_targs = [
	0, 2, 10, 30, 94, 301, 9, 9, 
	99, 109, 111, 125, 126, 129, 3, 287, 
	4, 5, 6, 7, 8, 9, 110, 8, 
	9, 110, 11, 15, 169, 286, 12, 13, 
	14, 16, 17, 18, 19, 20, 21, 22, 
	21, 22, 23, 135, 150, 22, 9, 155, 
	24, 25, 26, 27, 28, 29, 2, 10, 
	30, 94, 9, 9, 99, 109, 111, 125, 
	126, 129, 31, 35, 32, 33, 34, 36, 
	37, 38, 39, 40, 41, 42, 41, 42, 
	43, 48, 69, 74, 42, 9, 79, 93, 
	44, 45, 46, 47, 29, 49, 53, 58, 
	68, 50, 51, 52, 54, 55, 56, 57, 
	59, 60, 61, 62, 63, 64, 65, 66, 
	67, 70, 71, 72, 73, 75, 76, 77, 
	78, 80, 81, 82, 83, 84, 85, 86, 
	87, 88, 89, 90, 91, 92, 9, 95, 
	96, 97, 98, 100, 101, 102, 103, 102, 
	102, 103, 102, 104, 104, 104, 105, 104, 
	104, 104, 105, 106, 107, 108, 9, 108, 
	109, 9, 110, 112, 113, 114, 115, 116, 
	117, 118, 119, 120, 121, 122, 123, 124, 
	303, 127, 128, 9, 127, 126, 128, 129, 
	130, 131, 133, 134, 132, 130, 131, 132, 
	130, 133, 2, 10, 30, 94, 134, 99, 
	109, 111, 125, 126, 129, 136, 140, 137, 
	138, 139, 141, 142, 143, 144, 145, 146, 
	147, 148, 149, 151, 152, 153, 154, 156, 
	157, 158, 159, 160, 161, 162, 163, 164, 
	165, 166, 167, 168, 9, 170, 171, 172, 
	173, 174, 228, 175, 176, 177, 178, 179, 
	180, 181, 182, 181, 182, 183, 188, 203, 
	208, 182, 9, 213, 227, 184, 185, 186, 
	187, 29, 189, 193, 198, 202, 190, 191, 
	192, 194, 195, 196, 197, 199, 200, 201, 
	204, 205, 206, 207, 209, 210, 211, 212, 
	214, 215, 216, 217, 218, 219, 220, 221, 
	222, 223, 224, 225, 226, 9, 229, 230, 
	229, 230, 231, 236, 257, 266, 230, 9, 
	271, 285, 232, 233, 234, 235, 29, 237, 
	241, 246, 256, 238, 239, 240, 242, 243, 
	244, 245, 247, 248, 249, 250, 251, 252, 
	253, 254, 255, 258, 262, 259, 260, 261, 
	263, 264, 265, 267, 268, 269, 270, 272, 
	273, 274, 275, 276, 277, 278, 279, 280, 
	281, 282, 283, 284, 9, 288, 289, 290, 
	291, 292, 293, 294, 293, 294, 295, 294, 
	9, 296, 297, 298, 299, 300, 29, 302, 
	0
]

class << self
	attr_accessor :_lexer_trans_actions
	private :_lexer_trans_actions, :_lexer_trans_actions=
end
self._lexer_trans_actions = [
	43, 29, 29, 29, 29, 0, 0, 54, 
	3, 1, 0, 29, 1, 35, 0, 0, 
	0, 0, 0, 0, 57, 149, 126, 0, 
	110, 23, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 57, 144, 
	0, 54, 84, 84, 84, 0, 69, 33, 
	0, 0, 0, 0, 0, 13, 63, 63, 
	63, 63, 31, 130, 60, 57, 31, 63, 
	57, 66, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 57, 144, 0, 54, 
	84, 84, 84, 84, 0, 72, 33, 84, 
	0, 0, 0, 0, 15, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 15, 0, 
	0, 0, 0, 0, 0, 7, 139, 48, 
	0, 102, 9, 5, 45, 134, 45, 0, 
	33, 122, 33, 33, 0, 11, 106, 0, 
	0, 114, 25, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 27, 118, 27, 51, 0, 0, 
	0, 37, 37, 54, 37, 87, 0, 0, 
	39, 0, 96, 96, 96, 96, 0, 93, 
	90, 41, 96, 90, 99, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 13, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 57, 144, 0, 54, 84, 84, 84, 
	84, 0, 78, 33, 84, 0, 0, 0, 
	0, 19, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 19, 57, 144, 
	0, 54, 84, 84, 84, 84, 0, 75, 
	33, 84, 0, 0, 0, 0, 17, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 17, 0, 0, 0, 
	0, 0, 57, 144, 0, 54, 84, 0, 
	81, 0, 0, 0, 0, 0, 21, 0, 
	0
]

class << self
	attr_accessor :_lexer_eof_actions
	private :_lexer_eof_actions, :_lexer_eof_actions=
end
self._lexer_eof_actions = [
	0, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43
]

class << self
	attr_accessor :lexer_start
end
self.lexer_start = 1;
class << self
	attr_accessor :lexer_first_final
end
self.lexer_first_final = 303;
class << self
	attr_accessor :lexer_error
end
self.lexer_error = 0;

class << self
	attr_accessor :lexer_en_main
end
self.lexer_en_main = 1;


# line 128 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
      end
 
      def scan(data)
        data = (data + "\n%_FEATURE_END_%").unpack("c*") # Explicit EOF simplifies things considerably
        eof = pe = data.length
 
        @line_number = 1
        @last_newline = 0
 
        
# line 630 "lib/gherkin/rb_lexer/zh_cn.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = lexer_start
end

# line 138 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
        
# line 639 "lib/gherkin/rb_lexer/zh_cn.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _lexer_key_offsets[cs]
	_trans = _lexer_index_offsets[cs]
	_klen = _lexer_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < _lexer_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > _lexer_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _lexer_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < _lexer_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > _lexer_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _lexer_indicies[_trans]
	cs = _lexer_trans_targs[_trans]
	if _lexer_trans_actions[_trans] != 0
		_acts = _lexer_trans_actions[_trans]
		_nacts = _lexer_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _lexer_actions[_acts - 1]
when 0 then
# line 9 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @content_start = p
          @current_line = @line_number
          @start_col = p - @last_newline - "#{@keyword}:".length
        		end
when 1 then
# line 15 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @current_line = @line_number
          @start_col = p - @last_newline
        		end
when 2 then
# line 20 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @content_start = p
        		end
when 3 then
# line 24 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @docstring_content_type_start = p
        		end
when 4 then
# line 27 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @docstring_content_type_end = p
        		end
when 5 then
# line 31 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          con = unindent(@start_col, utf8_pack(data[@content_start...@next_keyword_start-1]).sub(/(\r?\n)?([\t ])*\Z/, '').gsub(/\\"\\"\\"/, '"""'))
          con_type = utf8_pack(data[@docstring_content_type_start...@docstring_content_type_end]).strip
          @listener.doc_string(con_type, con, @current_line) 
        		end
when 6 then
# line 36 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          p = store_keyword_content(:feature, data, p, eof)
        		end
when 7 then
# line 40 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          p = store_keyword_content(:background, data, p, eof)
        		end
when 8 then
# line 44 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          p = store_keyword_content(:scenario, data, p, eof)
        		end
when 9 then
# line 48 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          p = store_keyword_content(:scenario_outline, data, p, eof)
        		end
when 10 then
# line 52 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          p = store_keyword_content(:examples, data, p, eof)
        		end
when 11 then
# line 56 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.step(@keyword, con, @current_line)
        		end
when 12 then
# line 61 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.comment(con, @line_number)
          @keyword_start = nil
        		end
when 13 then
# line 67 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.tag(con, @current_line)
          @keyword_start = nil
        		end
when 14 then
# line 73 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @line_number += 1
        		end
when 15 then
# line 77 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @last_newline = p + 1
        		end
when 16 then
# line 81 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @keyword_start ||= p
        		end
when 17 then
# line 85 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @keyword = utf8_pack(data[@keyword_start...p]).sub(/:$/,'')
          @keyword_start = nil
        		end
when 18 then
# line 90 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @next_keyword_start = p
        		end
when 19 then
# line 94 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          p = p - 1
          current_row = []
          @current_line = @line_number
        		end
when 20 then
# line 100 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @content_start = p
        		end
when 21 then
# line 104 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          current_row << con.gsub(/\\\|/, "|").gsub(/\\n/, "\n").gsub(/\\\\/, "\\")
        		end
when 22 then
# line 109 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          @listener.row(current_row, @current_line)
        		end
when 23 then
# line 113 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          if cs < lexer_first_final
            content = current_line_content(data, p)
            raise Gherkin::Lexer::LexingError.new("Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information." % [@line_number, content])
          else
            @listener.eof
          end
        		end
# line 883 "lib/gherkin/rb_lexer/zh_cn.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	__acts = _lexer_eof_actions[cs]
	__nacts =  _lexer_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _lexer_actions[__acts - 1]
when 23 then
# line 113 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
		begin

          if cs < lexer_first_final
            content = current_line_content(data, p)
            raise Gherkin::Lexer::LexingError.new("Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information." % [@line_number, content])
          else
            @listener.eof
          end
        		end
# line 922 "lib/gherkin/rb_lexer/zh_cn.rb"
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 139 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.rb.rl"
      end

      def unindent(startcol, text)
        text.gsub(/^[\t ]{0,#{startcol}}/, "")
      end

      def store_keyword_content(event, data, p, eof)
        end_point = (!@next_keyword_start or (p == eof)) ? p : @next_keyword_start
        content = unindent(@start_col + 2, utf8_pack(data[@content_start...end_point])).rstrip
        content_lines = content.split("\n")
        name = content_lines.shift || ""
        name.strip!
        description = content_lines.join("\n")
        @listener.__send__(event, @keyword, name, description, @current_line)
        @next_keyword_start ? @next_keyword_start - 1 : p
      ensure
        @next_keyword_start = nil
      end
      
      def current_line_content(data, p)
        rest = data[@last_newline..-1]
        utf8_pack(rest[0..rest.index(10)||-1]).strip # 10 is \n
      end

      if (RUBY_VERSION =~ /^1\.9/)
        def utf8_pack(array)
          array.pack("c*").force_encoding("UTF-8")
        end
      else
        def utf8_pack(array)
          array.pack("c*")
        end
      end
    end
  end
end
