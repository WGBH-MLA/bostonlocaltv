
#line 1 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
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


#line 254 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"


/** Data **/

#line 89 "ext/gherkin_lexer_zh_tw/gherkin_lexer_zh_tw.c"
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
	0, 0, 16, 19, 20, 21, 22, 23, 
	25, 27, 42, 45, 46, 47, 48, 49, 
	51, 52, 53, 54, 56, 57, 58, 59, 
	60, 61, 62, 63, 64, 77, 80, 82, 
	84, 86, 88, 103, 104, 105, 107, 108, 
	109, 110, 111, 112, 113, 114, 115, 128, 
	131, 133, 135, 137, 139, 141, 143, 145, 
	147, 151, 153, 155, 157, 159, 162, 164, 
	166, 168, 171, 173, 175, 177, 179, 181, 
	183, 185, 187, 189, 191, 193, 195, 197, 
	199, 201, 203, 205, 207, 209, 211, 213, 
	215, 217, 219, 221, 223, 225, 227, 229, 
	231, 233, 235, 237, 239, 241, 243, 245, 
	246, 247, 248, 249, 250, 251, 252, 254, 
	256, 261, 266, 271, 276, 280, 284, 286, 
	287, 288, 289, 290, 291, 292, 293, 294, 
	295, 296, 297, 298, 299, 300, 301, 302, 
	307, 314, 319, 323, 329, 332, 334, 340, 
	355, 357, 359, 361, 363, 367, 369, 371, 
	373, 375, 378, 380, 382, 384, 386, 388, 
	390, 392, 394, 396, 398, 400, 402, 404, 
	406, 408, 410, 412, 414, 416, 418, 420, 
	422, 424, 426, 428, 430, 432, 434, 436, 
	438, 440, 442, 444, 446, 448, 449, 450, 
	463, 466, 468, 470, 472, 474, 476, 478, 
	480, 482, 486, 488, 490, 492, 494, 497, 
	499, 501, 503, 506, 508, 510, 512, 514, 
	516, 518, 520, 522, 524, 526, 528, 530, 
	532, 534, 536, 539, 541, 543, 545, 547, 
	549, 551, 553, 555, 557, 559, 561, 563, 
	565, 567, 569, 571, 573, 575, 577, 579, 
	581, 583, 585, 587, 589, 590, 591, 592, 
	593, 594, 595, 605, 607, 609, 611, 613, 
	615, 617, 620, 623, 625, 627, 629, 632, 
	634, 636, 638, 640, 642, 644, 646, 648, 
	650, 652, 654, 656, 658, 660, 662, 664, 
	666, 668, 670, 672, 674, 676, 678, 680, 
	682, 684, 686, 688, 690, 692, 694, 695, 
	696, 697, 698, 699, 700, 701, 702, 703, 
	704, 705, 706, 707, 708, 709, 716, 718, 
	720, 722, 724, 726, 728, 729, 730
};

