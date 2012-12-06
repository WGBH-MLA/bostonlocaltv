
#line 1 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
#include <assert.h>
#include <ruby.h>

#if defined(_WIN32)
#include <stddef.h>
#endif

#ifdef HAVE_RUBY_RE_H
#include <ruby/re.h>
#else
#include <re.h>
#endif

#ifdef HAVE_RUBY_ENCODING_H
#include <ruby/encoding.h>
#define ENCODED_STR_NEW(ptr, len) \
    rb_enc_str_new(ptr, len, rb_utf8_encoding())
#else
#define ENCODED_STR_NEW(ptr, len) \
    rb_str_new(ptr, len)
#endif

#ifndef RSTRING_PTR
#define RSTRING_PTR(s) (RSTRING(s)->ptr)
#endif

#ifndef RSTRING_LEN
#define RSTRING_LEN(s) (RSTRING(s)->len)
#endif

#define DATA_GET(FROM, TYPE, NAME) \
  Data_Get_Struct(FROM, TYPE, NAME); \
  if (NAME == NULL) { \
    rb_raise(rb_eArgError, "NULL found for " # NAME " when it shouldn't be."); \
  }
 
typedef struct lexer_state {
  int content_len;
  int line_number;
  int current_line;
  int start_col;
  size_t mark;
  size_t keyword_start;
  size_t keyword_end;
  size_t next_keyword_start;
  size_t content_start;
  size_t content_end;
  size_t docstring_content_type_start;
  size_t docstring_content_type_end;
  size_t query_start;
  size_t last_newline;
  size_t final_newline;
} lexer_state;

static VALUE mGherkin;
static VALUE mGherkinLexer;
static VALUE mCLexer;
static VALUE cI18nLexer;
static VALUE rb_eGherkinLexingError;

#define LEN(AT, P) (P - data - lexer->AT)
#define MARK(M, P) (lexer->M = (P) - data)
#define PTR_TO(P) (data + lexer->P)

#define STORE_KW_END_CON(EVENT) \
  store_multiline_kw_con(listener, # EVENT, \
    PTR_TO(keyword_start), LEN(keyword_start, PTR_TO(keyword_end - 1)), \
    PTR_TO(content_start), LEN(content_start, PTR_TO(content_end)), \
    lexer->current_line, lexer->start_col); \
    if (lexer->content_end != 0) { \
      p = PTR_TO(content_end - 1); \
    } \
    lexer->content_end = 0

#define STORE_ATTR(ATTR) \
    store_attr(listener, # ATTR, \
      PTR_TO(content_start), LEN(content_start, p), \
      lexer->line_number)


#line 254 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"


/** Data **/

#line 89 "ext/gherkin_lexer_zh_cn/gherkin_lexer_zh_cn.c"
static const char _lexer_actions[] = {
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 16, 1, 
	17, 1, 18, 1, 19, 1, 20, 1, 
	21, 1, 22, 1, 23, 2, 1, 18, 
	2, 4, 5, 2, 13, 0, 2, 14, 
	15, 2, 17, 0, 2, 17, 2, 2, 
	17, 16, 2, 17, 19, 2, 18, 6, 
	2, 18, 7, 2, 18, 8, 2, 18, 
	9, 2, 18, 10, 2, 18, 16, 2, 
	20, 21, 2, 22, 0, 2, 22, 2, 
	2, 22, 16, 2, 22, 19, 3, 3, 
	14, 15, 3, 5, 14, 15, 3, 11, 
	14, 15, 3, 12, 14, 15, 3, 13, 
	14, 15, 3, 14, 15, 18, 3, 17, 
	0, 11, 3, 17, 14, 15, 4, 1, 
	14, 15, 18, 4, 4, 5, 14, 15, 
	4, 17, 0, 14, 15, 5, 17, 0, 
	11, 14, 15
};

static const short _lexer_key_offsets[] = {
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
};

static const char _lexer_trans_keys[] = {
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
};

static const char _lexer_single_lengths[] = {
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
};

static const char _lexer_range_lengths[] = {
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
};

static const short _lexer_index_offsets[] = {
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
};

static const short _lexer_trans_targs[] = {
	2, 10, 30, 94, 301, 9, 9, 99, 
	109, 111, 125, 126, 129, 9, 0, 3, 
	287, 0, 4, 0, 5, 0, 6, 0, 
	7, 0, 9, 110, 8, 9, 110, 8, 
	2, 10, 30, 94, 9, 9, 99, 109, 
	111, 125, 126, 129, 9, 0, 11, 15, 
	169, 286, 0, 12, 0, 13, 0, 14, 
	0, 7, 0, 16, 0, 17, 0, 18, 
	0, 19, 0, 20, 0, 22, 21, 22, 
	21, 23, 135, 150, 22, 22, 9, 155, 
	9, 22, 21, 24, 22, 21, 25, 22, 
	21, 26, 22, 21, 27, 22, 21, 28, 
	22, 21, 22, 29, 21, 2, 10, 30, 
	94, 9, 9, 99, 109, 111, 125, 126, 
	129, 9, 0, 31, 35, 0, 32, 0, 
	33, 0, 34, 0, 7, 0, 36, 0, 
	37, 0, 38, 0, 39, 0, 40, 0, 
	42, 41, 42, 41, 43, 48, 69, 74, 
	42, 42, 9, 79, 93, 9, 42, 41, 
	44, 42, 41, 45, 42, 41, 46, 42, 
	41, 47, 42, 41, 29, 42, 41, 49, 
	53, 58, 68, 42, 41, 50, 42, 41, 
	51, 42, 41, 52, 42, 41, 29, 42, 
	41, 54, 42, 41, 55, 42, 41, 56, 
	42, 41, 57, 42, 41, 42, 29, 41, 
	59, 42, 41, 60, 42, 41, 61, 42, 
	41, 62, 42, 41, 63, 42, 29, 41, 
	64, 42, 41, 65, 42, 41, 66, 42, 
	41, 67, 42, 41, 57, 42, 41, 29, 
	42, 41, 70, 42, 41, 71, 42, 41, 
	72, 42, 41, 73, 42, 41, 29, 42, 
	41, 75, 42, 41, 76, 42, 41, 77, 
	42, 41, 78, 42, 41, 29, 42, 41, 
	42, 80, 41, 42, 81, 41, 42, 82, 
	41, 42, 83, 41, 42, 84, 41, 42, 
	85, 41, 42, 86, 41, 42, 87, 41, 
	42, 88, 41, 42, 89, 41, 42, 90, 
	41, 42, 91, 41, 42, 92, 41, 42, 
	9, 41, 42, 29, 41, 95, 0, 96, 
	0, 97, 0, 98, 0, 7, 0, 100, 
	0, 101, 0, 103, 102, 102, 103, 102, 
	102, 104, 104, 105, 104, 104, 104, 104, 
	105, 104, 104, 104, 104, 106, 104, 104, 
	104, 104, 107, 104, 104, 9, 108, 108, 
	0, 9, 108, 108, 0, 9, 110, 109, 
	9, 0, 112, 0, 113, 0, 114, 0, 
	115, 0, 116, 0, 117, 0, 118, 0, 
	119, 0, 120, 0, 121, 0, 122, 0, 
	123, 0, 124, 0, 303, 0, 7, 0, 
	0, 0, 0, 0, 127, 128, 9, 128, 
	128, 126, 127, 127, 9, 128, 126, 128, 
	0, 129, 130, 129, 0, 134, 133, 132, 
	130, 133, 131, 0, 132, 130, 131, 0, 
	132, 131, 134, 133, 132, 130, 133, 131, 
	2, 10, 30, 94, 134, 134, 99, 109, 
	111, 125, 126, 129, 134, 0, 136, 140, 
	22, 21, 137, 22, 21, 138, 22, 21, 
	139, 22, 21, 28, 22, 21, 141, 22, 
	21, 142, 22, 21, 143, 22, 21, 144, 
	22, 21, 145, 22, 29, 21, 146, 22, 
	21, 147, 22, 21, 148, 22, 21, 149, 
	22, 21, 28, 22, 21, 151, 22, 21, 
	152, 22, 21, 153, 22, 21, 154, 22, 
	21, 28, 22, 21, 22, 156, 21, 22, 
	157, 21, 22, 158, 21, 22, 159, 21, 
	22, 160, 21, 22, 161, 21, 22, 162, 
	21, 22, 163, 21, 22, 164, 21, 22, 
	165, 21, 22, 166, 21, 22, 167, 21, 
	22, 168, 21, 22, 9, 21, 170, 0, 
	171, 0, 172, 0, 173, 0, 174, 228, 
	0, 175, 0, 176, 0, 177, 0, 178, 
	0, 179, 0, 180, 0, 182, 181, 182, 
	181, 183, 188, 203, 208, 182, 182, 9, 
	213, 227, 9, 182, 181, 184, 182, 181, 
	185, 182, 181, 186, 182, 181, 187, 182, 
	181, 29, 182, 181, 189, 193, 198, 202, 
	182, 181, 190, 182, 181, 191, 182, 181, 
	192, 182, 181, 29, 182, 181, 194, 182, 
	181, 195, 182, 181, 196, 182, 181, 197, 
	182, 181, 182, 29, 181, 199, 182, 181, 
	200, 182, 181, 201, 182, 181, 197, 182, 
	181, 29, 182, 181, 204, 182, 181, 205, 
	182, 181, 206, 182, 181, 207, 182, 181, 
	29, 182, 181, 209, 182, 181, 210, 182, 
	181, 211, 182, 181, 212, 182, 181, 29, 
	182, 181, 182, 214, 181, 182, 215, 181, 
	182, 216, 181, 182, 217, 181, 182, 218, 
	181, 182, 219, 181, 182, 220, 181, 182, 
	221, 181, 182, 222, 181, 182, 223, 181, 
	182, 224, 181, 182, 225, 181, 182, 226, 
	181, 182, 9, 181, 182, 29, 181, 230, 
	229, 230, 229, 231, 236, 257, 266, 230, 
	230, 9, 271, 285, 9, 230, 229, 232, 
	230, 229, 233, 230, 229, 234, 230, 229, 
	235, 230, 229, 29, 230, 229, 237, 241, 
	246, 256, 230, 229, 238, 230, 229, 239, 
	230, 229, 240, 230, 229, 29, 230, 229, 
	242, 230, 229, 243, 230, 229, 244, 230, 
	229, 245, 230, 229, 230, 29, 229, 247, 
	230, 229, 248, 230, 229, 249, 230, 229, 
	250, 230, 229, 251, 230, 29, 229, 252, 
	230, 229, 253, 230, 229, 254, 230, 229, 
	255, 230, 229, 245, 230, 229, 29, 230, 
	229, 258, 262, 230, 229, 259, 230, 229, 
	260, 230, 229, 261, 230, 229, 29, 230, 
	229, 263, 230, 229, 264, 230, 229, 265, 
	230, 229, 245, 230, 229, 267, 230, 229, 
	268, 230, 229, 269, 230, 229, 270, 230, 
	229, 29, 230, 229, 230, 272, 229, 230, 
	273, 229, 230, 274, 229, 230, 275, 229, 
	230, 276, 229, 230, 277, 229, 230, 278, 
	229, 230, 279, 229, 230, 280, 229, 230, 
	281, 229, 230, 282, 229, 230, 283, 229, 
	230, 284, 229, 230, 9, 229, 230, 29, 
	229, 7, 0, 288, 0, 289, 0, 290, 
	0, 291, 0, 292, 0, 294, 293, 294, 
	293, 295, 294, 294, 9, 9, 294, 293, 
	296, 294, 293, 297, 294, 293, 298, 294, 
	293, 299, 294, 293, 300, 294, 293, 294, 
	29, 293, 302, 0, 9, 0, 0, 0
};

static const unsigned char _lexer_trans_actions[] = {
	29, 29, 29, 29, 0, 54, 0, 5, 
	1, 0, 29, 1, 35, 0, 43, 0, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 149, 126, 57, 110, 23, 0, 
	29, 29, 29, 29, 54, 0, 5, 1, 
	0, 29, 1, 35, 0, 43, 0, 0, 
	0, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 144, 57, 54, 
	0, 84, 84, 84, 54, 0, 69, 33, 
	69, 0, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 54, 13, 0, 63, 63, 63, 
	63, 130, 31, 60, 57, 31, 63, 57, 
	66, 31, 43, 0, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	144, 57, 54, 0, 84, 84, 84, 84, 
	54, 0, 72, 33, 84, 72, 0, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 15, 54, 0, 0, 
	0, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 15, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 54, 15, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 15, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 15, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 15, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 15, 54, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	15, 0, 54, 15, 0, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 139, 48, 9, 106, 11, 
	0, 134, 45, 45, 45, 3, 122, 33, 
	33, 33, 0, 122, 33, 33, 33, 0, 
	122, 33, 0, 33, 0, 102, 7, 7, 
	43, 54, 0, 0, 43, 114, 25, 0, 
	54, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	43, 43, 43, 43, 0, 27, 118, 27, 
	27, 51, 27, 0, 54, 0, 1, 0, 
	43, 0, 0, 0, 43, 54, 37, 37, 
	87, 37, 37, 43, 0, 39, 0, 43, 
	0, 0, 54, 0, 0, 39, 0, 0, 
	96, 96, 96, 96, 54, 0, 93, 90, 
	41, 96, 90, 99, 0, 43, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 13, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 13, 0, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 144, 57, 54, 
	0, 84, 84, 84, 84, 54, 0, 78, 
	33, 84, 78, 0, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 19, 54, 0, 0, 0, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 19, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 54, 19, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 19, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	19, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 19, 
	54, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 19, 0, 54, 19, 0, 144, 
	57, 54, 0, 84, 84, 84, 84, 54, 
	0, 75, 33, 84, 75, 0, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 17, 54, 0, 0, 0, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 17, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 54, 17, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 17, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 17, 54, 
	0, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 17, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 17, 54, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 17, 0, 54, 17, 
	0, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 144, 57, 54, 
	0, 84, 54, 0, 81, 81, 0, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 54, 
	21, 0, 0, 43, 0, 43, 0, 0
};

static const unsigned char _lexer_eof_actions[] = {
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
};

static const int lexer_start = 1;
static const int lexer_first_final = 303;
static const int lexer_error = 0;

static const int lexer_en_main = 1;


#line 258 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"

static VALUE 
unindent(VALUE con, int start_col)
{
  VALUE re;
  // Gherkin will crash gracefully if the string representation of start_col pushes the pattern past 32 characters
  char pat[32]; 
  snprintf(pat, 32, "^[\t ]{0,%d}", start_col); 
  re = rb_reg_regcomp(rb_str_new2(pat));
  rb_funcall(con, rb_intern("gsub!"), 2, re, rb_str_new2(""));

  return Qnil;

}

static void 
store_kw_con(VALUE listener, const char * event_name, 
             const char * keyword_at, size_t keyword_length, 
             const char * at,         size_t length, 
             int current_line)
{
  VALUE con = Qnil, kw = Qnil;
  kw = ENCODED_STR_NEW(keyword_at, keyword_length);
  con = ENCODED_STR_NEW(at, length);
  rb_funcall(con, rb_intern("strip!"), 0);
  rb_funcall(listener, rb_intern(event_name), 3, kw, con, INT2FIX(current_line)); 
}

static void
store_multiline_kw_con(VALUE listener, const char * event_name,
                      const char * keyword_at, size_t keyword_length,
                      const char * at,         size_t length,
                      int current_line, int start_col)
{
  VALUE split;
  VALUE con = Qnil, kw = Qnil, name = Qnil, desc = Qnil;

  kw = ENCODED_STR_NEW(keyword_at, keyword_length);
  con = ENCODED_STR_NEW(at, length);

  unindent(con, start_col);
  
  split = rb_str_split(con, "\n");

  name = rb_funcall(split, rb_intern("shift"), 0);
  desc = rb_ary_join(split, rb_str_new2( "\n" ));

  if( name == Qnil ) 
  {
    name = rb_str_new2("");
  }
  if( rb_funcall(desc, rb_intern("size"), 0) == 0) 
  {
    desc = rb_str_new2("");
  }
  rb_funcall(name, rb_intern("strip!"), 0);
  rb_funcall(desc, rb_intern("rstrip!"), 0);
  rb_funcall(listener, rb_intern(event_name), 4, kw, name, desc, INT2FIX(current_line)); 
}

static void 
store_attr(VALUE listener, const char * attr_type,
           const char * at, size_t length, 
           int line)
{
  VALUE val = ENCODED_STR_NEW(at, length);
  rb_funcall(listener, rb_intern(attr_type), 2, val, INT2FIX(line));
}
static void 
store_docstring_content(VALUE listener, 
          int start_col, 
          const char *type_at, size_t type_length,
          const char *at, size_t length, 
          int current_line)
{
  VALUE re2;
  VALUE unescape_escaped_quotes;
  VALUE con = ENCODED_STR_NEW(at, length);
  VALUE con_type = ENCODED_STR_NEW(type_at, type_length);

  unindent(con, start_col);

  re2 = rb_reg_regcomp(rb_str_new2("\r\\Z"));
  unescape_escaped_quotes = rb_reg_regcomp(rb_str_new2("\\\\\"\\\\\"\\\\\""));
  rb_funcall(con, rb_intern("sub!"), 2, re2, rb_str_new2(""));
  rb_funcall(con_type, rb_intern("strip!"), 0);
  rb_funcall(con, rb_intern("gsub!"), 2, unescape_escaped_quotes, rb_str_new2("\"\"\""));
  rb_funcall(listener, rb_intern("doc_string"), 3, con_type, con, INT2FIX(current_line));
}
static void 
raise_lexer_error(const char * at, int line)
{ 
  rb_raise(rb_eGherkinLexingError, "Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information.", line, at);
}

static void lexer_init(lexer_state *lexer) {
  lexer->content_start = 0;
  lexer->content_end = 0;
  lexer->content_len = 0;
  lexer->docstring_content_type_start = 0;
  lexer->docstring_content_type_end = 0;
  lexer->mark = 0;
  lexer->keyword_start = 0;
  lexer->keyword_end = 0;
  lexer->next_keyword_start = 0;
  lexer->line_number = 1;
  lexer->last_newline = 0;
  lexer->final_newline = 0;
  lexer->start_col = 0;
}

static VALUE CLexer_alloc(VALUE klass)
{
  VALUE obj;
  lexer_state *lxr = ALLOC(lexer_state);
  lexer_init(lxr);

  obj = Data_Wrap_Struct(klass, NULL, -1, lxr);

  return obj;
}

static VALUE CLexer_init(VALUE self, VALUE listener)
{
  lexer_state *lxr; 
  rb_iv_set(self, "@listener", listener);
  
  lxr = NULL;
  DATA_GET(self, lexer_state, lxr);
  lexer_init(lxr);
  
  return self;
}

static VALUE CLexer_scan(VALUE self, VALUE input)
{
  VALUE input_copy;
  char *data;
  size_t len;
  VALUE listener = rb_iv_get(self, "@listener");

  lexer_state *lexer;
  lexer = NULL;
  DATA_GET(self, lexer_state, lexer);

  input_copy = rb_str_dup(input);

  rb_str_append(input_copy, rb_str_new2("\n%_FEATURE_END_%"));
  data = RSTRING_PTR(input_copy);
  len = RSTRING_LEN(input_copy);
  
  if (len == 0) { 
    rb_raise(rb_eGherkinLexingError, "No content to lex.");
  } else {

    const char *p, *pe, *eof;
    int cs = 0;
    
    VALUE current_row = Qnil;

    p = data;
    pe = data + len;
    eof = pe;
    
    assert(*pe == '\0' && "pointer does not end on NULL");
    
    
#line 827 "ext/gherkin_lexer_zh_cn/gherkin_lexer_zh_cn.c"
	{
	cs = lexer_start;
	}

#line 425 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
    
#line 834 "ext/gherkin_lexer_zh_cn/gherkin_lexer_zh_cn.c"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_keys = _lexer_trans_keys + _lexer_key_offsets[cs];
	_trans = _lexer_index_offsets[cs];

	_klen = _lexer_single_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _lexer_range_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += ((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	cs = _lexer_trans_targs[_trans];

	if ( _lexer_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _lexer_actions + _lexer_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 0:
#line 83 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
		MARK(content_start, p);
    lexer->current_line = lexer->line_number;
    lexer->start_col = lexer->content_start - lexer->last_newline - (lexer->keyword_end - lexer->keyword_start) + 2;
  }
	break;
	case 1:
#line 89 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    MARK(content_start, p);
  }
	break;
	case 2:
#line 93 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    lexer->current_line = lexer->line_number;
    lexer->start_col = p - data - lexer->last_newline;
  }
	break;
	case 3:
#line 98 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    int len = LEN(content_start, PTR_TO(final_newline));
    int type_len = LEN(docstring_content_type_start, PTR_TO(docstring_content_type_end));

    if (len < 0) len = 0;
    if (type_len < 0) len = 0;

    store_docstring_content(listener, lexer->start_col, PTR_TO(docstring_content_type_start), type_len, PTR_TO(content_start), len, lexer->current_line);
  }
	break;
	case 4:
#line 108 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{ 
    MARK(docstring_content_type_start, p);
  }
	break;
	case 5:
#line 112 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{ 
    MARK(docstring_content_type_end, p);
  }
	break;
	case 6:
#line 116 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    STORE_KW_END_CON(feature);
  }
	break;
	case 7:
#line 120 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    STORE_KW_END_CON(background);
  }
	break;
	case 8:
#line 124 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    STORE_KW_END_CON(scenario);
  }
	break;
	case 9:
#line 128 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    STORE_KW_END_CON(scenario_outline);
  }
	break;
	case 10:
#line 132 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    STORE_KW_END_CON(examples);
  }
	break;
	case 11:
#line 136 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    store_kw_con(listener, "step",
      PTR_TO(keyword_start), LEN(keyword_start, PTR_TO(keyword_end)),
      PTR_TO(content_start), LEN(content_start, p), 
      lexer->current_line);
  }
	break;
	case 12:
#line 143 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    STORE_ATTR(comment);
    lexer->mark = 0;
  }
	break;
	case 13:
#line 148 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    STORE_ATTR(tag);
    lexer->mark = 0;
  }
	break;
	case 14:
#line 153 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    lexer->line_number += 1;
    MARK(final_newline, p);
  }
	break;
	case 15:
#line 158 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    MARK(last_newline, p + 1);
  }
	break;
	case 16:
#line 162 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    if (lexer->mark == 0) {
      MARK(mark, p);
    }
  }
	break;
	case 17:
#line 168 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    MARK(keyword_end, p);
    MARK(keyword_start, PTR_TO(mark));
    MARK(content_start, p + 1);
    lexer->mark = 0;
  }
	break;
	case 18:
#line 175 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    MARK(content_end, p);
  }
	break;
	case 19:
#line 179 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    p = p - 1;
    lexer->current_line = lexer->line_number;
    current_row = rb_ary_new();
  }
	break;
	case 20:
#line 185 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
		MARK(content_start, p);
  }
	break;
	case 21:
#line 189 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    VALUE re_pipe, re_newline, re_backslash;
    VALUE con = ENCODED_STR_NEW(PTR_TO(content_start), LEN(content_start, p));
    rb_funcall(con, rb_intern("strip!"), 0);
    re_pipe      = rb_reg_regcomp(rb_str_new2("\\\\\\|"));
    re_newline   = rb_reg_regcomp(rb_str_new2("\\\\n"));
    re_backslash = rb_reg_regcomp(rb_str_new2("\\\\\\\\"));
    rb_funcall(con, rb_intern("gsub!"), 2, re_pipe,      rb_str_new2("|"));
    rb_funcall(con, rb_intern("gsub!"), 2, re_newline,   rb_str_new2("\n"));
    rb_funcall(con, rb_intern("gsub!"), 2, re_backslash, rb_str_new2("\\"));

    rb_ary_push(current_row, con);
  }
	break;
	case 22:
#line 203 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    rb_funcall(listener, rb_intern("row"), 2, current_row, INT2FIX(lexer->current_line));
  }
	break;
	case 23:
