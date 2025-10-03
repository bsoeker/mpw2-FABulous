module mux_wb
  (input  clk,
   input  [1:0] sel,
   input  [31:0] a,
   input  [31:0] b,
   input  [31:0] c,
   output [31:0] y);
  wire [31:0] y_next;
  wire [31:0] y_reg;
  wire n1370;
  wire n1372;
  wire n1374;
  wire [2:0] n1375;
  reg [31:0] n1376;
  reg [31:0] n1383;
  assign y = y_reg; //(module output)
  /* ./mux_wb.vhd:17:12  */
  assign y_next = n1376; // (signal)
  /* ./mux_wb.vhd:18:12  */
  assign y_reg = n1383; // (signal)
  /* ./mux_wb.vhd:24:13  */
  assign n1370 = sel == 2'b00;
  /* ./mux_wb.vhd:25:13  */
  assign n1372 = sel == 2'b01;
  /* ./mux_wb.vhd:26:13  */
  assign n1374 = sel == 2'b10;
  assign n1375 = {n1374, n1372, n1370};
  /* ./mux_wb.vhd:23:9  */
  always @*
    case (n1375)
      3'b100: n1376 = c;
      3'b010: n1376 = b;
      3'b001: n1376 = a;
      default: n1376 = a;
    endcase
  /* ./mux_wb.vhd:34:9  */
  always @(posedge clk)
    n1383 <= y_next;
endmodule

module address_decoder
  (input  [31:0] addr,
   output ram_en,
   output [7:0] ram_addr,
   output uart_en,
   output [1:0] uart_addr,
   output rom_en,
   output [7:0] rom_addr,
   output io_en);
  wire [19:0] n1341;
  wire n1343;
  wire n1344;
  wire [7:0] n1346;
  wire [19:0] n1348;
  wire n1350;
  wire n1351;
  wire [7:0] n1353;
  wire [19:0] n1355;
  wire n1357;
  wire n1358;
  wire [1:0] n1360;
  wire n1363;
  wire n1364;
  assign ram_en = n1351; //(module output)
  assign ram_addr = n1353; //(module output)
  assign uart_en = n1358; //(module output)
  assign uart_addr = n1360; //(module output)
  assign rom_en = n1344; //(module output)
  assign rom_addr = n1346; //(module output)
  assign io_en = n1364; //(module output)
  /* ./address_decoder.vhd:22:28  */
  assign n1341 = addr[31:12]; // extract
  /* ./address_decoder.vhd:22:43  */
  assign n1343 = n1341 == 20'b00000000000000000000;
  /* ./address_decoder.vhd:22:19  */
  assign n1344 = n1343 ? 1'b1 : 1'b0;
  /* ./address_decoder.vhd:23:21  */
  assign n1346 = addr[7:0]; // extract
  /* ./address_decoder.vhd:26:30  */
  assign n1348 = addr[31:12]; // extract
  /* ./address_decoder.vhd:26:45  */
  assign n1350 = n1348 == 20'b00010000000000000000;
  /* ./address_decoder.vhd:26:21  */
  assign n1351 = n1350 ? 1'b1 : 1'b0;
  /* ./address_decoder.vhd:27:21  */
  assign n1353 = addr[7:0]; // extract
  /* ./address_decoder.vhd:30:31  */
  assign n1355 = addr[31:12]; // extract
  /* ./address_decoder.vhd:30:46  */
  assign n1357 = n1355 == 20'b00100000000000000000;
  /* ./address_decoder.vhd:30:22  */
  assign n1358 = n1357 ? 1'b1 : 1'b0;
  /* ./address_decoder.vhd:31:22  */
  assign n1360 = addr[3:2]; // extract
  /* ./address_decoder.vhd:34:28  */
  assign n1363 = addr == 32'b01110000000000000000000000000000;
  /* ./address_decoder.vhd:34:18  */
  assign n1364 = n1363 ? 1'b1 : 1'b0;
endmodule