static const char _lexer_trans_keys[] = {
	-28, -27, -25, -24, -23, -17, 10, 32, 
	34, 35, 37, 42, 64, 124, 9, 13, 
	-72, -67, -66, -90, -28, -72, -108, 10, 
	13, 10, 13, -28, -27, -25, -24, -23, 
	10, 32, 34, 35, 37, 42, 64, 124, 
	9, 13, -127, -118, -96, -121, -24, -88, 
	-83, -121, -97, -26, -100, -84, -27, 58, 
	-92, -89, -25, -74, -79, 58, 10, 10, 
	-28, -27, -25, -24, -23, 10, 32, 35, 
	37, 42, 64, 9, 13, -72, -67, 10, 
	-90, 10, -28, 10, -72, 10, -108, 10, 
	-28, -27, -25, -24, -23, 10, 32, 34, 
	35, 37, 42, 64, 124, 9, 13, -107, 
	-74, -128, -125, -116, -116, -26, -103, -81, 
	58, 10, 10, -28, -27, -25, -24, -23, 
	10, 32, 35, 37, 42, 64, 9, 13, 
	-72, -67, 10, -90, 10, -28, 10, -72, 
	10, -108, 10, -122, 10, -26, 10, -104, 
	10, -81, 10, -127, -118, -96, 10, -121, 
	10, -24, 10, -88, 10, -83, 10, -121, 
	-97, 10, -26, 10, -100, 10, -84, 10, 
	-27, 10, 58, -92, 10, -89, 10, -25, 
	10, -74, 10, -79, 10, 10, 58, -24, 
	10, -125, 10, -67, 10, -76, 10, -26, 
	10, -103, 10, -81, 10, -107, 10, -74, 
	10, -128, 10, -116, 10, -126, 10, -93, 
	10, -23, 10, -70, 10, -68, 10, 10, 
	95, 10, 70, 10, 69, 10, 65, 10, 
	84, 10, 85, 10, 82, 10, 69, 10, 
	95, 10, 69, 10, 78, 10, 68, 10, 
	95, 10, 37, 10, 32, -126, -93, -23, 
	-70, -68, 34, 34, 10, 13, 10, 13, 
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
	92, 124, 9, 13, -28, -27, -25, -24, 
	-23, 10, 32, 34, 35, 37, 42, 64, 
	124, 9, 13, -122, 10, -26, 10, -104, 
	10, -81, 10, -127, -118, -96, 10, -121, 
	10, -24, 10, -88, 10, -83, 10, -121, 
	-97, 10, -26, 10, -100, 10, -84, 10, 
	10, 58, -24, 10, -125, 10, -67, 10, 
	-76, 10, -26, 10, -103, 10, -81, 10, 
	-107, 10, -74, 10, -128, 10, -116, 10, 
	-126, 10, -93, 10, -23, 10, -70, 10, 
	-68, 10, 10, 95, 10, 70, 10, 69, 
	10, 65, 10, 84, 10, 85, 10, 82, 
	10, 69, 10, 95, 10, 69, 10, 78, 
	10, 68, 10, 95, 10, 37, 10, 32, 
	10, 10, -28, -27, -25, -24, -23, 10, 
	32, 35, 37, 42, 64, 9, 13, -72, 
	-67, 10, -90, 10, -28, 10, -72, 10, 
	-108, 10, -122, 10, -26, 10, -104, 10, 
	-81, 10, -127, -118, -96, 10, -121, 10, 
	-24, 10, -88, 10, -83, 10, -121, -97, 
	10, -26, 10, -100, 10, -84, 10, -27, 
	10, 58, -92, 10, -89, 10, -25, 10, 
	-74, 10, -79, 10, 10, 58, -24, 10, 
	-125, 10, -67, 10, -76, 10, -26, 10, 
	-103, 10, -81, 10, -107, 10, -74, 10, 
	-128, -125, 10, -116, 10, -116, 10, -26, 
	10, -103, 10, -81, 10, -126, 10, -93, 
	10, -23, 10, -70, 10, -68, 10, 10, 
	95, 10, 70, 10, 69, 10, 65, 10, 
	84, 10, 85, 10, 82, 10, 69, 10, 
	95, 10, 69, 10, 78, 10, 68, 10, 
	95, 10, 37, 10, 32, -24, -125, -67, 
	58, 10, 10, -28, -27, -24, 10, 32, 
	35, 37, 64, 9, 13, -66, 10, -117, 
	10, -27, 10, -83, 10, -112, 10, 10, 
	58, -118, -96, 10, -121, -97, 10, -26, 
	10, -100, 10, -84, 10, -27, 10, 58, 
	-92, 10, -89, 10, -25, 10, -74, 10, 
	-79, 10, -24, 10, -125, 10, -67, 10, 
	-76, 10, -26, 10, -103, 10, -81, 10, 
	-125, 10, -116, 10, -26, 10, -103, 10, 
	-81, 10, 10, 95, 10, 70, 10, 69, 
	10, 65, 10, 84, 10, 85, 10, 82, 
	10, 69, 10, 95, 10, 69, 10, 78, 
	10, 68, 10, 95, 10, 37, -76, -26, 
	-103, -81, -122, -26, -104, -81, -117, -27, 
	-83, -112, 58, 10, 10, -27, 10, 32, 
	35, 124, 9, 13, -118, 10, -97, 10, 
	-24, 10, -125, 10, -67, 10, 10, 58, 
	-69, -65, 0
};