#line 207 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    int line;
    if (cs < lexer_first_final) {
      size_t count = 0;
      VALUE newstr_val;
      char *newstr;
      int newstr_count = 0;        
      size_t len;
      const char *buff;
      if (lexer->last_newline != 0) {
        len = LEN(last_newline, eof);
        buff = PTR_TO(last_newline);
      } else {
        len = strlen(data);
        buff = data;
      }

      // Allocate as a ruby string so that it gets cleaned up by GC
      newstr_val = rb_str_new(buff, len);
      newstr = RSTRING_PTR(newstr_val);


      for (count = 0; count < len; count++) {
        if(buff[count] == 10) {
          newstr[newstr_count] = '\0'; // terminate new string at first newline found
          break;
        } else {
          if (buff[count] == '%') {
            newstr[newstr_count++] = buff[count];
            newstr[newstr_count] = buff[count];
          } else {
            newstr[newstr_count] = buff[count];
          }
        }
        newstr_count++;
      }

      line = lexer->line_number;
      lexer_init(lexer); // Re-initialize so we can scan again with the same lexer
      raise_lexer_error(newstr, line);
    } else {
      rb_funcall(listener, rb_intern("eof"), 0);
    }
  }
	break;
#line 1124 "ext/gherkin_lexer_zh_cn/gherkin_lexer_zh_cn.c"
		}
	}