module alu
  (input  clk,
   input  reset,
   input  start,
   input  [31:0] op_a,
   input  [31:0] op_b,
   input  [3:0] alu_control,
   output [31:0] result,
   output zero,
   output done);
  reg [1:0] state;
  reg carry;
  reg [4:0] bit_index;
  wire [31:0] a;
  wire [31:0] b;
  wire [31:0] r;
  wire n857;
  wire n860;
  wire [1:0] n862;
  wire n863;
  wire [4:0] n865;
  wire [31:0] n867;
  wire n869;
  wire n871;
  wire n876;
  wire n877;
  wire n882;
  wire n885;
  wire n886;
  wire n889;
  wire n890;
  wire [31:0] n893;
  wire n895;
  wire [31:0] n896;
  wire [31:0] n898;
  wire [4:0] n899;
  wire [1:0] n901;
  wire [4:0] n902;
  wire n904;
  wire n909;
  wire n910;
  wire n911;
  wire n916;
  wire n917;
  wire n920;
  wire n921;
  wire n924;
  wire n925;
  wire n926;
  wire [31:0] n929;
  wire n931;
  wire [31:0] n932;
  wire [31:0] n934;
  wire [4:0] n935;
  wire [1:0] n937;
  wire [4:0] n938;
  wire [31:0] n939;
  wire n941;
  wire [31:0] n942;
  wire n944;
  wire [31:0] n945;
  wire n947;
  wire [4:0] n948;
  wire [30:0] n949;
  wire [31:0] n950;
  wire n952;
  wire [4:0] n953;
  wire [30:0] n954;
  wire [31:0] n955;
  wire n957;
  wire [4:0] n958;
  wire [30:0] n959;
  wire [31:0] n960;
  wire n962;
  wire n963;
  localparam [31:0] n965 = 32'b00000000000000000000000000000000;
  wire [30:0] n966;
  wire [31:0] n967;
  wire [31:0] n969;
  wire n971;
  wire n972;
  localparam [31:0] n974 = 32'b00000000000000000000000000000000;
  wire [30:0] n975;
  wire [31:0] n976;
  wire [31:0] n978;
  wire n980;
  wire [7:0] n981;
  reg [31:0] n983;
  wire [1:0] n985;
  wire n986;
  wire [4:0] n987;
  wire [31:0] n988;
  wire [1:0] n991;
  wire n992;
  wire [4:0] n993;
  wire [31:0] n994;
  wire n998;
  wire n1000;
  wire [2:0] n1001;
  reg n1005;
  reg [1:0] n1008;
  reg n1010;
  reg [4:0] n1012;
  reg [31:0] n1014;
  wire n1020;
  wire [1:0] n1022;
  wire n1024;
  wire [4:0] n1026;
  wire [31:0] n1028;
  wire n1043;
  wire n1044;
  reg [1:0] n1046;
  reg n1047;
  reg [4:0] n1048;
  reg [31:0] n1049;
  reg n1050;
  wire n1051;
  wire n1052;
  wire n1053;
  wire n1054;
  wire n1055;
  wire n1056;
  wire n1057;
  wire n1058;
  wire n1059;
  wire n1060;
  wire n1061;
  wire n1062;
  wire n1063;
  wire n1064;
  wire n1065;
  wire n1066;
  wire n1067;
  wire n1068;
  wire n1069;
  wire n1070;
  wire n1071;
  wire n1072;
  wire n1073;
  wire n1074;
  wire n1075;
  wire n1076;
  wire n1077;
  wire n1078;
  wire n1079;
  wire n1080;
  wire n1081;
  wire n1082;
  wire n1083;
  wire n1084;
  wire n1085;
  wire n1086;
  wire n1087;
  wire n1088;
  wire n1089;
  wire n1090;
  wire n1091;
  wire n1092;
  wire n1093;
  wire n1094;
  wire n1095;
  wire n1096;
  wire n1097;
  wire n1098;
  wire n1099;
  wire n1100;
  wire n1101;
  wire n1102;
  wire n1103;
  wire n1104;
  wire n1105;
  wire n1106;
  wire n1107;
  wire n1108;
  wire n1109;
  wire n1110;
  wire n1111;
  wire n1112;
  wire n1113;
  wire n1114;
  wire n1115;
  wire n1116;
  wire n1117;
  wire n1118;
  wire n1119;
  wire n1120;
  wire n1121;
  wire n1122;
  wire n1123;
  wire n1124;
  wire n1125;
  wire n1126;
  wire n1127;
  wire n1128;
  wire n1129;
  wire n1130;
  wire n1131;
  wire n1132;
  wire n1133;
  wire n1134;
  wire n1135;
  wire n1136;
  wire n1137;
  wire n1138;
  wire n1139;
  wire n1140;
  wire n1141;
  wire n1142;
  wire n1143;
  wire n1144;
  wire n1145;
  wire n1146;
  wire n1147;
  wire n1148;
  wire n1149;
  wire n1150;
  wire n1151;
  wire n1152;
  wire n1153;
  wire n1154;
  wire n1155;
  wire n1156;
  wire n1157;
  wire n1158;
  wire n1159;
  wire n1160;
  wire n1161;
  wire n1162;
  wire n1163;
  wire n1164;
  wire n1165;
  wire n1166;
  wire n1167;
  wire n1168;
  wire n1169;
  wire n1170;
  wire n1171;
  wire n1172;
  wire n1173;
  wire n1174;
  wire n1175;
  wire n1176;
  wire n1177;
  wire n1178;
  wire n1179;
  wire n1180;
  wire n1181;
  wire n1182;
  wire n1183;
  wire n1184;
  wire n1185;
  wire n1186;
  wire n1187;
  wire n1188;
  wire n1189;
  wire n1190;
  wire [31:0] n1191;
  wire n1192;
  wire n1193;
  wire n1194;
  wire n1195;
  wire n1196;
  wire n1197;
  wire n1198;
  wire n1199;
  wire n1200;
  wire n1201;
  wire n1202;
  wire n1203;
  wire n1204;
  wire n1205;
  wire n1206;
  wire n1207;
  wire n1208;
  wire n1209;
  wire n1210;
  wire n1211;
  wire n1212;
  wire n1213;
  wire n1214;
  wire n1215;
  wire n1216;
  wire n1217;
  wire n1218;
  wire n1219;
  wire n1220;
  wire n1221;
  wire n1222;
  wire n1223;
  wire n1224;
  wire n1225;
  wire n1226;
  wire n1227;
  wire n1228;
  wire n1229;
  wire n1230;
  wire n1231;
  wire n1232;
  wire n1233;
  wire n1234;
  wire n1235;
  wire n1236;
  wire n1237;
  wire n1238;
  wire n1239;
  wire n1240;
  wire n1241;
  wire n1242;
  wire n1243;
  wire n1244;
  wire n1245;
  wire n1246;
  wire n1247;
  wire n1248;
  wire n1249;
  wire n1250;
  wire n1251;
  wire n1252;
  wire n1253;
  wire n1254;
  wire n1255;
  wire n1256;
  wire n1257;
  wire n1258;
  wire n1259;
  wire n1260;
  wire n1261;
  wire n1262;
  wire n1263;
  wire n1264;
  wire n1265;
  wire n1266;
  wire n1267;
  wire n1268;
  wire n1269;
  wire n1270;
  wire n1271;
  wire n1272;
  wire n1273;
  wire n1274;
  wire n1275;
  wire n1276;
  wire n1277;
  wire n1278;
  wire n1279;
  wire n1280;
  wire n1281;
  wire n1282;
  wire n1283;
  wire n1284;
  wire n1285;
  wire n1286;
  wire n1287;
  wire n1288;
  wire n1289;
  wire n1290;
  wire n1291;
  wire n1292;
  wire n1293;
  wire n1294;
  wire n1295;
  wire n1296;
  wire n1297;
  wire n1298;
  wire n1299;
  wire n1300;
  wire n1301;
  wire n1302;
  wire n1303;
  wire n1304;
  wire n1305;
  wire n1306;
  wire n1307;
  wire n1308;
  wire n1309;
  wire n1310;
  wire n1311;
  wire n1312;
  wire n1313;
  wire n1314;
  wire n1315;
  wire n1316;
  wire n1317;
  wire n1318;
  wire n1319;
  wire n1320;
  wire n1321;
  wire n1322;
  wire n1323;
  wire n1324;
  wire n1325;
  wire n1326;
  wire n1327;
  wire n1328;
  wire n1329;
  wire n1330;
  wire n1331;
  wire [31:0] n1332;
  assign result = r; //(module output)
  assign zero = n1044; //(module output)
  assign done = n1050; //(module output)
  /* ./alu.vhd:21:12  */
  always @*
    state = n1046; // (isignal)
  initial
    state = 2'b00;
  /* ./alu.vhd:23:12  */
  always @*
    carry = n1047; // (isignal)
  initial
    carry = 1'b0;
  /* ./alu.vhd:24:12  */
  always @*
    bit_index = n1048; // (isignal)
  initial
    bit_index = 5'b00000;
  /* ./alu.vhd:26:12  */
  assign a = op_a; // (signal)
  /* ./alu.vhd:26:15  */
  assign b = op_b; // (signal)
  /* ./alu.vhd:27:12  */
  assign r = n1049; // (signal)
  /* ./alu.vhd:54:44  */
  assign n857 = alu_control == 4'b0001;
  /* ./alu.vhd:54:29  */
  assign n860 = n857 ? 1'b1 : 1'b0;
  /* ./alu.vhd:50:25  */
  assign n862 = start ? 2'b01 : state;
  /* ./alu.vhd:50:25  */
  assign n863 = start ? n860 : carry;
  /* ./alu.vhd:50:25  */
  assign n865 = start ? 5'b00000 : bit_index;
  /* ./alu.vhd:50:25  */
  assign n867 = start ? 32'b00000000000000000000000000000000 : r;
  /* ./alu.vhd:48:21  */
  assign n869 = state == 2'b00;
  /* ./alu.vhd:67:40  */
  assign n871 = alu_control == 4'b0000;
  /* ./alu.vhd:68:56  */
  assign n876 = n1051 ^ n1052;
  /* ./alu.vhd:68:73  */
  assign n877 = n876 ^ carry;
  /* ./alu.vhd:69:57  */
  assign n882 = n1053 & n1054;
  /* ./alu.vhd:70:57  */
  assign n885 = n1055 & carry;
  /* ./alu.vhd:69:75  */
  assign n886 = n882 | n885;
  /* ./alu.vhd:71:57  */
  assign n889 = n1056 & carry;
  /* ./alu.vhd:70:68  */
  assign n890 = n886 | n889;
  /* ./alu.vhd:76:42  */
  assign n893 = {27'b0, bit_index};  //  uext
  /* ./alu.vhd:76:42  */
  assign n895 = n893 == 32'b00000000000000000000000000011111;
  /* ./alu.vhd:79:56  */
  assign n896 = {27'b0, bit_index};  //  uext
  /* ./alu.vhd:79:56  */
  assign n898 = n896 + 32'b00000000000000000000000000000001;
  /* ./alu.vhd:79:46  */
  assign n899 = n898[4:0];  // trunc
  /* ./alu.vhd:76:29  */
  assign n901 = n895 ? 2'b10 : state;
  /* ./alu.vhd:76:29  */
  assign n902 = n895 ? bit_index : n899;
  /* ./alu.vhd:82:43  */
  assign n904 = alu_control == 4'b0001;
  /* ./alu.vhd:83:61  */
  assign n909 = ~n1193;
  /* ./alu.vhd:83:56  */
  assign n910 = n1192 ^ n909;
  /* ./alu.vhd:83:79  */
  assign n911 = n910 ^ carry;
  /* ./alu.vhd:84:62  */
  assign n916 = ~n1195;
  /* ./alu.vhd:84:57  */
  assign n917 = n1194 & n916;
  /* ./alu.vhd:85:57  */
  assign n920 = n1196 & carry;
  /* ./alu.vhd:84:81  */
  assign n921 = n917 | n920;
  /* ./alu.vhd:86:45  */
  assign n924 = ~n1197;
  /* ./alu.vhd:86:63  */
  assign n925 = n924 & carry;
  /* ./alu.vhd:85:68  */
  assign n926 = n921 | n925;
  /* ./alu.vhd:91:42  */
  assign n929 = {27'b0, bit_index};  //  uext
  /* ./alu.vhd:91:42  */
  assign n931 = n929 == 32'b00000000000000000000000000011111;
  /* ./alu.vhd:94:56  */
  assign n932 = {27'b0, bit_index};  //  uext
  /* ./alu.vhd:94:56  */
  assign n934 = n932 + 32'b00000000000000000000000000000001;
  /* ./alu.vhd:94:46  */
  assign n935 = n934[4:0];  // trunc
  /* ./alu.vhd:91:29  */
  assign n937 = n931 ? 2'b10 : state;
  /* ./alu.vhd:91:29  */
  assign n938 = n931 ? bit_index : n935;
  /* ./alu.vhd:101:44  */
  assign n939 = a & b;
  /* ./alu.vhd:100:33  */
  assign n941 = alu_control == 4'b0010;
  /* ./alu.vhd:103:44  */
  assign n942 = a | b;
  /* ./alu.vhd:102:33  */
  assign n944 = alu_control == 4'b0011;
  /* ./alu.vhd:105:44  */
  assign n945 = a ^ b;
  /* ./alu.vhd:104:33  */
  assign n947 = alu_control == 4'b0100;
  /* ./alu.vhd:107:80  */
  assign n948 = op_b[4:0]; // extract
  /* ./alu.vhd:107:56  */
  assign n949 = {26'b0, n948};  //  uext
  /* ./alu.vhd:107:42  */
  assign n950 = a << n949;
  /* ./alu.vhd:106:33  */
  assign n952 = alu_control == 4'b0101;
  /* ./alu.vhd:109:103  */
  assign n953 = op_b[4:0]; // extract
  /* ./alu.vhd:109:79  */
  assign n954 = {26'b0, n953};  //  uext
  /* ./alu.vhd:109:51  */
  assign n955 = op_a >> n954;
  /* ./alu.vhd:108:33  */
  assign n957 = alu_control == 4'b0110;
  /* ./alu.vhd:111:101  */
  assign n958 = op_b[4:0]; // extract
  /* ./alu.vhd:111:77  */
  assign n959 = {26'b0, n958};  //  uext
  /* ./alu.vhd:111:51  */
  assign n960 = $signed(op_a) >>> n959;
  /* ./alu.vhd:110:33  */
  assign n962 = alu_control == 4'b0111;
  /* ./alu.vhd:113:53  */
  assign n963 = $signed(op_a) < $signed(op_b);
  assign n966 = n965[31:1]; // extract
  assign n967 = {n966, 1'b1};
  /* ./alu.vhd:113:37  */
  assign n969 = n963 ? n967 : 32'b00000000000000000000000000000000;
  /* ./alu.vhd:112:33  */
  assign n971 = alu_control == 4'b1000;
  /* ./alu.vhd:119:55  */
  assign n972 = $unsigned(op_a) < $unsigned(op_b);
  assign n975 = n974[31:1]; // extract
  assign n976 = {n975, 1'b1};
  /* ./alu.vhd:119:37  */
  assign n978 = n972 ? n976 : 32'b00000000000000000000000000000000;
  /* ./alu.vhd:118:33  */
  assign n980 = alu_control == 4'b1001;
  assign n981 = {n980, n971, n962, n957, n952, n947, n944, n941};
  /* ./alu.vhd:99:29  */
  always @*
    case (n981)
      8'b10000000: n983 = n978;
      8'b01000000: n983 = n969;
      8'b00100000: n983 = n960;
      8'b00010000: n983 = n955;
      8'b00001000: n983 = n950;
      8'b00000100: n983 = n945;
      8'b00000010: n983 = n942;
      8'b00000001: n983 = n939;
      default: n983 = 32'b00000000000000000000000000000000;
    endcase
  /* ./alu.vhd:82:25  */
  assign n985 = n904 ? n937 : 2'b10;
  /* ./alu.vhd:82:25  */
  assign n986 = n904 ? n926 : carry;
  /* ./alu.vhd:82:25  */
  assign n987 = n904 ? n938 : bit_index;
  /* ./alu.vhd:82:25  */
  assign n988 = n904 ? n1332 : n983;
  /* ./alu.vhd:67:25  */
  assign n991 = n871 ? n901 : n985;
  /* ./alu.vhd:67:25  */
  assign n992 = n871 ? n890 : n986;
  /* ./alu.vhd:67:25  */
  assign n993 = n871 ? n902 : n987;
  /* ./alu.vhd:67:25  */
  assign n994 = n871 ? n1191 : n988;
  /* ./alu.vhd:66:21  */
  assign n998 = state == 2'b01;
  /* ./alu.vhd:134:21  */
  assign n1000 = state == 2'b10;
  assign n1001 = {n1000, n998, n869};
  /* ./alu.vhd:44:17  */
  always @*
    case (n1001)
      3'b100: n1005 = 1'b1;
      3'b010: n1005 = n1050;
      3'b001: n1005 = 1'b0;
      default: n1005 = 1'bX;
    endcase
  /* ./alu.vhd:44:17  */
  always @*
    case (n1001)
      3'b100: n1008 = 2'b00;
      3'b010: n1008 = n991;
      3'b001: n1008 = n862;
      default: n1008 = 2'bX;
    endcase
  /* ./alu.vhd:44:17  */
  always @*
    case (n1001)
      3'b100: n1010 = carry;
      3'b010: n1010 = n992;
      3'b001: n1010 = n863;
      default: n1010 = 1'bX;
    endcase
  /* ./alu.vhd:44:17  */
  always @*
    case (n1001)
      3'b100: n1012 = bit_index;
      3'b010: n1012 = n993;
      3'b001: n1012 = n865;
      default: n1012 = 5'bX;
    endcase
  /* ./alu.vhd:44:17  */
  always @*
    case (n1001)
      3'b100: n1014 = r;
      3'b010: n1014 = n994;
      3'b001: n1014 = n867;
      default: n1014 = 32'bX;
    endcase
  /* ./alu.vhd:37:13  */
  assign n1020 = reset ? 1'b0 : n1005;
  /* ./alu.vhd:37:13  */
  assign n1022 = reset ? 2'b00 : n1008;
  /* ./alu.vhd:37:13  */
  assign n1024 = reset ? 1'b0 : n1010;
  /* ./alu.vhd:37:13  */
  assign n1026 = reset ? 5'b00000 : n1012;
  /* ./alu.vhd:37:13  */
  assign n1028 = reset ? 32'b00000000000000000000000000000000 : n1014;
  /* ./alu.vhd:143:26  */
  assign n1043 = r == 32'b00000000000000000000000000000000;
  /* ./alu.vhd:143:19  */
  assign n1044 = n1043 ? 1'b1 : 1'b0;
  /* ./alu.vhd:36:9  */
  always @(posedge clk)
    n1046 <= n1022;
  initial
    n1046 = 2'b00;
  /* ./alu.vhd:36:9  */
  always @(posedge clk)
    n1047 <= n1024;
  initial
    n1047 = 1'b0;
  /* ./alu.vhd:36:9  */
  always @(posedge clk)
    n1048 <= n1026;
  initial
    n1048 = 5'b00000;
  /* ./alu.vhd:36:9  */
  always @(posedge clk)
    n1049 <= n1028;
  /* ./alu.vhd:36:9  */
  always @(posedge clk)
    n1050 <= n1020;
  /* ./alu.vhd:68:45  */
  assign n1051 = a[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:68:62  */
  assign n1052 = b[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:69:46  */
  assign n1053 = a[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:69:63  */
  assign n1054 = b[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:70:46  */
  assign n1055 = a[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:71:46  */
  assign n1056 = b[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:73:29  */
  assign n1057 = bit_index[4]; // extract
  /* ./alu.vhd:73:29  */
  assign n1058 = ~n1057;
  /* ./alu.vhd:73:29  */
  assign n1059 = bit_index[3]; // extract
  /* ./alu.vhd:73:29  */
  assign n1060 = ~n1059;
  /* ./alu.vhd:73:29  */
  assign n1061 = n1058 & n1060;
  /* ./alu.vhd:73:29  */
  assign n1062 = n1058 & n1059;
  /* ./alu.vhd:73:29  */
  assign n1063 = n1057 & n1060;
  /* ./alu.vhd:73:29  */
  assign n1064 = n1057 & n1059;
  /* ./alu.vhd:73:29  */
  assign n1065 = bit_index[2]; // extract
  /* ./alu.vhd:73:29  */
  assign n1066 = ~n1065;
  /* ./alu.vhd:73:29  */
  assign n1067 = n1061 & n1066;
  /* ./alu.vhd:73:29  */
  assign n1068 = n1061 & n1065;
  /* ./alu.vhd:73:29  */
  assign n1069 = n1062 & n1066;
  /* ./alu.vhd:73:29  */
  assign n1070 = n1062 & n1065;
  /* ./alu.vhd:73:29  */
  assign n1071 = n1063 & n1066;
  /* ./alu.vhd:73:29  */
  assign n1072 = n1063 & n1065;
  /* ./alu.vhd:73:29  */
  assign n1073 = n1064 & n1066;
  /* ./alu.vhd:73:29  */
  assign n1074 = n1064 & n1065;
  /* ./alu.vhd:73:29  */
  assign n1075 = bit_index[1]; // extract
  /* ./alu.vhd:73:29  */
  assign n1076 = ~n1075;
  /* ./alu.vhd:73:29  */
  assign n1077 = n1067 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1078 = n1067 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1079 = n1068 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1080 = n1068 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1081 = n1069 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1082 = n1069 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1083 = n1070 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1084 = n1070 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1085 = n1071 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1086 = n1071 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1087 = n1072 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1088 = n1072 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1089 = n1073 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1090 = n1073 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1091 = n1074 & n1076;
  /* ./alu.vhd:73:29  */
  assign n1092 = n1074 & n1075;
  /* ./alu.vhd:73:29  */
  assign n1093 = bit_index[0]; // extract
  /* ./alu.vhd:73:29  */
  assign n1094 = ~n1093;
  /* ./alu.vhd:73:29  */
  assign n1095 = n1077 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1096 = n1077 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1097 = n1078 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1098 = n1078 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1099 = n1079 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1100 = n1079 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1101 = n1080 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1102 = n1080 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1103 = n1081 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1104 = n1081 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1105 = n1082 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1106 = n1082 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1107 = n1083 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1108 = n1083 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1109 = n1084 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1110 = n1084 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1111 = n1085 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1112 = n1085 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1113 = n1086 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1114 = n1086 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1115 = n1087 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1116 = n1087 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1117 = n1088 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1118 = n1088 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1119 = n1089 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1120 = n1089 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1121 = n1090 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1122 = n1090 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1123 = n1091 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1124 = n1091 & n1093;
  /* ./alu.vhd:73:29  */
  assign n1125 = n1092 & n1094;
  /* ./alu.vhd:73:29  */
  assign n1126 = n1092 & n1093;
  assign n1127 = r[0]; // extract
  /* ./alu.vhd:73:29  */
  assign n1128 = n1095 ? n877 : n1127;
  assign n1129 = r[1]; // extract
  /* ./alu.vhd:73:29  */
  assign n1130 = n1096 ? n877 : n1129;
  assign n1131 = r[2]; // extract
  /* ./alu.vhd:73:29  */
  assign n1132 = n1097 ? n877 : n1131;
  assign n1133 = r[3]; // extract
  /* ./alu.vhd:73:29  */
  assign n1134 = n1098 ? n877 : n1133;
  assign n1135 = r[4]; // extract
  /* ./alu.vhd:73:29  */
  assign n1136 = n1099 ? n877 : n1135;
  assign n1137 = r[5]; // extract
  /* ./alu.vhd:73:29  */
  assign n1138 = n1100 ? n877 : n1137;
  assign n1139 = r[6]; // extract
  /* ./alu.vhd:73:29  */
  assign n1140 = n1101 ? n877 : n1139;
  assign n1141 = r[7]; // extract
  /* ./alu.vhd:73:29  */
  assign n1142 = n1102 ? n877 : n1141;
  assign n1143 = r[8]; // extract
  /* ./alu.vhd:73:29  */
  assign n1144 = n1103 ? n877 : n1143;
  assign n1145 = r[9]; // extract
  /* ./alu.vhd:73:29  */
  assign n1146 = n1104 ? n877 : n1145;
  assign n1147 = r[10]; // extract
  /* ./alu.vhd:73:29  */
  assign n1148 = n1105 ? n877 : n1147;
  assign n1149 = r[11]; // extract
  /* ./alu.vhd:73:29  */
  assign n1150 = n1106 ? n877 : n1149;
  assign n1151 = r[12]; // extract
  /* ./alu.vhd:73:29  */
  assign n1152 = n1107 ? n877 : n1151;
  assign n1153 = r[13]; // extract
  /* ./alu.vhd:73:29  */
  assign n1154 = n1108 ? n877 : n1153;
  assign n1155 = r[14]; // extract
  /* ./alu.vhd:73:29  */
  assign n1156 = n1109 ? n877 : n1155;
  assign n1157 = r[15]; // extract
  /* ./alu.vhd:73:29  */
  assign n1158 = n1110 ? n877 : n1157;
  assign n1159 = r[16]; // extract
  /* ./alu.vhd:73:29  */
  assign n1160 = n1111 ? n877 : n1159;
  assign n1161 = r[17]; // extract
  /* ./alu.vhd:73:29  */
  assign n1162 = n1112 ? n877 : n1161;
  assign n1163 = r[18]; // extract
  /* ./alu.vhd:73:29  */
  assign n1164 = n1113 ? n877 : n1163;
  assign n1165 = r[19]; // extract
  /* ./alu.vhd:73:29  */
  assign n1166 = n1114 ? n877 : n1165;
  assign n1167 = r[20]; // extract
  /* ./alu.vhd:73:29  */
  assign n1168 = n1115 ? n877 : n1167;
  assign n1169 = r[21]; // extract
  /* ./alu.vhd:73:29  */
  assign n1170 = n1116 ? n877 : n1169;
  assign n1171 = r[22]; // extract
  /* ./alu.vhd:73:29  */
  assign n1172 = n1117 ? n877 : n1171;
  assign n1173 = r[23]; // extract
  /* ./alu.vhd:73:29  */
  assign n1174 = n1118 ? n877 : n1173;
  assign n1175 = r[24]; // extract
  /* ./alu.vhd:73:29  */
  assign n1176 = n1119 ? n877 : n1175;
  assign n1177 = r[25]; // extract
  /* ./alu.vhd:73:29  */
  assign n1178 = n1120 ? n877 : n1177;
  assign n1179 = r[26]; // extract
  /* ./alu.vhd:73:29  */
  assign n1180 = n1121 ? n877 : n1179;
  assign n1181 = r[27]; // extract
  /* ./alu.vhd:73:29  */
  assign n1182 = n1122 ? n877 : n1181;
  assign n1183 = r[28]; // extract
  /* ./alu.vhd:73:29  */
  assign n1184 = n1123 ? n877 : n1183;
  assign n1185 = r[29]; // extract
  /* ./alu.vhd:73:29  */
  assign n1186 = n1124 ? n877 : n1185;
  assign n1187 = r[30]; // extract
  /* ./alu.vhd:73:29  */
  assign n1188 = n1125 ? n877 : n1187;
  assign n1189 = r[31]; // extract
  /* ./alu.vhd:73:29  */
  assign n1190 = n1126 ? n877 : n1189;
  assign n1191 = {n1190, n1188, n1186, n1184, n1182, n1180, n1178, n1176, n1174, n1172, n1170, n1168, n1166, n1164, n1162, n1160, n1158, n1156, n1154, n1152, n1150, n1148, n1146, n1144, n1142, n1140, n1138, n1136, n1134, n1132, n1130, n1128};
  /* ./alu.vhd:83:45  */
  assign n1192 = a[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:83:67  */
  assign n1193 = b[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:84:46  */
  assign n1194 = a[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:84:68  */
  assign n1195 = b[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:85:46  */
  assign n1196 = a[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:86:51  */
  assign n1197 = b[bit_index * 1 +: 1]; //(Bmux)
  /* ./alu.vhd:88:29  */
  assign n1198 = bit_index[4]; // extract
  /* ./alu.vhd:88:29  */
  assign n1199 = ~n1198;
  /* ./alu.vhd:88:29  */
  assign n1200 = bit_index[3]; // extract
  /* ./alu.vhd:88:29  */
  assign n1201 = ~n1200;
  /* ./alu.vhd:88:29  */
  assign n1202 = n1199 & n1201;
  /* ./alu.vhd:88:29  */
  assign n1203 = n1199 & n1200;
  /* ./alu.vhd:88:29  */
  assign n1204 = n1198 & n1201;
  /* ./alu.vhd:88:29  */
  assign n1205 = n1198 & n1200;
  /* ./alu.vhd:88:29  */
  assign n1206 = bit_index[2]; // extract
  /* ./alu.vhd:88:29  */
  assign n1207 = ~n1206;
  /* ./alu.vhd:88:29  */
  assign n1208 = n1202 & n1207;
  /* ./alu.vhd:88:29  */
  assign n1209 = n1202 & n1206;
  /* ./alu.vhd:88:29  */
  assign n1210 = n1203 & n1207;
  /* ./alu.vhd:88:29  */
  assign n1211 = n1203 & n1206;
  /* ./alu.vhd:88:29  */
  assign n1212 = n1204 & n1207;
  /* ./alu.vhd:88:29  */
  assign n1213 = n1204 & n1206;
  /* ./alu.vhd:88:29  */
  assign n1214 = n1205 & n1207;
  /* ./alu.vhd:88:29  */
  assign n1215 = n1205 & n1206;
  /* ./alu.vhd:88:29  */
  assign n1216 = bit_index[1]; // extract
  /* ./alu.vhd:88:29  */
  assign n1217 = ~n1216;
  /* ./alu.vhd:88:29  */
  assign n1218 = n1208 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1219 = n1208 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1220 = n1209 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1221 = n1209 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1222 = n1210 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1223 = n1210 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1224 = n1211 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1225 = n1211 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1226 = n1212 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1227 = n1212 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1228 = n1213 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1229 = n1213 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1230 = n1214 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1231 = n1214 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1232 = n1215 & n1217;
  /* ./alu.vhd:88:29  */
  assign n1233 = n1215 & n1216;
  /* ./alu.vhd:88:29  */
  assign n1234 = bit_index[0]; // extract
  /* ./alu.vhd:88:29  */
  assign n1235 = ~n1234;
  /* ./alu.vhd:88:29  */
  assign n1236 = n1218 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1237 = n1218 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1238 = n1219 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1239 = n1219 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1240 = n1220 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1241 = n1220 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1242 = n1221 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1243 = n1221 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1244 = n1222 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1245 = n1222 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1246 = n1223 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1247 = n1223 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1248 = n1224 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1249 = n1224 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1250 = n1225 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1251 = n1225 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1252 = n1226 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1253 = n1226 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1254 = n1227 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1255 = n1227 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1256 = n1228 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1257 = n1228 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1258 = n1229 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1259 = n1229 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1260 = n1230 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1261 = n1230 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1262 = n1231 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1263 = n1231 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1264 = n1232 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1265 = n1232 & n1234;
  /* ./alu.vhd:88:29  */
  assign n1266 = n1233 & n1235;
  /* ./alu.vhd:88:29  */
  assign n1267 = n1233 & n1234;
  assign n1268 = r[0]; // extract
  /* ./alu.vhd:88:29  */
  assign n1269 = n1236 ? n911 : n1268;
  assign n1270 = r[1]; // extract
  /* ./alu.vhd:88:29  */
  assign n1271 = n1237 ? n911 : n1270;
  assign n1272 = r[2]; // extract
  /* ./alu.vhd:88:29  */
  assign n1273 = n1238 ? n911 : n1272;
  assign n1274 = r[3]; // extract
  /* ./alu.vhd:88:29  */
  assign n1275 = n1239 ? n911 : n1274;
  assign n1276 = r[4]; // extract
  /* ./alu.vhd:88:29  */
  assign n1277 = n1240 ? n911 : n1276;
  assign n1278 = r[5]; // extract
  /* ./alu.vhd:88:29  */
  assign n1279 = n1241 ? n911 : n1278;
  assign n1280 = r[6]; // extract
  /* ./alu.vhd:88:29  */
  assign n1281 = n1242 ? n911 : n1280;
  assign n1282 = r[7]; // extract
  /* ./alu.vhd:88:29  */
  assign n1283 = n1243 ? n911 : n1282;
  assign n1284 = r[8]; // extract
  /* ./alu.vhd:88:29  */
  assign n1285 = n1244 ? n911 : n1284;
  assign n1286 = r[9]; // extract
  /* ./alu.vhd:88:29  */
  assign n1287 = n1245 ? n911 : n1286;
  assign n1288 = r[10]; // extract
  /* ./alu.vhd:88:29  */
  assign n1289 = n1246 ? n911 : n1288;
  assign n1290 = r[11]; // extract
  /* ./alu.vhd:88:29  */
  assign n1291 = n1247 ? n911 : n1290;
  assign n1292 = r[12]; // extract
  /* ./alu.vhd:88:29  */
  assign n1293 = n1248 ? n911 : n1292;
  assign n1294 = r[13]; // extract
  /* ./alu.vhd:88:29  */
  assign n1295 = n1249 ? n911 : n1294;
  assign n1296 = r[14]; // extract
  /* ./alu.vhd:88:29  */
  assign n1297 = n1250 ? n911 : n1296;
  assign n1298 = r[15]; // extract
  /* ./alu.vhd:88:29  */
  assign n1299 = n1251 ? n911 : n1298;
  assign n1300 = r[16]; // extract
  /* ./alu.vhd:88:29  */
  assign n1301 = n1252 ? n911 : n1300;
  assign n1302 = r[17]; // extract
  /* ./alu.vhd:88:29  */
  assign n1303 = n1253 ? n911 : n1302;
  assign n1304 = r[18]; // extract
  /* ./alu.vhd:88:29  */
  assign n1305 = n1254 ? n911 : n1304;
  assign n1306 = r[19]; // extract
  /* ./alu.vhd:88:29  */
  assign n1307 = n1255 ? n911 : n1306;
  assign n1308 = r[20]; // extract
  /* ./alu.vhd:88:29  */
  assign n1309 = n1256 ? n911 : n1308;
  assign n1310 = r[21]; // extract
  /* ./alu.vhd:88:29  */
  assign n1311 = n1257 ? n911 : n1310;
  assign n1312 = r[22]; // extract
  /* ./alu.vhd:88:29  */
  assign n1313 = n1258 ? n911 : n1312;
  assign n1314 = r[23]; // extract
  /* ./alu.vhd:88:29  */
  assign n1315 = n1259 ? n911 : n1314;
  assign n1316 = r[24]; // extract
  /* ./alu.vhd:88:29  */
  assign n1317 = n1260 ? n911 : n1316;
  assign n1318 = r[25]; // extract
  /* ./alu.vhd:88:29  */
  assign n1319 = n1261 ? n911 : n1318;
  assign n1320 = r[26]; // extract
  /* ./alu.vhd:88:29  */
  assign n1321 = n1262 ? n911 : n1320;
  assign n1322 = r[27]; // extract
  /* ./alu.vhd:88:29  */
  assign n1323 = n1263 ? n911 : n1322;
  assign n1324 = r[28]; // extract
  /* ./alu.vhd:88:29  */
  assign n1325 = n1264 ? n911 : n1324;
  assign n1326 = r[29]; // extract
  /* ./alu.vhd:88:29  */
  assign n1327 = n1265 ? n911 : n1326;
  assign n1328 = r[30]; // extract
  /* ./alu.vhd:88:29  */
  assign n1329 = n1266 ? n911 : n1328;
  assign n1330 = r[31]; // extract
  /* ./alu.vhd:88:29  */
  assign n1331 = n1267 ? n911 : n1330;
  assign n1332 = {n1331, n1329, n1327, n1325, n1323, n1321, n1319, n1317, n1315, n1313, n1311, n1309, n1307, n1305, n1303, n1301, n1299, n1297, n1295, n1293, n1291, n1289, n1287, n1285, n1283, n1281, n1279, n1277, n1275, n1273, n1271, n1269};
endmodule

module mux_b
  (input  clk,
   input  sel,
   input  [31:0] rs2,
   input  [31:0] imm,
   output [31:0] result);
  wire [31:0] result_next;
  wire [31:0] result_reg;
  wire n837;
  wire [31:0] n838;
  reg [31:0] n844;
  assign result = result_reg; //(module output)
  /* ./mux_b.vhd:16:12  */
  assign result_next = n838; // (signal)
  /* ./mux_b.vhd:17:12  */
  assign result_reg = n844; // (signal)
  /* ./mux_b.vhd:20:33  */
  assign n837 = ~sel;
  /* ./mux_b.vhd:20:24  */
  assign n838 = n837 ? rs2 : imm;
  /* ./mux_b.vhd:25:9  */
  always @(posedge clk)
    n844 <= result_next;
endmodule

module mux_a
  (input  clk,
   input  [1:0] sel,
   input  [31:0] rs1,
   input  [31:0] pc,
   output [31:0] result);
  wire [31:0] result_next;
  wire [31:0] result_reg;
  wire n821;
  wire n823;
  wire n825;
  wire [2:0] n826;
  reg [31:0] n828;
  reg [31:0] n835;
  assign result = result_reg; //(module output)
  /* ./mux_a.vhd:16:12  */
  assign result_next = n828; // (signal)
  /* ./mux_a.vhd:17:12  */
  assign result_reg = n835; // (signal)
  /* ./mux_a.vhd:23:13  */
  assign n821 = sel == 2'b00;
  /* ./mux_a.vhd:24:13  */
  assign n823 = sel == 2'b01;
  /* ./mux_a.vhd:25:13  */
  assign n825 = sel == 2'b10;
  assign n826 = {n825, n823, n821};
  /* ./mux_a.vhd:22:9  */
  always @*
    case (n826)
      3'b100: n828 = 32'b00000000000000000000000000000000;
      3'b010: n828 = pc;
      3'b001: n828 = rs1;
      default: n828 = rs1;
    endcase
  /* ./mux_a.vhd:33:9  */
  always @(posedge clk)
    n835 <= result_next;
endmodule

module imm_gen
  (input  [31:0] instr,
   input  [2:0] imm_type,
   output [31:0] imm_out);
  wire [31:0] imm;
  wire [11:0] n774;
  wire [31:0] n775;
  wire n777;
  wire [6:0] n778;
  wire [4:0] n779;
  wire [11:0] n780;
  wire [31:0] n781;
  wire n783;
  wire n784;
  wire n785;
  wire [1:0] n786;
  wire [5:0] n787;
  wire [7:0] n788;
  wire [3:0] n789;
  wire [11:0] n790;
  wire [12:0] n792;
  wire [31:0] n793;
  wire n795;
  wire [19:0] n796;
  wire [31:0] n798;
  wire n800;
  wire n801;
  wire [7:0] n802;
  wire [8:0] n803;
  wire n804;
  wire [9:0] n805;
  wire [9:0] n806;
  wire [19:0] n807;
  wire [20:0] n809;
  wire [31:0] n810;
  wire n812;
  wire [4:0] n813;
  reg [31:0] n815;
  assign imm_out = imm; //(module output)
  /* ./imm_gen.vhd:14:12  */
  assign imm = n815; // (signal)
  /* ./imm_gen.vhd:20:43  */
  assign n774 = instr[31:20]; // extract
  /* ./imm_gen.vhd:20:24  */
  assign n775 = {{20{n774[11]}}, n774}; // sext
  /* ./imm_gen.vhd:19:13  */
  assign n777 = imm_type == 3'b000;
  /* ./imm_gen.vhd:23:43  */
  assign n778 = instr[31:25]; // extract
  /* ./imm_gen.vhd:23:65  */
  assign n779 = instr[11:7]; // extract
  /* ./imm_gen.vhd:23:58  */
  assign n780 = {n778, n779};
  /* ./imm_gen.vhd:23:24  */
  assign n781 = {{20{n780[11]}}, n780}; // sext
  /* ./imm_gen.vhd:22:13  */
  assign n783 = imm_type == 3'b001;
  /* ./imm_gen.vhd:27:33  */
  assign n784 = instr[31]; // extract
  /* ./imm_gen.vhd:27:45  */
  assign n785 = instr[7]; // extract
  /* ./imm_gen.vhd:27:38  */
  assign n786 = {n784, n785};
  /* ./imm_gen.vhd:27:56  */
  assign n787 = instr[30:25]; // extract
  /* ./imm_gen.vhd:27:49  */
  assign n788 = {n786, n787};
  /* ./imm_gen.vhd:27:78  */
  assign n789 = instr[11:8]; // extract
  /* ./imm_gen.vhd:27:71  */
  assign n790 = {n788, n789};
  /* ./imm_gen.vhd:27:92  */
  assign n792 = {n790, 1'b0};
  /* ./imm_gen.vhd:26:24  */
  assign n793 = {{19{n792[12]}}, n792}; // sext
  /* ./imm_gen.vhd:25:13  */
  assign n795 = imm_type == 3'b010;
  /* ./imm_gen.vhd:32:36  */
  assign n796 = instr[31:12]; // extract
  /* ./imm_gen.vhd:32:51  */
  assign n798 = {n796, 12'b000000000000};
  /* ./imm_gen.vhd:31:13  */
  assign n800 = imm_type == 3'b011;
  /* ./imm_gen.vhd:36:33  */
  assign n801 = instr[31]; // extract
  /* ./imm_gen.vhd:36:45  */
  assign n802 = instr[19:12]; // extract
  /* ./imm_gen.vhd:36:38  */
  assign n803 = {n801, n802};
  /* ./imm_gen.vhd:36:67  */
  assign n804 = instr[20]; // extract
  /* ./imm_gen.vhd:36:60  */
  assign n805 = {n803, n804};
  /* ./imm_gen.vhd:36:79  */
  assign n806 = instr[30:21]; // extract
  /* ./imm_gen.vhd:36:72  */
  assign n807 = {n805, n806};
  /* ./imm_gen.vhd:36:94  */
  assign n809 = {n807, 1'b0};
  /* ./imm_gen.vhd:35:24  */
  assign n810 = {{11{n809[20]}}, n809}; // sext
  /* ./imm_gen.vhd:34:13  */
  assign n812 = imm_type == 3'b100;
  assign n813 = {n812, n800, n795, n783, n777};
  /* ./imm_gen.vhd:18:9  */
  always @*
    case (n813)
      5'b10000: n815 = n810;
      5'b01000: n815 = n798;
      5'b00100: n815 = n793;
      5'b00010: n815 = n781;
      5'b00001: n815 = n775;
      default: n815 = 32'b00000000000000000000000000000000;
    endcase
endmodule

module reg_file
  (input  clk,
   input  [4:0] rs1_addr,
   input  [4:0] rs2_addr,
   input  [4:0] rd_addr,
   input  [31:0] rd_data,
   input  reg_write,
   output [31:0] rs1_data,
   output [31:0] rs2_data);
  wire [31:0] rs1_slices;
  wire [31:0] rs2_slices;
  wire we_int;
  wire n542;
  wire n543;
  wire \gen_regfiles_n1_regfile_inst.AD0 ;
  wire \gen_regfiles_n1_regfile_inst.AD1 ;
  wire \gen_regfiles_n1_regfile_inst.AD2 ;
  wire \gen_regfiles_n1_regfile_inst.AD3 ;
  wire \gen_regfiles_n1_regfile_inst.BD0 ;
  wire \gen_regfiles_n1_regfile_inst.BD1 ;
  wire \gen_regfiles_n1_regfile_inst.BD2 ;
  wire \gen_regfiles_n1_regfile_inst.BD3 ;
  wire n545;
  wire n546;
  wire n547;
  wire n548;
  wire n549;
  wire n550;
  wire n551;
  wire n552;
  wire n553;
  wire n558;
  wire n559;
  wire n560;
  wire n561;
  wire n562;
  wire n567;
  wire n568;
  wire n569;
  wire n570;
  wire n571;
  wire \gen_regfiles_n2_regfile_inst.AD0 ;
  wire \gen_regfiles_n2_regfile_inst.AD1 ;
  wire \gen_regfiles_n2_regfile_inst.AD2 ;
  wire \gen_regfiles_n2_regfile_inst.AD3 ;
  wire \gen_regfiles_n2_regfile_inst.BD0 ;
  wire \gen_regfiles_n2_regfile_inst.BD1 ;
  wire \gen_regfiles_n2_regfile_inst.BD2 ;
  wire \gen_regfiles_n2_regfile_inst.BD3 ;
  wire n572;
  wire n573;
  wire n574;
  wire n575;
  wire n576;
  wire n577;
  wire n578;
  wire n579;
  wire n580;
  wire n585;
  wire n586;
  wire n587;
  wire n588;
  wire n589;
  wire n594;
  wire n595;
  wire n596;
  wire n597;
  wire n598;
  wire \gen_regfiles_n3_regfile_inst.AD0 ;
  wire \gen_regfiles_n3_regfile_inst.AD1 ;
  wire \gen_regfiles_n3_regfile_inst.AD2 ;
  wire \gen_regfiles_n3_regfile_inst.AD3 ;
  wire \gen_regfiles_n3_regfile_inst.BD0 ;
  wire \gen_regfiles_n3_regfile_inst.BD1 ;
  wire \gen_regfiles_n3_regfile_inst.BD2 ;
  wire \gen_regfiles_n3_regfile_inst.BD3 ;
  wire n599;
  wire n600;
  wire n601;
  wire n602;
  wire n603;
  wire n604;
  wire n605;
  wire n606;
  wire n607;
  wire n612;
  wire n613;
  wire n614;
  wire n615;
  wire n616;
  wire n621;
  wire n622;
  wire n623;
  wire n624;
  wire n625;
  wire \gen_regfiles_n4_regfile_inst.AD0 ;
  wire \gen_regfiles_n4_regfile_inst.AD1 ;
  wire \gen_regfiles_n4_regfile_inst.AD2 ;
  wire \gen_regfiles_n4_regfile_inst.AD3 ;
  wire \gen_regfiles_n4_regfile_inst.BD0 ;
  wire \gen_regfiles_n4_regfile_inst.BD1 ;
  wire \gen_regfiles_n4_regfile_inst.BD2 ;
  wire \gen_regfiles_n4_regfile_inst.BD3 ;
  wire n626;
  wire n627;
  wire n628;
  wire n629;
  wire n630;
  wire n631;
  wire n632;
  wire n633;
  wire n634;
  wire n639;
  wire n640;
  wire n641;
  wire n642;
  wire n643;
  wire n648;
  wire n649;
  wire n650;
  wire n651;
  wire n652;
  wire \gen_regfiles_n5_regfile_inst.AD0 ;
  wire \gen_regfiles_n5_regfile_inst.AD1 ;
  wire \gen_regfiles_n5_regfile_inst.AD2 ;
  wire \gen_regfiles_n5_regfile_inst.AD3 ;
  wire \gen_regfiles_n5_regfile_inst.BD0 ;
  wire \gen_regfiles_n5_regfile_inst.BD1 ;
  wire \gen_regfiles_n5_regfile_inst.BD2 ;
  wire \gen_regfiles_n5_regfile_inst.BD3 ;
  wire n653;
  wire n654;
  wire n655;
  wire n656;
  wire n657;
  wire n658;
  wire n659;
  wire n660;
  wire n661;
  wire n666;
  wire n667;
  wire n668;
  wire n669;
  wire n670;
  wire n675;
  wire n676;
  wire n677;
  wire n678;
  wire n679;
  wire \gen_regfiles_n6_regfile_inst.AD0 ;
  wire \gen_regfiles_n6_regfile_inst.AD1 ;
  wire \gen_regfiles_n6_regfile_inst.AD2 ;
  wire \gen_regfiles_n6_regfile_inst.AD3 ;
  wire \gen_regfiles_n6_regfile_inst.BD0 ;
  wire \gen_regfiles_n6_regfile_inst.BD1 ;
  wire \gen_regfiles_n6_regfile_inst.BD2 ;
  wire \gen_regfiles_n6_regfile_inst.BD3 ;
  wire n680;
  wire n681;
  wire n682;
  wire n683;
  wire n684;
  wire n685;
  wire n686;
  wire n687;
  wire n688;
  wire n693;
  wire n694;
  wire n695;
  wire n696;
  wire n697;
  wire n702;
  wire n703;
  wire n704;
  wire n705;
  wire n706;
  wire \gen_regfiles_n7_regfile_inst.AD0 ;
  wire \gen_regfiles_n7_regfile_inst.AD1 ;
  wire \gen_regfiles_n7_regfile_inst.AD2 ;
  wire \gen_regfiles_n7_regfile_inst.AD3 ;
  wire \gen_regfiles_n7_regfile_inst.BD0 ;
  wire \gen_regfiles_n7_regfile_inst.BD1 ;
  wire \gen_regfiles_n7_regfile_inst.BD2 ;
  wire \gen_regfiles_n7_regfile_inst.BD3 ;
  wire n707;
  wire n708;
  wire n709;
  wire n710;
  wire n711;
  wire n712;
  wire n713;
  wire n714;
  wire n715;
  wire n720;
  wire n721;
  wire n722;
  wire n723;
  wire n724;
  wire n729;
  wire n730;
  wire n731;
  wire n732;
  wire n733;
  wire \gen_regfiles_n8_regfile_inst.AD0 ;
  wire \gen_regfiles_n8_regfile_inst.AD1 ;
  wire \gen_regfiles_n8_regfile_inst.AD2 ;
  wire \gen_regfiles_n8_regfile_inst.AD3 ;
  wire \gen_regfiles_n8_regfile_inst.BD0 ;
  wire \gen_regfiles_n8_regfile_inst.BD1 ;
  wire \gen_regfiles_n8_regfile_inst.BD2 ;
  wire \gen_regfiles_n8_regfile_inst.BD3 ;
  wire n734;
  wire n735;
  wire n736;
  wire n737;
  wire n738;
  wire n739;
  wire n740;
  wire n741;
  wire n742;
  wire n747;
  wire n748;
  wire n749;
  wire n750;
  wire n751;
  wire n756;
  wire n757;
  wire n758;
  wire n759;
  wire n760;
  wire n763;
  wire [31:0] n764;
  wire n767;
  wire [31:0] n768;
  wire [31:0] n769;
  wire [31:0] n770;
  assign rs1_data = n764; //(module output)
  assign rs2_data = n768; //(module output)
  /* ./reg_file.vhd:50:10  */
  assign rs1_slices = n769; // (signal)
  /* ./reg_file.vhd:51:10  */
  assign rs2_slices = n770; // (signal)
  /* ./reg_file.vhd:54:10  */
  assign we_int = n543; // (signal)
  /* ./reg_file.vhd:61:36  */
  assign n542 = rd_addr != 5'b00000;
  /* ./reg_file.vhd:61:23  */
  assign n543 = n542 ? reg_write : 1'b0;
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n1_regfile_inst (
    .D0(n545),
    .D1(n546),
    .D2(n547),
    .D3(n548),
    .W_ADR0(n549),
    .W_ADR1(n550),
    .W_ADR2(n551),
    .W_ADR3(n552),
    .W_ADR4(n553),
    .W_en(we_int),
    .A_ADR0(n558),
    .A_ADR1(n559),
    .A_ADR2(n560),
    .A_ADR3(n561),
    .A_ADR4(n562),
    .B_ADR0(n567),
    .B_ADR1(n568),
    .B_ADR2(n569),
    .B_ADR3(n570),
    .B_ADR4(n571),
    .CLK(clk),
    .AD0(\gen_regfiles_n1_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n1_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n1_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n1_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n1_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n1_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n1_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n1_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n545 = rd_data[0]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n546 = rd_data[1]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n547 = rd_data[2]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n548 = rd_data[3]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n549 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n550 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n551 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n552 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n553 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n558 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n559 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n560 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n561 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n562 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n567 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n568 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n569 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n570 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n571 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n2_regfile_inst (
    .D0(n572),
    .D1(n573),
    .D2(n574),
    .D3(n575),
    .W_ADR0(n576),
    .W_ADR1(n577),
    .W_ADR2(n578),
    .W_ADR3(n579),
    .W_ADR4(n580),
    .W_en(we_int),
    .A_ADR0(n585),
    .A_ADR1(n586),
    .A_ADR2(n587),
    .A_ADR3(n588),
    .A_ADR4(n589),
    .B_ADR0(n594),
    .B_ADR1(n595),
    .B_ADR2(n596),
    .B_ADR3(n597),
    .B_ADR4(n598),
    .CLK(clk),
    .AD0(\gen_regfiles_n2_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n2_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n2_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n2_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n2_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n2_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n2_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n2_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n572 = rd_data[4]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n573 = rd_data[5]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n574 = rd_data[6]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n575 = rd_data[7]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n576 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n577 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n578 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n579 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n580 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n585 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n586 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n587 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n588 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n589 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n594 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n595 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n596 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n597 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n598 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n3_regfile_inst (
    .D0(n599),
    .D1(n600),
    .D2(n601),
    .D3(n602),
    .W_ADR0(n603),
    .W_ADR1(n604),
    .W_ADR2(n605),
    .W_ADR3(n606),
    .W_ADR4(n607),
    .W_en(we_int),
    .A_ADR0(n612),
    .A_ADR1(n613),
    .A_ADR2(n614),
    .A_ADR3(n615),
    .A_ADR4(n616),
    .B_ADR0(n621),
    .B_ADR1(n622),
    .B_ADR2(n623),
    .B_ADR3(n624),
    .B_ADR4(n625),
    .CLK(clk),
    .AD0(\gen_regfiles_n3_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n3_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n3_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n3_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n3_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n3_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n3_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n3_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n599 = rd_data[8]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n600 = rd_data[9]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n601 = rd_data[10]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n602 = rd_data[11]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n603 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n604 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n605 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n606 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n607 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n612 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n613 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n614 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n615 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n616 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n621 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n622 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n623 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n624 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n625 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n4_regfile_inst (
    .D0(n626),
    .D1(n627),
    .D2(n628),
    .D3(n629),
    .W_ADR0(n630),
    .W_ADR1(n631),
    .W_ADR2(n632),
    .W_ADR3(n633),
    .W_ADR4(n634),
    .W_en(we_int),
    .A_ADR0(n639),
    .A_ADR1(n640),
    .A_ADR2(n641),
    .A_ADR3(n642),
    .A_ADR4(n643),
    .B_ADR0(n648),
    .B_ADR1(n649),
    .B_ADR2(n650),
    .B_ADR3(n651),
    .B_ADR4(n652),
    .CLK(clk),
    .AD0(\gen_regfiles_n4_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n4_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n4_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n4_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n4_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n4_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n4_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n4_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n626 = rd_data[12]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n627 = rd_data[13]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n628 = rd_data[14]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n629 = rd_data[15]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n630 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n631 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n632 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n633 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n634 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n639 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n640 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n641 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n642 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n643 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n648 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n649 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n650 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n651 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n652 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n5_regfile_inst (
    .D0(n653),
    .D1(n654),
    .D2(n655),
    .D3(n656),
    .W_ADR0(n657),
    .W_ADR1(n658),
    .W_ADR2(n659),
    .W_ADR3(n660),
    .W_ADR4(n661),
    .W_en(we_int),
    .A_ADR0(n666),
    .A_ADR1(n667),
    .A_ADR2(n668),
    .A_ADR3(n669),
    .A_ADR4(n670),
    .B_ADR0(n675),
    .B_ADR1(n676),
    .B_ADR2(n677),
    .B_ADR3(n678),
    .B_ADR4(n679),
    .CLK(clk),
    .AD0(\gen_regfiles_n5_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n5_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n5_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n5_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n5_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n5_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n5_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n5_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n653 = rd_data[16]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n654 = rd_data[17]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n655 = rd_data[18]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n656 = rd_data[19]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n657 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n658 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n659 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n660 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n661 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n666 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n667 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n668 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n669 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n670 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n675 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n676 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n677 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n678 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n679 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n6_regfile_inst (
    .D0(n680),
    .D1(n681),
    .D2(n682),
    .D3(n683),
    .W_ADR0(n684),
    .W_ADR1(n685),
    .W_ADR2(n686),
    .W_ADR3(n687),
    .W_ADR4(n688),
    .W_en(we_int),
    .A_ADR0(n693),
    .A_ADR1(n694),
    .A_ADR2(n695),
    .A_ADR3(n696),
    .A_ADR4(n697),
    .B_ADR0(n702),
    .B_ADR1(n703),
    .B_ADR2(n704),
    .B_ADR3(n705),
    .B_ADR4(n706),
    .CLK(clk),
    .AD0(\gen_regfiles_n6_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n6_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n6_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n6_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n6_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n6_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n6_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n6_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n680 = rd_data[20]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n681 = rd_data[21]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n682 = rd_data[22]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n683 = rd_data[23]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n684 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n685 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n686 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n687 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n688 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n693 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n694 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n695 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n696 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n697 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n702 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n703 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n704 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n705 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n706 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n7_regfile_inst (
    .D0(n707),
    .D1(n708),
    .D2(n709),
    .D3(n710),
    .W_ADR0(n711),
    .W_ADR1(n712),
    .W_ADR2(n713),
    .W_ADR3(n714),
    .W_ADR4(n715),
    .W_en(we_int),
    .A_ADR0(n720),
    .A_ADR1(n721),
    .A_ADR2(n722),
    .A_ADR3(n723),
    .A_ADR4(n724),
    .B_ADR0(n729),
    .B_ADR1(n730),
    .B_ADR2(n731),
    .B_ADR3(n732),
    .B_ADR4(n733),
    .CLK(clk),
    .AD0(\gen_regfiles_n7_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n7_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n7_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n7_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n7_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n7_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n7_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n7_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n707 = rd_data[24]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n708 = rd_data[25]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n709 = rd_data[26]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n710 = rd_data[27]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n711 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n712 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n713 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n714 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n715 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n720 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n721 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n722 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n723 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n724 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n729 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n730 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n731 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n732 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n733 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n8_regfile_inst (
    .D0(n734),
    .D1(n735),
    .D2(n736),
    .D3(n737),
    .W_ADR0(n738),
    .W_ADR1(n739),
    .W_ADR2(n740),
    .W_ADR3(n741),
    .W_ADR4(n742),
    .W_en(we_int),
    .A_ADR0(n747),
    .A_ADR1(n748),
    .A_ADR2(n749),
    .A_ADR3(n750),
    .A_ADR4(n751),
    .B_ADR0(n756),
    .B_ADR1(n757),
    .B_ADR2(n758),
    .B_ADR3(n759),
    .B_ADR4(n760),
    .CLK(clk),
    .AD0(\gen_regfiles_n8_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n8_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n8_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n8_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n8_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n8_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n8_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n8_regfile_inst.BD3 ));
  /* ./reg_file.vhd:74:22  */
  assign n734 = rd_data[28]; // extract
  /* ./reg_file.vhd:75:22  */
  assign n735 = rd_data[29]; // extract
  /* ./reg_file.vhd:76:22  */
  assign n736 = rd_data[30]; // extract
  /* ./reg_file.vhd:77:22  */
  assign n737 = rd_data[31]; // extract
  /* ./reg_file.vhd:78:26  */
  assign n738 = rd_addr[0]; // extract
  /* ./reg_file.vhd:79:26  */
  assign n739 = rd_addr[1]; // extract
  /* ./reg_file.vhd:80:26  */
  assign n740 = rd_addr[2]; // extract
  /* ./reg_file.vhd:81:26  */
  assign n741 = rd_addr[3]; // extract
  /* ./reg_file.vhd:82:26  */
  assign n742 = rd_addr[4]; // extract
  /* ./reg_file.vhd:90:27  */
  assign n747 = rs1_addr[0]; // extract
  /* ./reg_file.vhd:91:27  */
  assign n748 = rs1_addr[1]; // extract
  /* ./reg_file.vhd:92:27  */
  assign n749 = rs1_addr[2]; // extract
  /* ./reg_file.vhd:93:27  */
  assign n750 = rs1_addr[3]; // extract
  /* ./reg_file.vhd:94:27  */
  assign n751 = rs1_addr[4]; // extract
  /* ./reg_file.vhd:101:27  */
  assign n756 = rs2_addr[0]; // extract
  /* ./reg_file.vhd:102:27  */
  assign n757 = rs2_addr[1]; // extract
  /* ./reg_file.vhd:103:27  */
  assign n758 = rs2_addr[2]; // extract
  /* ./reg_file.vhd:104:27  */
  assign n759 = rs2_addr[3]; // extract
  /* ./reg_file.vhd:105:27  */
  assign n760 = rs2_addr[4]; // extract
  /* ./reg_file.vhd:115:45  */
  assign n763 = rs1_addr == 5'b00000;
  /* ./reg_file.vhd:115:31  */
  assign n764 = n763 ? 32'b00000000000000000000000000000000 : rs1_slices;
  /* ./reg_file.vhd:116:45  */
  assign n767 = rs2_addr == 5'b00000;
  /* ./reg_file.vhd:116:31  */
  assign n768 = n767 ? 32'b00000000000000000000000000000000 : rs2_slices;
  assign n769 = {\gen_regfiles_n8_regfile_inst.AD3 , \gen_regfiles_n8_regfile_inst.AD2 , \gen_regfiles_n8_regfile_inst.AD1 , \gen_regfiles_n8_regfile_inst.AD0 , \gen_regfiles_n7_regfile_inst.AD3 , \gen_regfiles_n7_regfile_inst.AD2 , \gen_regfiles_n7_regfile_inst.AD1 , \gen_regfiles_n7_regfile_inst.AD0 , \gen_regfiles_n6_regfile_inst.AD3 , \gen_regfiles_n6_regfile_inst.AD2 , \gen_regfiles_n6_regfile_inst.AD1 , \gen_regfiles_n6_regfile_inst.AD0 , \gen_regfiles_n5_regfile_inst.AD3 , \gen_regfiles_n5_regfile_inst.AD2 , \gen_regfiles_n5_regfile_inst.AD1 , \gen_regfiles_n5_regfile_inst.AD0 , \gen_regfiles_n4_regfile_inst.AD3 , \gen_regfiles_n4_regfile_inst.AD2 , \gen_regfiles_n4_regfile_inst.AD1 , \gen_regfiles_n4_regfile_inst.AD0 , \gen_regfiles_n3_regfile_inst.AD3 , \gen_regfiles_n3_regfile_inst.AD2 , \gen_regfiles_n3_regfile_inst.AD1 , \gen_regfiles_n3_regfile_inst.AD0 , \gen_regfiles_n2_regfile_inst.AD3 , \gen_regfiles_n2_regfile_inst.AD2 , \gen_regfiles_n2_regfile_inst.AD1 , \gen_regfiles_n2_regfile_inst.AD0 , \gen_regfiles_n1_regfile_inst.AD3 , \gen_regfiles_n1_regfile_inst.AD2 , \gen_regfiles_n1_regfile_inst.AD1 , \gen_regfiles_n1_regfile_inst.AD0 };
  assign n770 = {\gen_regfiles_n8_regfile_inst.BD3 , \gen_regfiles_n8_regfile_inst.BD2 , \gen_regfiles_n8_regfile_inst.BD1 , \gen_regfiles_n8_regfile_inst.BD0 , \gen_regfiles_n7_regfile_inst.BD3 , \gen_regfiles_n7_regfile_inst.BD2 , \gen_regfiles_n7_regfile_inst.BD1 , \gen_regfiles_n7_regfile_inst.BD0 , \gen_regfiles_n6_regfile_inst.BD3 , \gen_regfiles_n6_regfile_inst.BD2 , \gen_regfiles_n6_regfile_inst.BD1 , \gen_regfiles_n6_regfile_inst.BD0 , \gen_regfiles_n5_regfile_inst.BD3 , \gen_regfiles_n5_regfile_inst.BD2 , \gen_regfiles_n5_regfile_inst.BD1 , \gen_regfiles_n5_regfile_inst.BD0 , \gen_regfiles_n4_regfile_inst.BD3 , \gen_regfiles_n4_regfile_inst.BD2 , \gen_regfiles_n4_regfile_inst.BD1 , \gen_regfiles_n4_regfile_inst.BD0 , \gen_regfiles_n3_regfile_inst.BD3 , \gen_regfiles_n3_regfile_inst.BD2 , \gen_regfiles_n3_regfile_inst.BD1 , \gen_regfiles_n3_regfile_inst.BD0 , \gen_regfiles_n2_regfile_inst.BD3 , \gen_regfiles_n2_regfile_inst.BD2 , \gen_regfiles_n2_regfile_inst.BD1 , \gen_regfiles_n2_regfile_inst.BD0 , \gen_regfiles_n1_regfile_inst.BD3 , \gen_regfiles_n1_regfile_inst.BD2 , \gen_regfiles_n1_regfile_inst.BD1 , \gen_regfiles_n1_regfile_inst.BD0 };
endmodule

module control_unit
  (input  clk,
   input  reset,
   input  [6:0] opcode,
   input  [2:0] funct3,
   input  [6:0] funct7,
   input  zero_flag,
   input  alu_done,
   input  branch_taken,
   output ir_write,
   output pc_write,
   output reg_write,
   output mem_read,
   output mem_write,
   output [1:0] alu_src_a,
   output alu_src_b,
   output [3:0] alu_control,
   output alu_start,
   output latch_store_data,
   output [1:0] wb_sel,
   output is_branch,
   output is_jalr,
   output is_jal,
   output [2:0] imm_type);
  wire [2:0] state;
  wire [2:0] next_state;
  wire [3:0] d_alu_control;
  wire d_is_load;
  wire d_is_store;
  wire d_is_branch;
  wire d_is_jal;
  wire d_is_jalr;
  wire d_reg_write;
  wire [1:0] d_wb_sel;
  wire [2:0] d_imm_type;
  wire [1:0] d_alu_src_a;
  wire d_alu_src_b;
  wire n222;
  wire n224;
  wire [3:0] n227;
  wire [3:0] n229;
  wire n231;
  wire n233;
  wire n235;
  wire n237;
  wire n239;
  wire n241;
  wire n243;
  wire [3:0] n246;
  wire [3:0] n248;
  wire n250;
  wire n252;
  wire n254;
  wire [7:0] n255;
  reg [3:0] n263;
  wire n265;
  wire n267;
  wire n269;
  wire n271;
  wire n273;
  wire n275;
  wire n277;
  wire n279;
  wire [3:0] n282;
  wire [3:0] n284;
  wire n286;
  wire n288;
  wire n290;
  wire [7:0] n291;
  reg [3:0] n300;
  wire n302;
  wire n304;
  wire n306;
  wire n309;
  wire n311;
  wire n312;
  wire [3:0] n313;
  wire n316;
  wire n318;
  wire n319;
  wire [3:0] n320;
  wire n323;
  wire n325;
  wire n327;
  wire n329;
  wire n331;
  wire [8:0] n332;
  reg [3:0] n340;
  reg n344;
  reg n348;
  reg n352;
  reg n356;
  reg n360;
  reg n370;
  reg [1:0] n376;
  reg [2:0] n387;
  reg [1:0] n399;
  reg n411;
  wire [2:0] n418;
  wire n424;
  wire n426;
  wire n428;
  wire n431;
  wire n434;
  wire n435;
  wire n438;
  wire [2:0] n441;
  wire n444;
  wire n446;
  wire n448;
  wire [2:0] n450;
  wire n452;
  wire n453;
  wire n455;
  wire [2:0] n457;
  wire n459;
  wire n461;
  wire n463;
  wire [2:0] n465;
  wire n467;
  wire n469;
  wire n471;
  wire [2:0] n472;
  wire n474;
  wire n477;
  wire n480;
  wire [2:0] n482;
  wire n484;
  wire n487;
  wire n489;
  wire [2:0] n491;
  wire n493;
  wire n496;
  wire n498;
  wire [5:0] n499;
  reg n503;
  reg n508;
  reg n512;
  reg n516;
  reg n520;
  reg n525;
  reg n529;
  reg [2:0] n536;
  reg [2:0] n538;
  assign ir_write = n503; //(module output)
  assign pc_write = n508; //(module output)
  assign reg_write = n512; //(module output)
  assign mem_read = n516; //(module output)
  assign mem_write = n520; //(module output)
  assign alu_src_a = d_alu_src_a; //(module output)
  assign alu_src_b = d_alu_src_b; //(module output)
  assign alu_control = d_alu_control; //(module output)
  assign alu_start = n525; //(module output)
  assign latch_store_data = n529; //(module output)
  assign wb_sel = d_wb_sel; //(module output)
  assign is_branch = d_is_branch; //(module output)
  assign is_jalr = d_is_jalr; //(module output)
  assign is_jal = d_is_jal; //(module output)
  assign imm_type = d_imm_type; //(module output)
  /* ./control_unit.vhd:39:12  */
  assign state = n538; // (signal)
  /* ./control_unit.vhd:39:19  */
  assign next_state = n536; // (signal)
  /* ./control_unit.vhd:44:12  */
  assign d_alu_control = n340; // (signal)
  /* ./control_unit.vhd:45:12  */
  assign d_is_load = n344; // (signal)
  /* ./control_unit.vhd:45:23  */
  assign d_is_store = n348; // (signal)
  /* ./control_unit.vhd:45:35  */
  assign d_is_branch = n352; // (signal)
  /* ./control_unit.vhd:45:48  */
  assign d_is_jal = n356; // (signal)
  /* ./control_unit.vhd:45:58  */
  assign d_is_jalr = n360; // (signal)
  /* ./control_unit.vhd:45:69  */
  assign d_reg_write = n370; // (signal)
  /* ./control_unit.vhd:46:12  */
  assign d_wb_sel = n376; // (signal)
  /* ./control_unit.vhd:47:12  */
  assign d_imm_type = n387; // (signal)
  /* ./control_unit.vhd:48:12  */
  assign d_alu_src_a = n399; // (signal)
  /* ./control_unit.vhd:49:12  */
  assign d_alu_src_b = n411; // (signal)
  /* ./control_unit.vhd:72:35  */
  assign n222 = funct7 == 7'b0000000;
  /* ./control_unit.vhd:74:38  */
  assign n224 = funct7 == 7'b0100000;
  /* ./control_unit.vhd:74:25  */
  assign n227 = n224 ? 4'b0001 : 4'b0000;
  /* ./control_unit.vhd:72:25  */
  assign n229 = n222 ? 4'b0000 : n227;
  /* ./control_unit.vhd:71:21  */
  assign n231 = funct3 == 3'b000;
  /* ./control_unit.vhd:77:21  */
  assign n233 = funct3 == 3'b001;
  /* ./control_unit.vhd:78:21  */
  assign n235 = funct3 == 3'b010;
  /* ./control_unit.vhd:79:21  */
  assign n237 = funct3 == 3'b011;
  /* ./control_unit.vhd:80:21  */
  assign n239 = funct3 == 3'b100;
  /* ./control_unit.vhd:82:35  */
  assign n241 = funct7 == 7'b0000000;
  /* ./control_unit.vhd:84:38  */
  assign n243 = funct7 == 7'b0100000;
  /* ./control_unit.vhd:84:25  */
  assign n246 = n243 ? 4'b0111 : 4'b0000;
  /* ./control_unit.vhd:82:25  */
  assign n248 = n241 ? 4'b0110 : n246;
  /* ./control_unit.vhd:81:21  */
  assign n250 = funct3 == 3'b101;
  /* ./control_unit.vhd:87:21  */
  assign n252 = funct3 == 3'b110;
  /* ./control_unit.vhd:88:21  */
  assign n254 = funct3 == 3'b111;
  assign n255 = {n254, n252, n250, n239, n237, n235, n233, n231};
  /* ./control_unit.vhd:70:17  */
  always @*
    case (n255)
      8'b10000000: n263 = 4'b0010;
      8'b01000000: n263 = 4'b0011;
      8'b00100000: n263 = n248;
      8'b00010000: n263 = 4'b0100;
      8'b00001000: n263 = 4'b1001;
      8'b00000100: n263 = 4'b1000;
      8'b00000010: n263 = 4'b0101;
      8'b00000001: n263 = n229;
      default: n263 = 4'b0000;
    endcase
  /* ./control_unit.vhd:65:13  */
  assign n265 = opcode == 7'b0110011;
  /* ./control_unit.vhd:100:21  */
  assign n267 = funct3 == 3'b000;
  /* ./control_unit.vhd:101:21  */
  assign n269 = funct3 == 3'b001;
  /* ./control_unit.vhd:102:21  */
  assign n271 = funct3 == 3'b010;
  /* ./control_unit.vhd:103:21  */
  assign n273 = funct3 == 3'b011;
  /* ./control_unit.vhd:104:21  */
  assign n275 = funct3 == 3'b100;
  /* ./control_unit.vhd:106:35  */
  assign n277 = funct7 == 7'b0000000;
  /* ./control_unit.vhd:108:38  */
  assign n279 = funct7 == 7'b0100000;
  /* ./control_unit.vhd:108:25  */
  assign n282 = n279 ? 4'b0111 : 4'b0000;
  /* ./control_unit.vhd:106:25  */
  assign n284 = n277 ? 4'b0110 : n282;
  /* ./control_unit.vhd:105:21  */
  assign n286 = funct3 == 3'b101;
  /* ./control_unit.vhd:111:21  */
  assign n288 = funct3 == 3'b110;
  /* ./control_unit.vhd:112:21  */
  assign n290 = funct3 == 3'b111;
  assign n291 = {n290, n288, n286, n275, n273, n271, n269, n267};
  /* ./control_unit.vhd:99:17  */
  always @*
    case (n291)
      8'b10000000: n300 = 4'b0010;
      8'b01000000: n300 = 4'b0011;
      8'b00100000: n300 = n284;
      8'b00010000: n300 = 4'b0100;
      8'b00001000: n300 = 4'b1001;
      8'b00000100: n300 = 4'b1000;
      8'b00000010: n300 = 4'b0101;
      8'b00000001: n300 = 4'b0000;
      default: n300 = 4'b0000;
    endcase
  /* ./control_unit.vhd:93:13  */
  assign n302 = opcode == 7'b0010011;
  /* ./control_unit.vhd:117:13  */
  assign n304 = opcode == 7'b0000011;
  /* ./control_unit.vhd:126:13  */
  assign n306 = opcode == 7'b0100011;
  /* ./control_unit.vhd:139:40  */
  assign n309 = funct3 == 3'b000;
  /* ./control_unit.vhd:139:58  */
  assign n311 = funct3 == 3'b001;
  /* ./control_unit.vhd:139:48  */
  assign n312 = n309 | n311;
  /* ./control_unit.vhd:139:28  */
  assign n313 = n312 ? 4'b0001 : n320;
  /* ./control_unit.vhd:140:40  */
  assign n316 = funct3 == 3'b100;
  /* ./control_unit.vhd:140:58  */
  assign n318 = funct3 == 3'b101;
  /* ./control_unit.vhd:140:48  */
  assign n319 = n316 | n318;
  /* ./control_unit.vhd:139:66  */
  assign n320 = n319 ? 4'b1000 : 4'b1001;
  /* ./control_unit.vhd:133:13  */
  assign n323 = opcode == 7'b1100011;
  /* ./control_unit.vhd:143:13  */
  assign n325 = opcode == 7'b1101111;
  /* ./control_unit.vhd:152:13  */
  assign n327 = opcode == 7'b1100111;
  /* ./control_unit.vhd:161:13  */
  assign n329 = opcode == 7'b0110111;
  /* ./control_unit.vhd:168:13  */
  assign n331 = opcode == 7'b0010111;
  assign n332 = {n331, n329, n327, n325, n323, n306, n304, n302, n265};
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n340 = 4'b0000;
      9'b010000000: n340 = 4'b0000;
      9'b001000000: n340 = 4'b0000;
      9'b000100000: n340 = 4'b0000;
      9'b000010000: n340 = n313;
      9'b000001000: n340 = 4'b0000;
      9'b000000100: n340 = 4'b0000;
      9'b000000010: n340 = n300;
      9'b000000001: n340 = n263;
      default: n340 = 4'b0000;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n344 = 1'b0;
      9'b010000000: n344 = 1'b0;
      9'b001000000: n344 = 1'b0;
      9'b000100000: n344 = 1'b0;
      9'b000010000: n344 = 1'b0;
      9'b000001000: n344 = 1'b0;
      9'b000000100: n344 = 1'b1;
      9'b000000010: n344 = 1'b0;
      9'b000000001: n344 = 1'b0;
      default: n344 = 1'b0;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n348 = 1'b0;
      9'b010000000: n348 = 1'b0;
      9'b001000000: n348 = 1'b0;
      9'b000100000: n348 = 1'b0;
      9'b000010000: n348 = 1'b0;
      9'b000001000: n348 = 1'b1;
      9'b000000100: n348 = 1'b0;
      9'b000000010: n348 = 1'b0;
      9'b000000001: n348 = 1'b0;
      default: n348 = 1'b0;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n352 = 1'b0;
      9'b010000000: n352 = 1'b0;
      9'b001000000: n352 = 1'b0;
      9'b000100000: n352 = 1'b0;
      9'b000010000: n352 = 1'b1;
      9'b000001000: n352 = 1'b0;
      9'b000000100: n352 = 1'b0;
      9'b000000010: n352 = 1'b0;
      9'b000000001: n352 = 1'b0;
      default: n352 = 1'b0;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n356 = 1'b0;
      9'b010000000: n356 = 1'b0;
      9'b001000000: n356 = 1'b0;
      9'b000100000: n356 = 1'b1;
      9'b000010000: n356 = 1'b0;
      9'b000001000: n356 = 1'b0;
      9'b000000100: n356 = 1'b0;
      9'b000000010: n356 = 1'b0;
      9'b000000001: n356 = 1'b0;
      default: n356 = 1'b0;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n360 = 1'b0;
      9'b010000000: n360 = 1'b0;
      9'b001000000: n360 = 1'b1;
      9'b000100000: n360 = 1'b0;
      9'b000010000: n360 = 1'b0;
      9'b000001000: n360 = 1'b0;
      9'b000000100: n360 = 1'b0;
      9'b000000010: n360 = 1'b0;
      9'b000000001: n360 = 1'b0;
      default: n360 = 1'b0;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n370 = 1'b1;
      9'b010000000: n370 = 1'b1;
      9'b001000000: n370 = 1'b1;
      9'b000100000: n370 = 1'b1;
      9'b000010000: n370 = 1'b0;
      9'b000001000: n370 = 1'b0;
      9'b000000100: n370 = 1'b1;
      9'b000000010: n370 = 1'b1;
      9'b000000001: n370 = 1'b1;
      default: n370 = 1'b0;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n376 = 2'b00;
      9'b010000000: n376 = 2'b00;
      9'b001000000: n376 = 2'b10;
      9'b000100000: n376 = 2'b10;
      9'b000010000: n376 = 2'b00;
      9'b000001000: n376 = 2'b00;
      9'b000000100: n376 = 2'b01;
      9'b000000010: n376 = 2'b00;
      9'b000000001: n376 = 2'b00;
      default: n376 = 2'b00;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n387 = 3'b011;
      9'b010000000: n387 = 3'b011;
      9'b001000000: n387 = 3'b000;
      9'b000100000: n387 = 3'b100;
      9'b000010000: n387 = 3'b010;
      9'b000001000: n387 = 3'b001;
      9'b000000100: n387 = 3'b000;
      9'b000000010: n387 = 3'b000;
      9'b000000001: n387 = 3'b000;
      default: n387 = 3'b000;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n399 = 2'b01;
      9'b010000000: n399 = 2'b10;
      9'b001000000: n399 = 2'b00;
      9'b000100000: n399 = 2'b01;
      9'b000010000: n399 = 2'b00;
      9'b000001000: n399 = 2'b00;
      9'b000000100: n399 = 2'b00;
      9'b000000010: n399 = 2'b00;
      9'b000000001: n399 = 2'b00;
      default: n399 = 2'b00;
    endcase
  /* ./control_unit.vhd:63:9  */
  always @*
    case (n332)
      9'b100000000: n411 = 1'b1;
      9'b010000000: n411 = 1'b1;
      9'b001000000: n411 = 1'b1;
      9'b000100000: n411 = 1'b1;
      9'b000010000: n411 = 1'b0;
      9'b000001000: n411 = 1'b1;
      9'b000000100: n411 = 1'b1;
      9'b000000010: n411 = 1'b1;
      9'b000000001: n411 = 1'b0;
      default: n411 = 1'b0;
    endcase
  /* ./control_unit.vhd:185:13  */
  assign n418 = reset ? 3'b000 : next_state;
  /* ./control_unit.vhd:212:13  */
  assign n424 = state == 3'b000;
  /* ./control_unit.vhd:215:13  */
  assign n426 = state == 3'b001;
  /* ./control_unit.vhd:219:13  */
  assign n428 = state == 3'b010;
  /* ./control_unit.vhd:236:25  */
  assign n431 = d_reg_write ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:241:25  */
  assign n434 = d_reg_write ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:244:43  */
  assign n435 = d_is_load | d_is_store;
  /* ./control_unit.vhd:244:21  */
  assign n438 = n435 ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:244:21  */
  assign n441 = n435 ? 3'b100 : 3'b101;
  /* ./control_unit.vhd:239:21  */
  assign n444 = d_is_jalr ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:239:21  */
  assign n446 = d_is_jalr ? n434 : 1'b0;
  /* ./control_unit.vhd:239:21  */
  assign n448 = d_is_jalr ? 1'b0 : n438;
  /* ./control_unit.vhd:239:21  */
  assign n450 = d_is_jalr ? 3'b000 : n441;
  /* ./control_unit.vhd:234:21  */
  assign n452 = d_is_jal ? 1'b1 : n444;
  /* ./control_unit.vhd:234:21  */
  assign n453 = d_is_jal ? n431 : n446;
  /* ./control_unit.vhd:234:21  */
  assign n455 = d_is_jal ? 1'b0 : n448;
  /* ./control_unit.vhd:234:21  */
  assign n457 = d_is_jal ? 3'b000 : n450;
  /* ./control_unit.vhd:226:21  */
  assign n459 = d_is_branch ? 1'b1 : n452;
  /* ./control_unit.vhd:226:21  */
  assign n461 = d_is_branch ? 1'b0 : n453;
  /* ./control_unit.vhd:226:21  */
  assign n463 = d_is_branch ? 1'b0 : n455;
  /* ./control_unit.vhd:226:21  */
  assign n465 = d_is_branch ? 3'b000 : n457;
  /* ./control_unit.vhd:225:17  */
  assign n467 = alu_done ? n459 : 1'b0;
  /* ./control_unit.vhd:225:17  */
  assign n469 = alu_done ? n461 : 1'b0;
  /* ./control_unit.vhd:225:17  */
  assign n471 = alu_done ? n463 : 1'b0;
  /* ./control_unit.vhd:225:17  */
  assign n472 = alu_done ? n465 : state;
  /* ./control_unit.vhd:224:13  */
  assign n474 = state == 3'b011;
  /* ./control_unit.vhd:258:17  */
  assign n477 = d_is_store ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:258:17  */
  assign n480 = d_is_store ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:258:17  */
  assign n482 = d_is_store ? 3'b000 : state;
  /* ./control_unit.vhd:255:17  */
  assign n484 = d_is_load ? 1'b0 : n477;
  /* ./control_unit.vhd:255:17  */
  assign n487 = d_is_load ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:255:17  */
  assign n489 = d_is_load ? 1'b0 : n480;
  /* ./control_unit.vhd:255:17  */
  assign n491 = d_is_load ? 3'b101 : n482;
  /* ./control_unit.vhd:254:13  */
  assign n493 = state == 3'b100;
  /* ./control_unit.vhd:265:17  */
  assign n496 = d_reg_write ? 1'b1 : 1'b0;
  /* ./control_unit.vhd:264:13  */
  assign n498 = state == 3'b101;
  assign n499 = {n498, n493, n474, n428, n426, n424};
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n503 = 1'b0;
      6'b010000: n503 = 1'b0;
      6'b001000: n503 = 1'b0;
      6'b000100: n503 = 1'b0;
      6'b000010: n503 = 1'b1;
      6'b000001: n503 = 1'b0;
      default: n503 = 1'bX;
    endcase
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n508 = 1'b1;
      6'b010000: n508 = n484;
      6'b001000: n508 = n467;
      6'b000100: n508 = 1'b0;
      6'b000010: n508 = 1'b0;
      6'b000001: n508 = 1'b0;
      default: n508 = 1'bX;
    endcase
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n512 = n496;
      6'b010000: n512 = 1'b0;
      6'b001000: n512 = n469;
      6'b000100: n512 = 1'b0;
      6'b000010: n512 = 1'b0;
      6'b000001: n512 = 1'b0;
      default: n512 = 1'bX;
    endcase
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n516 = 1'b0;
      6'b010000: n516 = n487;
      6'b001000: n516 = 1'b0;
      6'b000100: n516 = 1'b0;
      6'b000010: n516 = 1'b0;
      6'b000001: n516 = 1'b0;
      default: n516 = 1'bX;
    endcase
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n520 = 1'b0;
      6'b010000: n520 = n489;
      6'b001000: n520 = 1'b0;
      6'b000100: n520 = 1'b0;
      6'b000010: n520 = 1'b0;
      6'b000001: n520 = 1'b0;
      default: n520 = 1'bX;
    endcase
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n525 = 1'b0;
      6'b010000: n525 = 1'b0;
      6'b001000: n525 = 1'b0;
      6'b000100: n525 = 1'b1;
      6'b000010: n525 = 1'b0;
      6'b000001: n525 = 1'b0;
      default: n525 = 1'bX;
    endcase
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n529 = 1'b0;
      6'b010000: n529 = 1'b0;
      6'b001000: n529 = n471;
      6'b000100: n529 = 1'b0;
      6'b000010: n529 = 1'b0;
      6'b000001: n529 = 1'b0;
      default: n529 = 1'bX;
    endcase
  /* ./control_unit.vhd:211:9  */
  always @*
    case (n499)
      6'b100000: n536 = 3'b000;
      6'b010000: n536 = n491;
      6'b001000: n536 = n472;
      6'b000100: n536 = 3'b011;
      6'b000010: n536 = 3'b010;
      6'b000001: n536 = 3'b001;
      default: n536 = 3'bX;
    endcase
  /* ./control_unit.vhd:184:9  */
  always @(posedge clk)
    n538 <= n418;
endmodule

module rom_6
  (input  clk,
   input  [7:0] instr_addr,
   input  [7:0] data_addr,
   output [31:0] instr_data,
   output [31:0] data_data);
  wire [5:0] instr_word_addr;
  wire [5:0] data_word_addr;
  reg [2047:0] rom_array;
  wire [31:0] instr_reg;
  wire [31:0] data_reg;
  wire [7:0] n176;
  wire [5:0] n178;
  wire [7:0] n180;
  wire [5:0] n182;
  reg [31:0] n202; // mem_rd
  reg [31:0] n204; // mem_rd
  assign instr_data = instr_reg; //(module output)
  assign data_data = data_reg; //(module output)
  /* ./rom.vhd:19:12  */
  assign instr_word_addr = n178; // (signal)
  /* ./rom.vhd:20:12  */
  assign data_word_addr = n182; // (signal)
  /* ./rom.vhd:23:12  */
  always @*
    rom_array = 2048'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001101111000000000010000010100000001000110000011011000000000000010001001100100000000000000000000010110111; // (isignal)
  initial
    rom_array = 2048'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001101111000000000010000010100000001000110000011011000000000000010001001100100000000000000000000010110111;
  /* ./rom.vhd:32:12  */
  assign instr_reg = n204; // (signal)
  /* ./rom.vhd:33:12  */
  assign data_reg = n202; // (signal)
  /* ./rom.vhd:36:35  */
  assign n176 = instr_addr >> 31'b0000000000000000000000000000010;
  /* ./rom.vhd:36:24  */
  assign n178 = n176[5:0];  // trunc
  /* ./rom.vhd:37:35  */
  assign n180 = data_addr >> 31'b0000000000000000000000000000010;
  /* ./rom.vhd:37:24  */
  assign n182 = n180[5:0];  // trunc
  /* ./rom.vhd:43:36  */
  reg [31:0] n199[63:0] ; // memory
  initial begin
    n199[63] = 32'b00000000000000000000000000000000;
    n199[62] = 32'b00000000000000000000000000000000;
    n199[61] = 32'b00000000000000000000000000000000;
    n199[60] = 32'b00000000000000000000000000000000;
    n199[59] = 32'b00000000000000000000000000000000;
    n199[58] = 32'b00000000000000000000000000000000;
    n199[57] = 32'b00000000000000000000000000000000;
    n199[56] = 32'b00000000000000000000000000000000;
    n199[55] = 32'b00000000000000000000000000000000;
    n199[54] = 32'b00000000000000000000000000000000;
    n199[53] = 32'b00000000000000000000000000000000;
    n199[52] = 32'b00000000000000000000000000000000;
    n199[51] = 32'b00000000000000000000000000000000;
    n199[50] = 32'b00000000000000000000000000000000;
    n199[49] = 32'b00000000000000000000000000000000;
    n199[48] = 32'b00000000000000000000000000000000;
    n199[47] = 32'b00000000000000000000000000000000;
    n199[46] = 32'b00000000000000000000000000000000;
    n199[45] = 32'b00000000000000000000000000000000;
    n199[44] = 32'b00000000000000000000000000000000;
    n199[43] = 32'b00000000000000000000000000000000;
    n199[42] = 32'b00000000000000000000000000000000;
    n199[41] = 32'b00000000000000000000000000000000;
    n199[40] = 32'b00000000000000000000000000000000;
    n199[39] = 32'b00000000000000000000000000000000;
    n199[38] = 32'b00000000000000000000000000000000;
    n199[37] = 32'b00000000000000000000000000000000;
    n199[36] = 32'b00000000000000000000000000000000;
    n199[35] = 32'b00000000000000000000000000000000;
    n199[34] = 32'b00000000000000000000000000000000;
    n199[33] = 32'b00000000000000000000000000000000;
    n199[32] = 32'b00000000000000000000000000000000;
    n199[31] = 32'b00000000000000000000000000000000;
    n199[30] = 32'b00000000000000000000000000000000;
    n199[29] = 32'b00000000000000000000000000000000;
    n199[28] = 32'b00000000000000000000000000000000;
    n199[27] = 32'b00000000000000000000000000000000;
    n199[26] = 32'b00000000000000000000000000000000;
    n199[25] = 32'b00000000000000000000000000000000;
    n199[24] = 32'b00000000000000000000000000000000;
    n199[23] = 32'b00000000000000000000000000000000;
    n199[22] = 32'b00000000000000000000000000000000;
    n199[21] = 32'b00000000000000000000000000000000;
    n199[20] = 32'b00000000000000000000000000000000;
    n199[19] = 32'b00000000000000000000000000000000;
    n199[18] = 32'b00000000000000000000000000000000;
    n199[17] = 32'b00000000000000000000000000000000;
    n199[16] = 32'b00000000000000000000000000000000;
    n199[15] = 32'b00000000000000000000000000000000;
    n199[14] = 32'b00000000000000000000000000000000;
    n199[13] = 32'b00000000000000000000000000000000;
    n199[12] = 32'b00000000000000000000000000000000;
    n199[11] = 32'b00000000000000000000000000000000;
    n199[10] = 32'b00000000000000000000000000000000;
    n199[9] = 32'b00000000000000000000000000000000;
    n199[8] = 32'b00000000000000000000000000000000;
    n199[7] = 32'b00000000000000000000000000000000;
    n199[6] = 32'b00000000000000000000000000000000;
    n199[5] = 32'b00000000000000000000000000000000;
    n199[4] = 32'b00000000000000000000000000000000;
    n199[3] = 32'b00000000000000000000000001101111;
    n199[2] = 32'b00000000001000001010000000100011;
    n199[1] = 32'b00000110110000000000000100010011;
    n199[0] = 32'b00100000000000000000000010110111;
    end
  always @(posedge clk)
    if (1'b1)
      n202 <= n199[data_word_addr];
  always @(posedge clk)
    if (1'b1)
      n204 <= n199[instr_word_addr];
  /* ./rom.vhd:44:36  */
  /* ./rom.vhd:44:35  */
endmodule

module programcounter
  (input  clk,
   input  reset,
   input  pc_write,
   input  [31:0] pc_in,
   output [31:0] pc_out);
  reg [31:0] pc_reg;
  wire [31:0] n166;
  wire [31:0] n168;
  reg [31:0] n171;
  assign pc_out = pc_reg; //(module output)
  /* ./pc.vhd:16:12  */
  always @*
    pc_reg = n171; // (isignal)
  initial
    pc_reg = 32'b00000000000000000000000000000000;
  /* ./pc.vhd:24:13  */
  assign n166 = pc_write ? pc_in : pc_reg;
  /* ./pc.vhd:22:13  */
  assign n168 = reset ? 32'b00000000000000000000000000000000 : n166;
  /* ./pc.vhd:21:9  */
  always @(posedge clk)
    n171 <= n168;
  initial
    n171 = 32'b00000000000000000000000000000000;
endmodule

module top
  (input  clk,
   input  [23:0] io_in,
   output [23:0] io_out,
   output [23:0] io_oeb);
  localparam [23:0] n0 = 24'b000000000000000000000000;
  localparam [23:0] n2 = 24'b111111111111111111111111;
  wire reset;
  wire internal_reset;
  reg reset_sync_0;
  reg reset_sync_1;
  reg [31:0] pc;
  reg [31:0] pc_plus_four;
  reg [31:0] next_pc;
  reg [31:0] jalr_target;
  reg [31:0] branch_target;
  wire [31:0] instr_reg;
  wire [6:0] opcode;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire [4:0] rs1_addr;
  wire [4:0] rs2_addr;
  wire [4:0] rd_addr;
  reg [31:0] rs1_data;
  reg [31:0] rs2_data;
  reg [31:0] reg_write_data;
  wire [31:0] imm;
  wire [31:0] alu_input_a;
  wire [31:0] alu_input_b;
  wire [31:0] alu_result;
  wire [3:0] alu_control;
  wire zero_flag;
  wire alu_start;
  wire alu_done;
  wire [31:0] mem_data;
  wire [31:0] rom_instr_data;
  wire [31:0] rom_read_data;
  wire [31:0] uart_read_data;
  wire [7:0] rom_addr;
  wire rom_en;
  wire uart_en;
  wire ir_write;
  wire pc_write;
  wire reg_write;
  wire [1:0] alu_src_a;
  wire alu_src_b;
  wire latch_store_data;
  wire [1:0] wb_sel;
  wire [2:0] imm_type;
  wire branch_taken;
  wire is_branch;
  wire is_jalr;
  wire is_jal;
  reg [31:0] store_data;
  wire n16;
  wire [31:0] n25;
  wire [31:0] n27;
  wire [31:0] n37;
  wire [31:0] n39;
  wire [31:0] n40;
  wire n43;
  wire n44;
  wire n46;
  wire n47;
  wire n48;
  wire n49;
  wire n51;
  wire n53;
  wire n54;
  wire n55;
  wire n57;
  wire n59;
  wire n60;
  wire n61;
  wire n63;
  wire n65;
  wire n66;
  wire n67;
  wire n69;
  wire n71;
  wire n72;
  wire n73;
  wire n74;
  wire n75;
  wire [31:0] n77;
  wire [31:0] n78;
  wire [31:0] n79;
  wire [31:0] \pc_unit.pc_out ;
  wire [7:0] n81;
  wire [31:0] n87;
  wire [31:0] n89;
  wire [6:0] n92;
  wire [4:0] n93;
  wire [2:0] n94;
  wire [4:0] n95;
  wire [4:0] n96;
  wire [6:0] n97;
  wire \cu.mem_read ;
  wire \cu.mem_write ;
  wire [31:0] \regfile_inst.rs1_data ;
  wire [31:0] \regfile_inst.rs2_data ;
  wire \addr_dec_inst.ram_en ;
  wire [7:0] \addr_dec_inst.ram_addr ;
  wire [1:0] \addr_dec_inst.uart_addr ;
  wire \addr_dec_inst.io_en ;
  wire [7:0] n142;
  wire [31:0] n143;
  wire [31:0] n144;
  wire [31:0] \mux_wb_inst.y ;
  reg n147;
  reg n148;
  reg [31:0] n149;
  reg [31:0] n153;
  wire [12:0] n155;
  wire [1:0] n156;
  wire [23:0] n157;
  wire [11:0] n158;
  wire n159;
  wire [23:0] n160;
  assign io_out = n157; //(module output)
  assign io_oeb = n160; //(module output)
  /* ./top.vhd:21:12  */
  assign reset = n16; // (signal)
  /* ./top.vhd:22:12  */
  assign internal_reset = reset_sync_1; // (signal)
  /* ./top.vhd:23:12  */
  always @*
    reset_sync_0 = n147; // (isignal)
  initial
    reset_sync_0 = 1'b1;
  /* ./top.vhd:23:26  */
  always @*
    reset_sync_1 = n148; // (isignal)
  initial
    reset_sync_1 = 1'b1;
  /* ./top.vhd:26:12  */
  always @*
    pc = \pc_unit.pc_out ; // (isignal)
  initial
    pc = 32'b00000000000000000000000000000000;
  /* ./top.vhd:26:16  */
  always @*
    pc_plus_four = n37; // (isignal)
  initial
    pc_plus_four = 32'b00000000000000000000000000000000;
  /* ./top.vhd:26:30  */
  always @*
    next_pc = n77; // (isignal)
  initial
    next_pc = 32'b00000000000000000000000000000000;
  /* ./top.vhd:26:39  */
  always @*
    jalr_target = n39; // (isignal)
  initial
    jalr_target = 32'b00000000000000000000000000000000;
  /* ./top.vhd:26:52  */
  always @*
    branch_target = n40; // (isignal)
  initial
    branch_target = 32'b00000000000000000000000000000000;
  /* ./top.vhd:29:12  */
  assign instr_reg = n149; // (signal)
  /* ./top.vhd:30:12  */
  assign opcode = n92; // (signal)
  /* ./top.vhd:31:12  */
  assign funct3 = n94; // (signal)
  /* ./top.vhd:32:12  */
  assign funct7 = n97; // (signal)
  /* ./top.vhd:33:12  */
  assign rs1_addr = n95; // (signal)
  /* ./top.vhd:33:22  */
  assign rs2_addr = n96; // (signal)
  /* ./top.vhd:33:32  */
  assign rd_addr = n93; // (signal)
  /* ./top.vhd:36:12  */
  always @*
    rs1_data = \regfile_inst.rs1_data ; // (isignal)
  initial
    rs1_data = 32'b00000000000000000000000000000000;
  /* ./top.vhd:36:22  */
  always @*
    rs2_data = \regfile_inst.rs2_data ; // (isignal)
  initial
    rs2_data = 32'b00000000000000000000000000000000;
  /* ./top.vhd:36:32  */
  always @*
    reg_write_data = \mux_wb_inst.y ; // (isignal)
  initial
    reg_write_data = 32'b00000000000000000000000000000000;
  /* ./top.vhd:47:12  */
  assign mem_data = n143; // (signal)
  /* ./top.vhd:47:53  */
  assign uart_read_data = 32'bX; // (signal)
  /* ./top.vhd:61:12  */
  assign branch_taken = n75; // (signal)
  /* ./top.vhd:68:12  */
  always @*
    store_data = n153; // (isignal)
  initial
    store_data = 32'b00000000000000000000000000000000;
  /* ./top.vhd:73:19  */
  assign n16 = io_in[23]; // extract
  /* ./top.vhd:88:13  */
  assign n25 = latch_store_data ? rs2_data : store_data;
  /* ./top.vhd:86:13  */
  assign n27 = internal_reset ? 32'b00000000000000000000000000000000 : n25;
  /* ./top.vhd:106:51  */
  assign n37 = pc + 32'b00000000000000000000000000000100;
  /* ./top.vhd:107:33  */
  assign n39 = alu_result & 32'b11111111111111111111111111111110;
  /* ./top.vhd:108:50  */
  assign n40 = pc + imm;
  /* ./top.vhd:110:17  */
  assign n43 = funct3 == 3'b000;
  /* ./top.vhd:110:25  */
  assign n44 = zero_flag & n43;
  /* ./top.vhd:111:17  */
  assign n46 = funct3 == 3'b001;
  /* ./top.vhd:111:39  */
  assign n47 = ~zero_flag;
  /* ./top.vhd:111:25  */
  assign n48 = n47 & n46;
  /* ./top.vhd:110:46  */
  assign n49 = n44 | n48;
  /* ./top.vhd:112:17  */
  assign n51 = funct3 == 3'b100;
  /* ./top.vhd:112:40  */
  assign n53 = alu_result == 32'b00000000000000000000000000000001;
  /* ./top.vhd:112:25  */
  assign n54 = n53 & n51;
  /* ./top.vhd:111:46  */
  assign n55 = n49 | n54;
  /* ./top.vhd:113:17  */
  assign n57 = funct3 == 3'b101;
  /* ./top.vhd:113:40  */
  assign n59 = alu_result == 32'b00000000000000000000000000000000;
  /* ./top.vhd:113:25  */
  assign n60 = n59 & n57;
  /* ./top.vhd:112:55  */
  assign n61 = n55 | n60;
  /* ./top.vhd:114:17  */
  assign n63 = funct3 == 3'b110;
  /* ./top.vhd:114:40  */
  assign n65 = alu_result == 32'b00000000000000000000000000000001;
  /* ./top.vhd:114:25  */
  assign n66 = n65 & n63;
  /* ./top.vhd:113:55  */
  assign n67 = n61 | n66;
  /* ./top.vhd:115:17  */
  assign n69 = funct3 == 3'b111;
  /* ./top.vhd:115:40  */
  assign n71 = alu_result == 32'b00000000000000000000000000000000;
  /* ./top.vhd:115:25  */
  assign n72 = n71 & n69;
  /* ./top.vhd:114:55  */
  assign n73 = n67 | n72;
  /* ./top.vhd:109:47  */
  assign n74 = n73 & is_branch;
  /* ./top.vhd:109:26  */
  assign n75 = n74 ? 1'b1 : 1'b0;
  /* ./top.vhd:119:23  */
  assign n77 = is_jalr ? jalr_target : n78;
  /* ./top.vhd:119:44  */
  assign n78 = is_jal ? alu_result : n79;
  /* ./top.vhd:120:43  */
  assign n79 = branch_taken ? branch_target : pc_plus_four;
  /* ./top.vhd:124:5  */
  programcounter pc_unit (
    .clk(clk),
    .reset(internal_reset),
    .pc_write(pc_write),
    .pc_in(next_pc),
    .pc_out(\pc_unit.pc_out ));
  /* ./top.vhd:134:5  */
  rom_6 rom_inst (
    .clk(clk),
    .instr_addr(n81),
    .data_addr(rom_addr),
    .instr_data(rom_instr_data),
    .data_data(rom_read_data));
  /* ./top.vhd:137:30  */
  assign n81 = pc[7:0]; // extract
  /* ./top.vhd:149:13  */
  assign n87 = ir_write ? rom_instr_data : instr_reg;
  /* ./top.vhd:147:13  */
  assign n89 = internal_reset ? 32'b00000000000000000000000000000000 : n87;
  /* ./top.vhd:156:26  */
  assign n92 = instr_reg[6:0]; // extract
  /* ./top.vhd:157:26  */
  assign n93 = instr_reg[11:7]; // extract
  /* ./top.vhd:158:26  */
  assign n94 = instr_reg[14:12]; // extract
  /* ./top.vhd:159:26  */
  assign n95 = instr_reg[19:15]; // extract
  /* ./top.vhd:160:26  */
  assign n96 = instr_reg[24:20]; // extract
  /* ./top.vhd:161:26  */
  assign n97 = instr_reg[31:25]; // extract
  /* ./top.vhd:164:5  */
  control_unit cu (
    .clk(clk),
    .reset(internal_reset),
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .zero_flag(zero_flag),
    .alu_done(alu_done),
    .branch_taken(branch_taken),
    .ir_write(ir_write),
    .pc_write(pc_write),
    .reg_write(reg_write),
    .mem_read(),
    .mem_write(),
    .alu_src_a(alu_src_a),
    .alu_src_b(alu_src_b),
    .alu_control(alu_control),
    .alu_start(alu_start),
    .latch_store_data(latch_store_data),
    .wb_sel(wb_sel),
    .is_branch(is_branch),
    .is_jalr(is_jalr),
    .is_jal(is_jal),
    .imm_type(imm_type));
  /* ./top.vhd:192:5  */
  reg_file regfile_inst (
    .clk(clk),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .rd_addr(rd_addr),
    .rd_data(reg_write_data),
    .reg_write(reg_write),
    .rs1_data(\regfile_inst.rs1_data ),
    .rs2_data(\regfile_inst.rs2_data ));
  /* ./top.vhd:205:5  */
  imm_gen immgen_inst (
    .instr(instr_reg),
    .imm_type(imm_type),
    .imm_out(imm));
  /* ./top.vhd:213:5  */
  mux_a mux_a_inst (
    .clk(clk),
    .sel(alu_src_a),
    .rs1(rs1_data),
    .pc(pc),
    .result(alu_input_a));
  /* ./top.vhd:222:5  */
  mux_b mux_b_inst (
    .clk(clk),
    .sel(alu_src_b),
    .rs2(rs2_data),
    .imm(imm),
    .result(alu_input_b));
  /* ./top.vhd:232:5  */
  alu alu_inst (
    .clk(clk),
    .reset(internal_reset),
    .start(alu_start),
    .op_a(alu_input_a),
    .op_b(alu_input_b),
    .alu_control(alu_control),
    .result(alu_result),
    .zero(zero_flag),
    .done(alu_done));
  /* ./top.vhd:246:5  */
  address_decoder addr_dec_inst (
    .addr(alu_result),
    .ram_en(),
    .ram_addr(),
    .uart_en(uart_en),
    .uart_addr(),
    .rom_en(rom_en),
    .rom_addr(rom_addr),
    .io_en());
  /* ./top.vhd:281:39  */
  assign n142 = store_data[7:0]; // extract
  /* ./top.vhd:284:32  */
  assign n143 = uart_en ? uart_read_data : n144;
  /* ./top.vhd:284:51  */
  assign n144 = rom_en ? rom_read_data : 32'b00000000000000000000000000000000;
  /* ./top.vhd:289:5  */
  mux_wb mux_wb_inst (
    .clk(clk),
    .sel(wb_sel),
    .a(alu_result),
    .b(mem_data),
    .c(pc_plus_four),
    .y(\mux_wb_inst.y ));
  /* ./top.vhd:97:9  */
  always @(posedge clk)
    n147 <= reset;
  initial
    n147 = 1'b1;
  /* ./top.vhd:97:9  */
  always @(posedge clk)
    n148 <= reset_sync_0;
  initial
    n148 = 1'b1;
  /* ./top.vhd:146:9  */
  always @(posedge clk)
    n149 <= n89;
  /* ./top.vhd:85:9  */
  always @(posedge clk)
    n153 <= n27;
  initial
    n153 = 32'b00000000000000000000000000000000;
  assign n155 = n0[13:1]; // extract
  assign n156 = n0[23:22]; // extract
  assign n157 = {n156, n142, n155, 1'b1};
  assign n158 = n2[12:1]; // extract
  assign n159 = n2[22]; // extract
  assign n160 = {1'b0, n159, 8'b11111111, 1'b1, n158, 1'b1};
endmodule