static const char _lexer_single_lengths[] = {
	0, 14, 3, 1, 1, 1, 1, 2, 
	2, 13, 3, 1, 1, 1, 1, 2, 
	1, 1, 1, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 11, 3, 2, 2, 
	2, 2, 13, 1, 1, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 11, 3, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	4, 2, 2, 2, 2, 3, 2, 2, 
	2, 3, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 1, 
	1, 1, 1, 1, 1, 1, 2, 2, 
	3, 3, 3, 3, 2, 2, 2, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 3, 
	5, 3, 2, 4, 3, 2, 4, 13, 
	2, 2, 2, 2, 4, 2, 2, 2, 
	2, 3, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 1, 1, 11, 
	3, 2, 2, 2, 2, 2, 2, 2, 
	2, 4, 2, 2, 2, 2, 3, 2, 
	2, 2, 3, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 3, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 1, 1, 1, 
	1, 1, 8, 2, 2, 2, 2, 2, 
	2, 3, 3, 2, 2, 2, 3, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 5, 2, 2, 
	2, 2, 2, 2, 1, 1, 0
};

static const char _lexer_range_lengths[] = {
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 1, 1, 1, 1, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	1, 1, 1, 1, 0, 0, 1, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0
};

static const short _lexer_index_offsets[] = {
	0, 0, 16, 20, 22, 24, 26, 28, 
	31, 34, 49, 53, 55, 57, 59, 61, 
	64, 66, 68, 70, 73, 75, 77, 79, 
	81, 83, 85, 87, 89, 102, 106, 109, 
	112, 115, 118, 133, 135, 137, 140, 142, 
	144, 146, 148, 150, 152, 154, 156, 169, 
	173, 176, 179, 182, 185, 188, 191, 194, 
	197, 202, 205, 208, 211, 214, 218, 221, 
	224, 227, 231, 234, 237, 240, 243, 246, 
	249, 252, 255, 258, 261, 264, 267, 270, 
	273, 276, 279, 282, 285, 288, 291, 294, 
	297, 300, 303, 306, 309, 312, 315, 318, 
	321, 324, 327, 330, 333, 336, 339, 342, 
	344, 346, 348, 350, 352, 354, 356, 359, 
	362, 367, 372, 377, 382, 386, 390, 393, 
	395, 397, 399, 401, 403, 405, 407, 409, 
	411, 413, 415, 417, 419, 421, 423, 425, 
	430, 437, 442, 446, 452, 456, 459, 465, 
	480, 483, 486, 489, 492, 497, 500, 503, 
	506, 509, 513, 516, 519, 522, 525, 528, 
	531, 534, 537, 540, 543, 546, 549, 552, 
	555, 558, 561, 564, 567, 570, 573, 576, 
	579, 582, 585, 588, 591, 594, 597, 600, 
	603, 606, 609, 612, 615, 618, 620, 622, 
	635, 639, 642, 645, 648, 651, 654, 657, 
	660, 663, 668, 671, 674, 677, 680, 684, 
	687, 690, 693, 697, 700, 703, 706, 709, 
	712, 715, 718, 721, 724, 727, 730, 733, 
	736, 739, 742, 746, 749, 752, 755, 758, 
	761, 764, 767, 770, 773, 776, 779, 782, 
	785, 788, 791, 794, 797, 800, 803, 806, 
	809, 812, 815, 818, 821, 823, 825, 827, 
	829, 831, 833, 843, 846, 849, 852, 855, 
	858, 861, 865, 869, 872, 875, 878, 882, 
	885, 888, 891, 894, 897, 900, 903, 906, 
	909, 912, 915, 918, 921, 924, 927, 930, 
	933, 936, 939, 942, 945, 948, 951, 954, 
	957, 960, 963, 966, 969, 972, 975, 977, 
	979, 981, 983, 985, 987, 989, 991, 993, 
	995, 997, 999, 1001, 1003, 1005, 1012, 1015, 
	1018, 1021, 1024, 1027, 1030, 1032, 1034
};