_again:
	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	const char *__acts = _lexer_actions + _lexer_eof_actions[cs];
	unsigned int __nacts = (unsigned int) *__acts++;
	while ( __nacts-- > 0 ) {
		switch ( *__acts++ ) {
	case 23:
#line 207 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"
	{
    int line;
    if (cs < lexer_first_final) {
      size_t count = 0;
      VALUE newstr_val;
      char *newstr;
      int newstr_count = 0;        
      size_t len;
      const char *buff;
      if (lexer->last_newline != 0) {
        len = LEN(last_newline, eof);
        buff = PTR_TO(last_newline);
      } else {
        len = strlen(data);
        buff = data;
      }

      // Allocate as a ruby string so that it gets cleaned up by GC
      newstr_val = rb_str_new(buff, len);
      newstr = RSTRING_PTR(newstr_val);


      for (count = 0; count < len; count++) {
        if(buff[count] == 10) {
          newstr[newstr_count] = '\0'; // terminate new string at first newline found
          break;
        } else {
          if (buff[count] == '%') {
            newstr[newstr_count++] = buff[count];
            newstr[newstr_count] = buff[count];
          } else {
            newstr[newstr_count] = buff[count];
          }
        }
        newstr_count++;
      }

      line = lexer->line_number;
      lexer_init(lexer); // Re-initialize so we can scan again with the same lexer
      raise_lexer_error(newstr, line);
    } else {
      rb_funcall(listener, rb_intern("eof"), 0);
    }
  }
	break;
#line 1187 "ext/gherkin_lexer_zh_cn/gherkin_lexer_zh_cn.c"
		}
	}
	}

	_out: {}
	}

#line 426 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_cn.c.rl"

    assert(p <= pe && "data overflow after parsing execute");
    assert(lexer->content_start <= len && "content starts after data end");
    assert(lexer->mark < len && "mark is after data end");
    
    // Reset lexer by re-initializing the whole thing
    lexer_init(lexer);

    if (cs == lexer_error) {
      rb_raise(rb_eGherkinLexingError, "Invalid format, lexing fails.");
    } else {
      return Qtrue;
    }
  }
}

void Init_gherkin_lexer_zh_cn()
{
  mGherkin = rb_define_module("Gherkin");
  mGherkinLexer = rb_define_module_under(mGherkin, "Lexer");
  rb_eGherkinLexingError = rb_const_get(mGherkinLexer, rb_intern("LexingError"));

  mCLexer = rb_define_module_under(mGherkin, "CLexer");
  cI18nLexer = rb_define_class_under(mCLexer, "Zh_cn", rb_cObject);
  rb_define_alloc_func(cI18nLexer, CLexer_alloc);
  rb_define_method(cI18nLexer, "initialize", CLexer_init, 1);
  rb_define_method(cI18nLexer, "scan", CLexer_scan, 1);
}