static const short _lexer_trans_targs[] = {
	2, 10, 35, 37, 103, 324, 9, 9, 
	108, 118, 120, 134, 135, 138, 9, 0, 
	3, 306, 310, 0, 4, 0, 5, 0, 
	6, 0, 7, 0, 9, 119, 8, 9, 
	119, 8, 2, 10, 35, 37, 103, 9, 
	9, 108, 118, 120, 134, 135, 138, 9, 
	0, 11, 15, 302, 0, 12, 0, 13, 
	0, 14, 0, 7, 0, 16, 252, 0, 
	17, 0, 18, 0, 19, 0, 20, 189, 
	0, 21, 0, 22, 0, 23, 0, 24, 
	0, 25, 0, 26, 0, 28, 27, 28, 
	27, 29, 148, 165, 167, 169, 28, 28, 
	9, 174, 188, 9, 28, 27, 30, 144, 
	28, 27, 31, 28, 27, 32, 28, 27, 
	33, 28, 27, 34, 28, 27, 2, 10, 
	35, 37, 103, 9, 9, 108, 118, 120, 
	134, 135, 138, 9, 0, 36, 0, 7, 
	0, 38, 39, 0, 4, 0, 40, 0, 
	41, 0, 42, 0, 43, 0, 44, 0, 
	46, 45, 46, 45, 47, 56, 79, 81, 
	83, 46, 46, 9, 88, 102, 9, 46, 
	45, 48, 52, 46, 45, 49, 46, 45, 
	50, 46, 45, 51, 46, 45, 34, 46, 
	45, 53, 46, 45, 54, 46, 45, 55, 
	46, 45, 34, 46, 45, 57, 61, 75, 
	46, 45, 58, 46, 45, 59, 46, 45, 
	60, 46, 45, 34, 46, 45, 62, 72, 
	46, 45, 63, 46, 45, 64, 46, 45, 
	65, 46, 45, 66, 46, 34, 45, 67, 
	46, 45, 68, 46, 45, 69, 46, 45, 
	70, 46, 45, 71, 46, 45, 46, 34, 
	45, 73, 46, 45, 74, 46, 45, 71, 
	46, 45, 76, 46, 45, 77, 46, 45, 
	78, 46, 45, 65, 46, 45, 80, 46, 
	45, 34, 46, 45, 82, 46, 45, 49, 
	46, 45, 84, 46, 45, 85, 46, 45, 
	86, 46, 45, 87, 46, 45, 34, 46, 
	45, 46, 89, 45, 46, 90, 45, 46, 
	91, 45, 46, 92, 45, 46, 93, 45, 
	46, 94, 45, 46, 95, 45, 46, 96, 
	45, 46, 97, 45, 46, 98, 45, 46, 
	99, 45, 46, 100, 45, 46, 101, 45, 
	46, 9, 45, 46, 34, 45, 104, 0, 
	105, 0, 106, 0, 107, 0, 7, 0, 
	109, 0, 110, 0, 112, 111, 111, 112, 
	111, 111, 113, 113, 114, 113, 113, 113, 
	113, 114, 113, 113, 113, 113, 115, 113, 
	113, 113, 113, 116, 113, 113, 9, 117, 
	117, 0, 9, 117, 117, 0, 9, 119, 
	118, 9, 0, 121, 0, 122, 0, 123, 
	0, 124, 0, 125, 0, 126, 0, 127, 
	0, 128, 0, 129, 0, 130, 0, 131, 
	0, 132, 0, 133, 0, 326, 0, 7, 
	0, 0, 0, 0, 0, 136, 137, 9, 
	137, 137, 135, 136, 136, 9, 137, 135, 
	137, 0, 138, 139, 138, 0, 143, 142, 
	141, 139, 142, 140, 0, 141, 139, 140, 
	0, 141, 140, 143, 142, 141, 139, 142, 
	140, 2, 10, 35, 37, 103, 143, 143, 
	108, 118, 120, 134, 135, 138, 143, 0, 
	145, 28, 27, 146, 28, 27, 147, 28, 
	27, 34, 28, 27, 149, 153, 161, 28, 
	27, 150, 28, 27, 151, 28, 27, 152, 
	28, 27, 34, 28, 27, 154, 158, 28, 
	27, 155, 28, 27, 156, 28, 27, 157, 
	28, 27, 28, 34, 27, 159, 28, 27, 
	160, 28, 27, 157, 28, 27, 162, 28, 
	27, 163, 28, 27, 164, 28, 27, 157, 
	28, 27, 166, 28, 27, 34, 28, 27, 
	168, 28, 27, 31, 28, 27, 170, 28, 
	27, 171, 28, 27, 172, 28, 27, 173, 
	28, 27, 34, 28, 27, 28, 175, 27, 
	28, 176, 27, 28, 177, 27, 28, 178, 
	27, 28, 179, 27, 28, 180, 27, 28, 
	181, 27, 28, 182, 27, 28, 183, 27, 
	28, 184, 27, 28, 185, 27, 28, 186, 
	27, 28, 187, 27, 28, 9, 27, 28, 
	34, 27, 191, 190, 191, 190, 192, 201, 
	224, 226, 232, 191, 191, 9, 237, 251, 
	9, 191, 190, 193, 197, 191, 190, 194, 
	191, 190, 195, 191, 190, 196, 191, 190, 
	34, 191, 190, 198, 191, 190, 199, 191, 
	190, 200, 191, 190, 34, 191, 190, 202, 
	206, 220, 191, 190, 203, 191, 190, 204, 
	191, 190, 205, 191, 190, 34, 191, 190, 
	207, 217, 191, 190, 208, 191, 190, 209, 
	191, 190, 210, 191, 190, 211, 191, 34, 
	190, 212, 191, 190, 213, 191, 190, 214, 
	191, 190, 215, 191, 190, 216, 191, 190, 
	191, 34, 190, 218, 191, 190, 219, 191, 
	190, 216, 191, 190, 221, 191, 190, 222, 
	191, 190, 223, 191, 190, 210, 191, 190, 
	225, 191, 190, 34, 191, 190, 227, 228, 
	191, 190, 194, 191, 190, 229, 191, 190, 
	230, 191, 190, 231, 191, 190, 216, 191, 
	190, 233, 191, 190, 234, 191, 190, 235, 
	191, 190, 236, 191, 190, 34, 191, 190, 
	191, 238, 190, 191, 239, 190, 191, 240, 
	190, 191, 241, 190, 191, 242, 190, 191, 
	243, 190, 191, 244, 190, 191, 245, 190, 
	191, 246, 190, 191, 247, 190, 191, 248, 
	190, 191, 249, 190, 191, 250, 190, 191, 
	9, 190, 191, 34, 190, 253, 0, 254, 
	0, 255, 0, 256, 0, 258, 257, 258, 
	257, 259, 265, 283, 258, 258, 9, 288, 
	9, 258, 257, 260, 258, 257, 261, 258, 
	257, 262, 258, 257, 263, 258, 257, 264, 
	258, 257, 258, 34, 257, 266, 279, 258, 
	257, 267, 276, 258, 257, 268, 258, 257, 
	269, 258, 257, 270, 258, 257, 271, 258, 
	34, 257, 272, 258, 257, 273, 258, 257, 
	274, 258, 257, 275, 258, 257, 264, 258, 
	257, 277, 258, 257, 278, 258, 257, 264, 
	258, 257, 280, 258, 257, 281, 258, 257, 
	282, 258, 257, 270, 258, 257, 284, 258, 
	257, 285, 258, 257, 286, 258, 257, 287, 
	258, 257, 264, 258, 257, 258, 289, 257, 
	258, 290, 257, 258, 291, 257, 258, 292, 
	257, 258, 293, 257, 258, 294, 257, 258, 
	295, 257, 258, 296, 257, 258, 297, 257, 
	258, 298, 257, 258, 299, 257, 258, 300, 
	257, 258, 301, 257, 258, 9, 257, 303, 
	0, 304, 0, 305, 0, 19, 0, 307, 
	0, 308, 0, 309, 0, 7, 0, 311, 
	0, 312, 0, 313, 0, 314, 0, 315, 
	0, 317, 316, 317, 316, 318, 317, 317, 
	9, 9, 317, 316, 319, 317, 316, 320, 
	317, 316, 321, 317, 316, 322, 317, 316, 
	323, 317, 316, 317, 34, 316, 325, 0, 
	9, 0, 0, 0
};

static const unsigned char _lexer_trans_actions[] = {
	29, 29, 29, 29, 29, 0, 54, 0, 
	5, 1, 0, 29, 1, 35, 0, 43, 
	0, 0, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 149, 126, 57, 110, 
	23, 0, 29, 29, 29, 29, 29, 54, 
	0, 5, 1, 0, 29, 1, 35, 0, 
	43, 0, 0, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 144, 57, 54, 
	0, 84, 84, 84, 84, 84, 54, 0, 
	78, 33, 84, 78, 0, 0, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 19, 54, 0, 63, 63, 
	63, 63, 63, 130, 31, 60, 57, 31, 
	63, 57, 66, 31, 43, 0, 43, 0, 
	43, 0, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	144, 57, 54, 0, 84, 84, 84, 84, 
	84, 54, 0, 72, 33, 84, 72, 0, 
	0, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 15, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 15, 54, 0, 0, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 15, 54, 0, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 15, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 54, 15, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 15, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 15, 54, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 15, 0, 54, 15, 0, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 139, 48, 9, 106, 
	11, 0, 134, 45, 45, 45, 3, 122, 
	33, 33, 33, 0, 122, 33, 33, 33, 
	0, 122, 33, 0, 33, 0, 102, 7, 
	7, 43, 54, 0, 0, 43, 114, 25, 
	0, 54, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 43, 43, 43, 43, 0, 27, 118, 
	27, 27, 51, 27, 0, 54, 0, 1, 
	0, 43, 0, 0, 0, 43, 54, 37, 
	37, 87, 37, 37, 43, 0, 39, 0, 
	43, 0, 0, 54, 0, 0, 39, 0, 
	0, 96, 96, 96, 96, 96, 54, 0, 
	93, 90, 41, 96, 90, 99, 0, 43, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 19, 54, 0, 0, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 19, 54, 0, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 54, 19, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 19, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 19, 54, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 19, 0, 54, 
	19, 0, 144, 57, 54, 0, 84, 84, 
	84, 84, 84, 54, 0, 75, 33, 84, 
	75, 0, 0, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	17, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 17, 54, 0, 0, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 17, 54, 0, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 17, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	54, 17, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 17, 54, 0, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 17, 54, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	17, 0, 54, 17, 0, 0, 43, 0, 
	43, 0, 43, 0, 43, 144, 57, 54, 
	0, 84, 84, 84, 54, 0, 69, 33, 
	69, 0, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 54, 13, 0, 0, 0, 54, 
	0, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	13, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 13, 0, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 144, 57, 54, 0, 84, 54, 0, 
	81, 81, 0, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 54, 21, 0, 0, 43, 
	0, 43, 0, 0
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
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43
};

static const int lexer_start = 1;
static const int lexer_first_final = 326;
static const int lexer_error = 0;

static const int lexer_en_main = 1;


#line 258 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"

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
    
    
#line 869 "ext/gherkin_lexer_zh_tw/gherkin_lexer_zh_tw.c"
	{
	cs = lexer_start;
	}

#line 425 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
    
#line 876 "ext/gherkin_lexer_zh_tw/gherkin_lexer_zh_tw.c"
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
#line 83 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
		MARK(content_start, p);
    lexer->current_line = lexer->line_number;
    lexer->start_col = lexer->content_start - lexer->last_newline - (lexer->keyword_end - lexer->keyword_start) + 2;
  }
	break;
	case 1:
#line 89 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    MARK(content_start, p);
  }
	break;
	case 2:
#line 93 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    lexer->current_line = lexer->line_number;
    lexer->start_col = p - data - lexer->last_newline;
  }
	break;
	case 3:
#line 98 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    int len = LEN(content_start, PTR_TO(final_newline));
    int type_len = LEN(docstring_content_type_start, PTR_TO(docstring_content_type_end));

    if (len < 0) len = 0;
    if (type_len < 0) len = 0;

    store_docstring_content(listener, lexer->start_col, PTR_TO(docstring_content_type_start), type_len, PTR_TO(content_start), len, lexer->current_line);
  }
	break;
	case 4:
#line 108 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{ 
    MARK(docstring_content_type_start, p);
  }
	break;
	case 5:
#line 112 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{ 
    MARK(docstring_content_type_end, p);
  }
	break;
	case 6:
#line 116 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    STORE_KW_END_CON(feature);
  }
	break;
	case 7:
#line 120 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    STORE_KW_END_CON(background);
  }
	break;
	case 8:
#line 124 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    STORE_KW_END_CON(scenario);
  }
	break;
	case 9:
#line 128 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    STORE_KW_END_CON(scenario_outline);
  }
	break;
	case 10:
#line 132 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    STORE_KW_END_CON(examples);
  }
	break;
	case 11:
#line 136 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    store_kw_con(listener, "step",
      PTR_TO(keyword_start), LEN(keyword_start, PTR_TO(keyword_end)),
      PTR_TO(content_start), LEN(content_start, p), 
      lexer->current_line);
  }
	break;
	case 12:
#line 143 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    STORE_ATTR(comment);
    lexer->mark = 0;
  }
	break;
	case 13:
#line 148 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    STORE_ATTR(tag);
    lexer->mark = 0;
  }
	break;
	case 14:
#line 153 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    lexer->line_number += 1;
    MARK(final_newline, p);
  }
	break;
	case 15:
#line 158 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    MARK(last_newline, p + 1);
  }
	break;
	case 16:
#line 162 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    if (lexer->mark == 0) {
      MARK(mark, p);
    }
  }
	break;
	case 17:
#line 168 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    MARK(keyword_end, p);
    MARK(keyword_start, PTR_TO(mark));
    MARK(content_start, p + 1);
    lexer->mark = 0;
  }
	break;
	case 18:
#line 175 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    MARK(content_end, p);
  }
	break;
	case 19:
#line 179 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    p = p - 1;
    lexer->current_line = lexer->line_number;
    current_row = rb_ary_new();
  }
	break;
	case 20:
#line 185 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
		MARK(content_start, p);
  }
	break;
	case 21:
#line 189 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
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
#line 203 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
	{
    rb_funcall(listener, rb_intern("row"), 2, current_row, INT2FIX(lexer->current_line));
  }
	break;
	case 23:
#line 207 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
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
#line 1166 "ext/gherkin_lexer_zh_tw/gherkin_lexer_zh_tw.c"
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
#line 207 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"
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
#line 1229 "ext/gherkin_lexer_zh_tw/gherkin_lexer_zh_tw.c"
		}
	}
	}

	_out: {}
	}

#line 426 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/zh_tw.c.rl"

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

void Init_gherkin_lexer_zh_tw()
{
  mGherkin = rb_define_module("Gherkin");
  mGherkinLexer = rb_define_module_under(mGherkin, "Lexer");
  rb_eGherkinLexingError = rb_const_get(mGherkinLexer, rb_intern("LexingError"));

  mCLexer = rb_define_module_under(mGherkin, "CLexer");
  cI18nLexer = rb_define_class_under(mCLexer, "Zh_tw", rb_cObject);
  rb_define_alloc_func(cI18nLexer, CLexer_alloc);
  rb_define_method(cI18nLexer, "initialize", CLexer_init, 1);
  rb_define_method(cI18nLexer, "scan", CLexer_scan, 1);
}

