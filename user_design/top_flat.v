module mux_wb
  (input  clk,
   input  [1:0] sel,
   input  [31:0] a,
   input  [31:0] b,
   input  [31:0] c,
   output [31:0] y);
  wire [31:0] y_next;
  wire [31:0] y_reg;
  wire n1500;
  wire n1502;
  wire n1504;
  wire [2:0] n1505;
  reg [31:0] n1506;
  reg [31:0] n1513;
  assign y = y_reg; //(module output)
  /* mux_wb.vhd:17:12  */
  assign y_next = n1506; // (signal)
  /* mux_wb.vhd:18:12  */
  assign y_reg = n1513; // (signal)
  /* mux_wb.vhd:24:13  */
  assign n1500 = sel == 2'b00;
  /* mux_wb.vhd:25:13  */
  assign n1502 = sel == 2'b01;
  /* mux_wb.vhd:26:13  */
  assign n1504 = sel == 2'b10;
  assign n1505 = {n1504, n1502, n1500};
  /* mux_wb.vhd:23:9  */
  always @*
    case (n1505)
      3'b100: n1506 = c;
      3'b010: n1506 = b;
      3'b001: n1506 = a;
      default: n1506 = a;
    endcase
  /* mux_wb.vhd:34:9  */
  always @(posedge clk)
    n1513 <= y_next;
endmodule

module uart
  (input  clk,
   input  reset,
   input  [1:0] addr,
   input  wr_en,
   input  [31:0] write_data,
   output [31:0] read_data,
   output rstx);
  reg [1:0] state;
  reg [2:0] bit_index;
  reg [31:0] baud_counter;
  wire [7:0] shift_reg;
  reg tx_reg;
  reg tx_ready;
  wire uart_wr_en;
  wire [7:0] uart_data;
  reg [31:0] read_data_reg;
  wire n1377;
  wire n1378;
  wire [1:0] n1384;
  wire [31:0] n1386;
  wire [7:0] n1387;
  wire n1389;
  wire n1391;
  wire [31:0] n1393;
  wire [1:0] n1395;
  wire [31:0] n1397;
  wire n1399;
  wire n1401;
  wire n1403;
  wire [31:0] n1406;
  wire n1408;
  wire [31:0] n1409;
  wire [31:0] n1411;
  wire [2:0] n1412;
  wire [1:0] n1414;
  wire [2:0] n1416;
  wire [31:0] n1418;
  wire n1419;
  wire [2:0] n1420;
  wire [31:0] n1422;
  wire n1423;
  wire n1425;
  wire n1427;
  wire [31:0] n1429;
  wire [1:0] n1431;
  wire [31:0] n1433;
  wire n1435;
  wire n1437;
  wire [3:0] n1438;
  reg [1:0] n1440;
  reg [2:0] n1442;
  reg [31:0] n1444;
  reg [7:0] n1446;
  reg n1448;
  wire [1:0] n1450;
  wire [2:0] n1452;
  wire [31:0] n1454;
  wire [7:0] n1455;
  wire n1457;
  wire [7:0] n1464;
  wire n1467;
  wire n1468;
  wire n1469;
  wire n1470;
  wire n1476;
  wire [31:0] n1478;
  wire n1480;
  wire [1:0] n1481;
  reg [31:0] n1484;
  wire [31:0] n1486;
  reg [1:0] n1489;
  reg [2:0] n1490;
  reg [31:0] n1491;
  reg [7:0] n1492;
  reg n1493;
  reg [31:0] n1494;
  wire n1495;
  assign read_data = read_data_reg; //(module output)
  assign rstx = tx_reg; //(module output)
  /* uart.vhd:23:12  */
  always @*
    state = n1489; // (isignal)
  initial
    state = 2'b00;
  /* uart.vhd:24:12  */
  always @*
    bit_index = n1490; // (isignal)
  initial
    bit_index = 3'b000;
  /* uart.vhd:25:12  */
  always @*
    baud_counter = n1491; // (isignal)
  initial
    baud_counter = 32'b00000000000000000000000000000000;
  /* uart.vhd:26:12  */
  assign shift_reg = n1492; // (signal)
  /* uart.vhd:27:12  */
  always @*
    tx_reg = n1493; // (isignal)
  initial
    tx_reg = 1'b1;
  /* uart.vhd:29:12  */
  always @*
    tx_ready = n1378; // (isignal)
  initial
    tx_ready = 1'b0;
  /* uart.vhd:31:12  */
  assign uart_wr_en = n1470; // (signal)
  /* uart.vhd:32:12  */
  assign uart_data = n1464; // (signal)
  /* uart.vhd:34:12  */
  always @*
    read_data_reg = n1494; // (isignal)
  initial
    read_data_reg = 32'b00000000000000000000000000000000;
  /* uart.vhd:41:32  */
  assign n1377 = state == 2'b00;
  /* uart.vhd:41:21  */
  assign n1378 = n1377 ? 1'b1 : 1'b0;
  /* uart.vhd:55:25  */
  assign n1384 = uart_wr_en ? 2'b01 : state;
  /* uart.vhd:55:25  */
  assign n1386 = uart_wr_en ? 32'b00000000000000000000000000000000 : baud_counter;
  /* uart.vhd:55:25  */
  assign n1387 = uart_wr_en ? uart_data : shift_reg;
  /* uart.vhd:54:21  */
  assign n1389 = state == 2'b00;
  /* uart.vhd:62:41  */
  assign n1391 = baud_counter == 32'b00000000000000000000000001010101;
  /* uart.vhd:67:58  */
  assign n1393 = baud_counter + 32'b00000000000000000000000000000001;
  /* uart.vhd:62:25  */
  assign n1395 = n1391 ? 2'b10 : state;
  /* uart.vhd:62:25  */
  assign n1397 = n1391 ? 32'b00000000000000000000000000000000 : n1393;
  /* uart.vhd:62:25  */
  assign n1399 = n1391 ? 1'b0 : tx_reg;
  /* uart.vhd:61:21  */
  assign n1401 = state == 2'b01;
  /* uart.vhd:71:41  */
  assign n1403 = baud_counter == 32'b00000000000000000000000001010101;
  /* uart.vhd:74:42  */
  assign n1406 = {29'b0, bit_index};  //  uext
  /* uart.vhd:74:42  */
  assign n1408 = n1406 == 32'b00000000000000000000000000000111;
  /* uart.vhd:78:56  */
  assign n1409 = {29'b0, bit_index};  //  uext
  /* uart.vhd:78:56  */
  assign n1411 = n1409 + 32'b00000000000000000000000000000001;
  /* uart.vhd:78:46  */
  assign n1412 = n1411[2:0];  // trunc
  /* uart.vhd:71:25  */
  assign n1414 = n1419 ? 2'b11 : state;
  /* uart.vhd:74:29  */
  assign n1416 = n1408 ? 3'b000 : n1412;
  /* uart.vhd:81:58  */
  assign n1418 = baud_counter + 32'b00000000000000000000000000000001;
  /* uart.vhd:71:25  */
  assign n1419 = n1408 & n1403;
  /* uart.vhd:71:25  */
  assign n1420 = n1403 ? n1416 : bit_index;
  /* uart.vhd:71:25  */
  assign n1422 = n1403 ? 32'b00000000000000000000000000000000 : n1418;
  /* uart.vhd:71:25  */
  assign n1423 = n1403 ? n1495 : tx_reg;
  /* uart.vhd:70:21  */
  assign n1425 = state == 2'b10;
  /* uart.vhd:85:41  */
  assign n1427 = baud_counter == 32'b00000000000000000000000001010101;
  /* uart.vhd:90:58  */
  assign n1429 = baud_counter + 32'b00000000000000000000000000000001;
  /* uart.vhd:85:25  */
  assign n1431 = n1427 ? 2'b00 : state;
  /* uart.vhd:85:25  */
  assign n1433 = n1427 ? 32'b00000000000000000000000000000000 : n1429;
  /* uart.vhd:85:25  */
  assign n1435 = n1427 ? 1'b1 : tx_reg;
  /* uart.vhd:84:21  */
  assign n1437 = state == 2'b11;
  assign n1438 = {n1437, n1425, n1401, n1389};
  /* uart.vhd:53:17  */
  always @*
    case (n1438)
      4'b1000: n1440 = n1431;
      4'b0100: n1440 = n1414;
      4'b0010: n1440 = n1395;
      4'b0001: n1440 = n1384;
      default: n1440 = 2'bX;
    endcase
  /* uart.vhd:53:17  */
  always @*
    case (n1438)
      4'b1000: n1442 = bit_index;
      4'b0100: n1442 = n1420;
      4'b0010: n1442 = bit_index;
      4'b0001: n1442 = bit_index;
      default: n1442 = 3'bX;
    endcase
  /* uart.vhd:53:17  */
  always @*
    case (n1438)
      4'b1000: n1444 = n1433;
      4'b0100: n1444 = n1422;
      4'b0010: n1444 = n1397;
      4'b0001: n1444 = n1386;
      default: n1444 = 32'bX;
    endcase
  /* uart.vhd:53:17  */
  always @*
    case (n1438)
      4'b1000: n1446 = shift_reg;
      4'b0100: n1446 = shift_reg;
      4'b0010: n1446 = shift_reg;
      4'b0001: n1446 = n1387;
      default: n1446 = 8'bX;
    endcase
  /* uart.vhd:53:17  */
  always @*
    case (n1438)
      4'b1000: n1448 = n1435;
      4'b0100: n1448 = n1423;
      4'b0010: n1448 = n1399;
      4'b0001: n1448 = tx_reg;
      default: n1448 = 1'bX;
    endcase
  /* uart.vhd:47:13  */
  assign n1450 = reset ? 2'b00 : n1440;
  /* uart.vhd:47:13  */
  assign n1452 = reset ? 3'b000 : n1442;
  /* uart.vhd:47:13  */
  assign n1454 = reset ? 32'b00000000000000000000000000000000 : n1444;
  /* uart.vhd:47:13  */
  assign n1455 = reset ? shift_reg : n1446;
  /* uart.vhd:47:13  */
  assign n1457 = reset ? 1'b1 : n1448;
  /* uart.vhd:99:29  */
  assign n1464 = write_data[7:0]; // extract
  /* uart.vhd:102:50  */
  assign n1467 = addr == 2'b00;
  /* uart.vhd:102:41  */
  assign n1468 = n1467 & wr_en;
  /* uart.vhd:102:57  */
  assign n1469 = tx_ready & n1468;
  /* uart.vhd:102:23  */
  assign n1470 = n1469 ? 1'b1 : 1'b0;
  /* uart.vhd:112:21  */
  assign n1476 = addr == 2'b00;
  /* uart.vhd:115:63  */
  assign n1478 = {31'b0000000000000000000000000000000, tx_ready};
  /* uart.vhd:114:21  */
  assign n1480 = addr == 2'b01;
  assign n1481 = {n1480, n1476};
  /* uart.vhd:111:17  */
  always @*
    case (n1481)
      2'b10: n1484 = n1478;
      2'b01: n1484 = 32'b00000000000000000000000000000000;
      default: n1484 = 32'b00000000000000000000000000000000;
    endcase
  /* uart.vhd:108:13  */
  assign n1486 = reset ? 32'b00000000000000000000000000000000 : n1484;
  /* uart.vhd:46:9  */
  always @(posedge clk)
    n1489 <= n1450;
  initial
    n1489 = 2'b00;
  /* uart.vhd:46:9  */
  always @(posedge clk)
    n1490 <= n1452;
  initial
    n1490 = 3'b000;
  /* uart.vhd:46:9  */
  always @(posedge clk)
    n1491 <= n1454;
  initial
    n1491 = 32'b00000000000000000000000000000000;
  /* uart.vhd:46:9  */
  always @(posedge clk)
    n1492 <= n1455;
  /* uart.vhd:46:9  */
  always @(posedge clk)
    n1493 <= n1457;
  initial
    n1493 = 1'b1;
  /* uart.vhd:107:9  */
  always @(posedge clk)
    n1494 <= n1486;
  initial
    n1494 = 32'b00000000000000000000000000000000;
  /* uart.vhd:73:49  */
  assign n1495 = shift_reg[bit_index * 1 +: 1]; //(Bmux)
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
  wire [19:0] n1342;
  wire n1344;
  wire n1345;
  wire [7:0] n1347;
  wire [19:0] n1349;
  wire n1351;
  wire n1352;
  wire [7:0] n1354;
  wire [19:0] n1356;
  wire n1358;
  wire n1359;
  wire [1:0] n1361;
  wire n1364;
  wire n1365;
  assign ram_en = n1352; //(module output)
  assign ram_addr = n1354; //(module output)
  assign uart_en = n1359; //(module output)
  assign uart_addr = n1361; //(module output)
  assign rom_en = n1345; //(module output)
  assign rom_addr = n1347; //(module output)
  assign io_en = n1365; //(module output)
  /* address_decoder.vhd:22:28  */
  assign n1342 = addr[31:12]; // extract
  /* address_decoder.vhd:22:43  */
  assign n1344 = n1342 == 20'b00000000000000000000;
  /* address_decoder.vhd:22:19  */
  assign n1345 = n1344 ? 1'b1 : 1'b0;
  /* address_decoder.vhd:23:21  */
  assign n1347 = addr[7:0]; // extract
  /* address_decoder.vhd:26:30  */
  assign n1349 = addr[31:12]; // extract
  /* address_decoder.vhd:26:45  */
  assign n1351 = n1349 == 20'b00010000000000000000;
  /* address_decoder.vhd:26:21  */
  assign n1352 = n1351 ? 1'b1 : 1'b0;
  /* address_decoder.vhd:27:21  */
  assign n1354 = addr[7:0]; // extract
  /* address_decoder.vhd:30:31  */
  assign n1356 = addr[31:12]; // extract
  /* address_decoder.vhd:30:46  */
  assign n1358 = n1356 == 20'b00100000000000000000;
  /* address_decoder.vhd:30:22  */
  assign n1359 = n1358 ? 1'b1 : 1'b0;
  /* address_decoder.vhd:31:22  */
  assign n1361 = addr[3:2]; // extract
  /* address_decoder.vhd:34:28  */
  assign n1364 = addr == 32'b01110000000000000000000000000000;
  /* address_decoder.vhd:34:18  */
  assign n1365 = n1364 ? 1'b1 : 1'b0;
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
  wire n858;
  wire n861;
  wire [1:0] n863;
  wire n864;
  wire [4:0] n866;
  wire [31:0] n868;
  wire n870;
  wire n872;
  wire n877;
  wire n878;
  wire n883;
  wire n886;
  wire n887;
  wire n890;
  wire n891;
  wire [31:0] n894;
  wire n896;
  wire [31:0] n897;
  wire [31:0] n899;
  wire [4:0] n900;
  wire [1:0] n902;
  wire [4:0] n903;
  wire n905;
  wire n910;
  wire n911;
  wire n912;
  wire n917;
  wire n918;
  wire n921;
  wire n922;
  wire n925;
  wire n926;
  wire n927;
  wire [31:0] n930;
  wire n932;
  wire [31:0] n933;
  wire [31:0] n935;
  wire [4:0] n936;
  wire [1:0] n938;
  wire [4:0] n939;
  wire [31:0] n940;
  wire n942;
  wire [31:0] n943;
  wire n945;
  wire [31:0] n946;
  wire n948;
  wire [4:0] n949;
  wire [30:0] n950;
  wire [31:0] n951;
  wire n953;
  wire [4:0] n954;
  wire [30:0] n955;
  wire [31:0] n956;
  wire n958;
  wire [4:0] n959;
  wire [30:0] n960;
  wire [31:0] n961;
  wire n963;
  wire n964;
  localparam [31:0] n966 = 32'b00000000000000000000000000000000;
  wire [30:0] n967;
  wire [31:0] n968;
  wire [31:0] n970;
  wire n972;
  wire n973;
  localparam [31:0] n975 = 32'b00000000000000000000000000000000;
  wire [30:0] n976;
  wire [31:0] n977;
  wire [31:0] n979;
  wire n981;
  wire [7:0] n982;
  reg [31:0] n984;
  wire [1:0] n986;
  wire n987;
  wire [4:0] n988;
  wire [31:0] n989;
  wire [1:0] n992;
  wire n993;
  wire [4:0] n994;
  wire [31:0] n995;
  wire n999;
  wire n1001;
  wire [2:0] n1002;
  reg n1006;
  reg [1:0] n1009;
  reg n1011;
  reg [4:0] n1013;
  reg [31:0] n1015;
  wire n1021;
  wire [1:0] n1023;
  wire n1025;
  wire [4:0] n1027;
  wire [31:0] n1029;
  wire n1044;
  wire n1045;
  reg [1:0] n1047;
  reg n1048;
  reg [4:0] n1049;
  reg [31:0] n1050;
  reg n1051;
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
  wire n1191;
  wire [31:0] n1192;
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
  wire n1332;
  wire [31:0] n1333;
  assign result = r; //(module output)
  assign zero = n1045; //(module output)
  assign done = n1051; //(module output)
  /* alu.vhd:21:12  */
  always @*
    state = n1047; // (isignal)
  initial
    state = 2'b00;
  /* alu.vhd:23:12  */
  always @*
    carry = n1048; // (isignal)
  initial
    carry = 1'b0;
  /* alu.vhd:24:12  */
  always @*
    bit_index = n1049; // (isignal)
  initial
    bit_index = 5'b00000;
  /* alu.vhd:26:12  */
  assign a = op_a; // (signal)
  /* alu.vhd:26:15  */
  assign b = op_b; // (signal)
  /* alu.vhd:27:12  */
  assign r = n1050; // (signal)
  /* alu.vhd:54:44  */
  assign n858 = alu_control == 4'b0001;
  /* alu.vhd:54:29  */
  assign n861 = n858 ? 1'b1 : 1'b0;
  /* alu.vhd:50:25  */
  assign n863 = start ? 2'b01 : state;
  /* alu.vhd:50:25  */
  assign n864 = start ? n861 : carry;
  /* alu.vhd:50:25  */
  assign n866 = start ? 5'b00000 : bit_index;
  /* alu.vhd:50:25  */
  assign n868 = start ? 32'b00000000000000000000000000000000 : r;
  /* alu.vhd:48:21  */
  assign n870 = state == 2'b00;
  /* alu.vhd:67:40  */
  assign n872 = alu_control == 4'b0000;
  /* alu.vhd:68:56  */
  assign n877 = n1052 ^ n1053;
  /* alu.vhd:68:73  */
  assign n878 = n877 ^ carry;
  /* alu.vhd:69:57  */
  assign n883 = n1054 & n1055;
  /* alu.vhd:70:57  */
  assign n886 = n1056 & carry;
  /* alu.vhd:69:75  */
  assign n887 = n883 | n886;
  /* alu.vhd:71:57  */
  assign n890 = n1057 & carry;
  /* alu.vhd:70:68  */
  assign n891 = n887 | n890;
  /* alu.vhd:76:42  */
  assign n894 = {27'b0, bit_index};  //  uext
  /* alu.vhd:76:42  */
  assign n896 = n894 == 32'b00000000000000000000000000011111;
  /* alu.vhd:79:56  */
  assign n897 = {27'b0, bit_index};  //  uext
  /* alu.vhd:79:56  */
  assign n899 = n897 + 32'b00000000000000000000000000000001;
  /* alu.vhd:79:46  */
  assign n900 = n899[4:0];  // trunc
  /* alu.vhd:76:29  */
  assign n902 = n896 ? 2'b10 : state;
  /* alu.vhd:76:29  */
  assign n903 = n896 ? bit_index : n900;
  /* alu.vhd:82:43  */
  assign n905 = alu_control == 4'b0001;
  /* alu.vhd:83:61  */
  assign n910 = ~n1194;
  /* alu.vhd:83:56  */
  assign n911 = n1193 ^ n910;
  /* alu.vhd:83:79  */
  assign n912 = n911 ^ carry;
  /* alu.vhd:84:62  */
  assign n917 = ~n1196;
  /* alu.vhd:84:57  */
  assign n918 = n1195 & n917;
  /* alu.vhd:85:57  */
  assign n921 = n1197 & carry;
  /* alu.vhd:84:81  */
  assign n922 = n918 | n921;
  /* alu.vhd:86:45  */
  assign n925 = ~n1198;
  /* alu.vhd:86:63  */
  assign n926 = n925 & carry;
  /* alu.vhd:85:68  */
  assign n927 = n922 | n926;
  /* alu.vhd:91:42  */
  assign n930 = {27'b0, bit_index};  //  uext
  /* alu.vhd:91:42  */
  assign n932 = n930 == 32'b00000000000000000000000000011111;
  /* alu.vhd:94:56  */
  assign n933 = {27'b0, bit_index};  //  uext
  /* alu.vhd:94:56  */
  assign n935 = n933 + 32'b00000000000000000000000000000001;
  /* alu.vhd:94:46  */
  assign n936 = n935[4:0];  // trunc
  /* alu.vhd:91:29  */
  assign n938 = n932 ? 2'b10 : state;
  /* alu.vhd:91:29  */
  assign n939 = n932 ? bit_index : n936;
  /* alu.vhd:101:44  */
  assign n940 = a & b;
  /* alu.vhd:100:33  */
  assign n942 = alu_control == 4'b0010;
  /* alu.vhd:103:44  */
  assign n943 = a | b;
  /* alu.vhd:102:33  */
  assign n945 = alu_control == 4'b0011;
  /* alu.vhd:105:44  */
  assign n946 = a ^ b;
  /* alu.vhd:104:33  */
  assign n948 = alu_control == 4'b0100;
  /* alu.vhd:107:80  */
  assign n949 = op_b[4:0]; // extract
  /* alu.vhd:107:56  */
  assign n950 = {26'b0, n949};  //  uext
  /* alu.vhd:107:42  */
  assign n951 = a << n950;
  /* alu.vhd:106:33  */
  assign n953 = alu_control == 4'b0101;
  /* alu.vhd:109:103  */
  assign n954 = op_b[4:0]; // extract
  /* alu.vhd:109:79  */
  assign n955 = {26'b0, n954};  //  uext
  /* alu.vhd:109:51  */
  assign n956 = op_a >> n955;
  /* alu.vhd:108:33  */
  assign n958 = alu_control == 4'b0110;
  /* alu.vhd:111:101  */
  assign n959 = op_b[4:0]; // extract
  /* alu.vhd:111:77  */
  assign n960 = {26'b0, n959};  //  uext
  /* alu.vhd:111:51  */
  assign n961 = $signed(op_a) >>> n960;
  /* alu.vhd:110:33  */
  assign n963 = alu_control == 4'b0111;
  /* alu.vhd:113:53  */
  assign n964 = $signed(op_a) < $signed(op_b);
  assign n967 = n966[31:1]; // extract
  assign n968 = {n967, 1'b1};
  /* alu.vhd:113:37  */
  assign n970 = n964 ? n968 : 32'b00000000000000000000000000000000;
  /* alu.vhd:112:33  */
  assign n972 = alu_control == 4'b1000;
  /* alu.vhd:119:55  */
  assign n973 = $unsigned(op_a) < $unsigned(op_b);
  assign n976 = n975[31:1]; // extract
  assign n977 = {n976, 1'b1};
  /* alu.vhd:119:37  */
  assign n979 = n973 ? n977 : 32'b00000000000000000000000000000000;
  /* alu.vhd:118:33  */
  assign n981 = alu_control == 4'b1001;
  assign n982 = {n981, n972, n963, n958, n953, n948, n945, n942};
  /* alu.vhd:99:29  */
  always @*
    case (n982)
      8'b10000000: n984 = n979;
      8'b01000000: n984 = n970;
      8'b00100000: n984 = n961;
      8'b00010000: n984 = n956;
      8'b00001000: n984 = n951;
      8'b00000100: n984 = n946;
      8'b00000010: n984 = n943;
      8'b00000001: n984 = n940;
      default: n984 = 32'b00000000000000000000000000000000;
    endcase
  /* alu.vhd:82:25  */
  assign n986 = n905 ? n938 : 2'b10;
  /* alu.vhd:82:25  */
  assign n987 = n905 ? n927 : carry;
  /* alu.vhd:82:25  */
  assign n988 = n905 ? n939 : bit_index;
  /* alu.vhd:82:25  */
  assign n989 = n905 ? n1333 : n984;
  /* alu.vhd:67:25  */
  assign n992 = n872 ? n902 : n986;
  /* alu.vhd:67:25  */
  assign n993 = n872 ? n891 : n987;
  /* alu.vhd:67:25  */
  assign n994 = n872 ? n903 : n988;
  /* alu.vhd:67:25  */
  assign n995 = n872 ? n1192 : n989;
  /* alu.vhd:66:21  */
  assign n999 = state == 2'b01;
  /* alu.vhd:134:21  */
  assign n1001 = state == 2'b10;
  assign n1002 = {n1001, n999, n870};
  /* alu.vhd:44:17  */
  always @*
    case (n1002)
      3'b100: n1006 = 1'b1;
      3'b010: n1006 = n1051;
      3'b001: n1006 = 1'b0;
      default: n1006 = 1'bX;
    endcase
  /* alu.vhd:44:17  */
  always @*
    case (n1002)
      3'b100: n1009 = 2'b00;
      3'b010: n1009 = n992;
      3'b001: n1009 = n863;
      default: n1009 = 2'bX;
    endcase
  /* alu.vhd:44:17  */
  always @*
    case (n1002)
      3'b100: n1011 = carry;
      3'b010: n1011 = n993;
      3'b001: n1011 = n864;
      default: n1011 = 1'bX;
    endcase
  /* alu.vhd:44:17  */
  always @*
    case (n1002)
      3'b100: n1013 = bit_index;
      3'b010: n1013 = n994;
      3'b001: n1013 = n866;
      default: n1013 = 5'bX;
    endcase
  /* alu.vhd:44:17  */
  always @*
    case (n1002)
      3'b100: n1015 = r;
      3'b010: n1015 = n995;
      3'b001: n1015 = n868;
      default: n1015 = 32'bX;
    endcase
  /* alu.vhd:37:13  */
  assign n1021 = reset ? 1'b0 : n1006;
  /* alu.vhd:37:13  */
  assign n1023 = reset ? 2'b00 : n1009;
  /* alu.vhd:37:13  */
  assign n1025 = reset ? 1'b0 : n1011;
  /* alu.vhd:37:13  */
  assign n1027 = reset ? 5'b00000 : n1013;
  /* alu.vhd:37:13  */
  assign n1029 = reset ? 32'b00000000000000000000000000000000 : n1015;
  /* alu.vhd:143:26  */
  assign n1044 = r == 32'b00000000000000000000000000000000;
  /* alu.vhd:143:19  */
  assign n1045 = n1044 ? 1'b1 : 1'b0;
  /* alu.vhd:36:9  */
  always @(posedge clk)
    n1047 <= n1023;
  initial
    n1047 = 2'b00;
  /* alu.vhd:36:9  */
  always @(posedge clk)
    n1048 <= n1025;
  initial
    n1048 = 1'b0;
  /* alu.vhd:36:9  */
  always @(posedge clk)
    n1049 <= n1027;
  initial
    n1049 = 5'b00000;
  /* alu.vhd:36:9  */
  always @(posedge clk)
    n1050 <= n1029;
  /* alu.vhd:36:9  */
  always @(posedge clk)
    n1051 <= n1021;
  /* alu.vhd:68:45  */
  assign n1052 = a[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:68:62  */
  assign n1053 = b[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:69:46  */
  assign n1054 = a[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:69:63  */
  assign n1055 = b[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:70:46  */
  assign n1056 = a[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:71:46  */
  assign n1057 = b[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:73:29  */
  assign n1058 = bit_index[4]; // extract
  /* alu.vhd:73:29  */
  assign n1059 = ~n1058;
  /* alu.vhd:73:29  */
  assign n1060 = bit_index[3]; // extract
  /* alu.vhd:73:29  */
  assign n1061 = ~n1060;
  /* alu.vhd:73:29  */
  assign n1062 = n1059 & n1061;
  /* alu.vhd:73:29  */
  assign n1063 = n1059 & n1060;
  /* alu.vhd:73:29  */
  assign n1064 = n1058 & n1061;
  /* alu.vhd:73:29  */
  assign n1065 = n1058 & n1060;
  /* alu.vhd:73:29  */
  assign n1066 = bit_index[2]; // extract
  /* alu.vhd:73:29  */
  assign n1067 = ~n1066;
  /* alu.vhd:73:29  */
  assign n1068 = n1062 & n1067;
  /* alu.vhd:73:29  */
  assign n1069 = n1062 & n1066;
  /* alu.vhd:73:29  */
  assign n1070 = n1063 & n1067;
  /* alu.vhd:73:29  */
  assign n1071 = n1063 & n1066;
  /* alu.vhd:73:29  */
  assign n1072 = n1064 & n1067;
  /* alu.vhd:73:29  */
  assign n1073 = n1064 & n1066;
  /* alu.vhd:73:29  */
  assign n1074 = n1065 & n1067;
  /* alu.vhd:73:29  */
  assign n1075 = n1065 & n1066;
  /* alu.vhd:73:29  */
  assign n1076 = bit_index[1]; // extract
  /* alu.vhd:73:29  */
  assign n1077 = ~n1076;
  /* alu.vhd:73:29  */
  assign n1078 = n1068 & n1077;
  /* alu.vhd:73:29  */
  assign n1079 = n1068 & n1076;
  /* alu.vhd:73:29  */
  assign n1080 = n1069 & n1077;
  /* alu.vhd:73:29  */
  assign n1081 = n1069 & n1076;
  /* alu.vhd:73:29  */
  assign n1082 = n1070 & n1077;
  /* alu.vhd:73:29  */
  assign n1083 = n1070 & n1076;
  /* alu.vhd:73:29  */
  assign n1084 = n1071 & n1077;
  /* alu.vhd:73:29  */
  assign n1085 = n1071 & n1076;
  /* alu.vhd:73:29  */
  assign n1086 = n1072 & n1077;
  /* alu.vhd:73:29  */
  assign n1087 = n1072 & n1076;
  /* alu.vhd:73:29  */
  assign n1088 = n1073 & n1077;
  /* alu.vhd:73:29  */
  assign n1089 = n1073 & n1076;
  /* alu.vhd:73:29  */
  assign n1090 = n1074 & n1077;
  /* alu.vhd:73:29  */
  assign n1091 = n1074 & n1076;
  /* alu.vhd:73:29  */
  assign n1092 = n1075 & n1077;
  /* alu.vhd:73:29  */
  assign n1093 = n1075 & n1076;
  /* alu.vhd:73:29  */
  assign n1094 = bit_index[0]; // extract
  /* alu.vhd:73:29  */
  assign n1095 = ~n1094;
  /* alu.vhd:73:29  */
  assign n1096 = n1078 & n1095;
  /* alu.vhd:73:29  */
  assign n1097 = n1078 & n1094;
  /* alu.vhd:73:29  */
  assign n1098 = n1079 & n1095;
  /* alu.vhd:73:29  */
  assign n1099 = n1079 & n1094;
  /* alu.vhd:73:29  */
  assign n1100 = n1080 & n1095;
  /* alu.vhd:73:29  */
  assign n1101 = n1080 & n1094;
  /* alu.vhd:73:29  */
  assign n1102 = n1081 & n1095;
  /* alu.vhd:73:29  */
  assign n1103 = n1081 & n1094;
  /* alu.vhd:73:29  */
  assign n1104 = n1082 & n1095;
  /* alu.vhd:73:29  */
  assign n1105 = n1082 & n1094;
  /* alu.vhd:73:29  */
  assign n1106 = n1083 & n1095;
  /* alu.vhd:73:29  */
  assign n1107 = n1083 & n1094;
  /* alu.vhd:73:29  */
  assign n1108 = n1084 & n1095;
  /* alu.vhd:73:29  */
  assign n1109 = n1084 & n1094;
  /* alu.vhd:73:29  */
  assign n1110 = n1085 & n1095;
  /* alu.vhd:73:29  */
  assign n1111 = n1085 & n1094;
  /* alu.vhd:73:29  */
  assign n1112 = n1086 & n1095;
  /* alu.vhd:73:29  */
  assign n1113 = n1086 & n1094;
  /* alu.vhd:73:29  */
  assign n1114 = n1087 & n1095;
  /* alu.vhd:73:29  */
  assign n1115 = n1087 & n1094;
  /* alu.vhd:73:29  */
  assign n1116 = n1088 & n1095;
  /* alu.vhd:73:29  */
  assign n1117 = n1088 & n1094;
  /* alu.vhd:73:29  */
  assign n1118 = n1089 & n1095;
  /* alu.vhd:73:29  */
  assign n1119 = n1089 & n1094;
  /* alu.vhd:73:29  */
  assign n1120 = n1090 & n1095;
  /* alu.vhd:73:29  */
  assign n1121 = n1090 & n1094;
  /* alu.vhd:73:29  */
  assign n1122 = n1091 & n1095;
  /* alu.vhd:73:29  */
  assign n1123 = n1091 & n1094;
  /* alu.vhd:73:29  */
  assign n1124 = n1092 & n1095;
  /* alu.vhd:73:29  */
  assign n1125 = n1092 & n1094;
  /* alu.vhd:73:29  */
  assign n1126 = n1093 & n1095;
  /* alu.vhd:73:29  */
  assign n1127 = n1093 & n1094;
  assign n1128 = r[0]; // extract
  /* alu.vhd:73:29  */
  assign n1129 = n1096 ? n878 : n1128;
  assign n1130 = r[1]; // extract
  /* alu.vhd:73:29  */
  assign n1131 = n1097 ? n878 : n1130;
  assign n1132 = r[2]; // extract
  /* alu.vhd:73:29  */
  assign n1133 = n1098 ? n878 : n1132;
  assign n1134 = r[3]; // extract
  /* alu.vhd:73:29  */
  assign n1135 = n1099 ? n878 : n1134;
  assign n1136 = r[4]; // extract
  /* alu.vhd:73:29  */
  assign n1137 = n1100 ? n878 : n1136;
  assign n1138 = r[5]; // extract
  /* alu.vhd:73:29  */
  assign n1139 = n1101 ? n878 : n1138;
  assign n1140 = r[6]; // extract
  /* alu.vhd:73:29  */
  assign n1141 = n1102 ? n878 : n1140;
  assign n1142 = r[7]; // extract
  /* alu.vhd:73:29  */
  assign n1143 = n1103 ? n878 : n1142;
  assign n1144 = r[8]; // extract
  /* alu.vhd:73:29  */
  assign n1145 = n1104 ? n878 : n1144;
  assign n1146 = r[9]; // extract
  /* alu.vhd:73:29  */
  assign n1147 = n1105 ? n878 : n1146;
  assign n1148 = r[10]; // extract
  /* alu.vhd:73:29  */
  assign n1149 = n1106 ? n878 : n1148;
  assign n1150 = r[11]; // extract
  /* alu.vhd:73:29  */
  assign n1151 = n1107 ? n878 : n1150;
  assign n1152 = r[12]; // extract
  /* alu.vhd:73:29  */
  assign n1153 = n1108 ? n878 : n1152;
  assign n1154 = r[13]; // extract
  /* alu.vhd:73:29  */
  assign n1155 = n1109 ? n878 : n1154;
  assign n1156 = r[14]; // extract
  /* alu.vhd:73:29  */
  assign n1157 = n1110 ? n878 : n1156;
  assign n1158 = r[15]; // extract
  /* alu.vhd:73:29  */
  assign n1159 = n1111 ? n878 : n1158;
  assign n1160 = r[16]; // extract
  /* alu.vhd:73:29  */
  assign n1161 = n1112 ? n878 : n1160;
  assign n1162 = r[17]; // extract
  /* alu.vhd:73:29  */
  assign n1163 = n1113 ? n878 : n1162;
  assign n1164 = r[18]; // extract
  /* alu.vhd:73:29  */
  assign n1165 = n1114 ? n878 : n1164;
  assign n1166 = r[19]; // extract
  /* alu.vhd:73:29  */
  assign n1167 = n1115 ? n878 : n1166;
  assign n1168 = r[20]; // extract
  /* alu.vhd:73:29  */
  assign n1169 = n1116 ? n878 : n1168;
  assign n1170 = r[21]; // extract
  /* alu.vhd:73:29  */
  assign n1171 = n1117 ? n878 : n1170;
  assign n1172 = r[22]; // extract
  /* alu.vhd:73:29  */
  assign n1173 = n1118 ? n878 : n1172;
  assign n1174 = r[23]; // extract
  /* alu.vhd:73:29  */
  assign n1175 = n1119 ? n878 : n1174;
  assign n1176 = r[24]; // extract
  /* alu.vhd:73:29  */
  assign n1177 = n1120 ? n878 : n1176;
  assign n1178 = r[25]; // extract
  /* alu.vhd:73:29  */
  assign n1179 = n1121 ? n878 : n1178;
  assign n1180 = r[26]; // extract
  /* alu.vhd:73:29  */
  assign n1181 = n1122 ? n878 : n1180;
  assign n1182 = r[27]; // extract
  /* alu.vhd:73:29  */
  assign n1183 = n1123 ? n878 : n1182;
  assign n1184 = r[28]; // extract
  /* alu.vhd:73:29  */
  assign n1185 = n1124 ? n878 : n1184;
  assign n1186 = r[29]; // extract
  /* alu.vhd:73:29  */
  assign n1187 = n1125 ? n878 : n1186;
  assign n1188 = r[30]; // extract
  /* alu.vhd:73:29  */
  assign n1189 = n1126 ? n878 : n1188;
  assign n1190 = r[31]; // extract
  /* alu.vhd:73:29  */
  assign n1191 = n1127 ? n878 : n1190;
  assign n1192 = {n1191, n1189, n1187, n1185, n1183, n1181, n1179, n1177, n1175, n1173, n1171, n1169, n1167, n1165, n1163, n1161, n1159, n1157, n1155, n1153, n1151, n1149, n1147, n1145, n1143, n1141, n1139, n1137, n1135, n1133, n1131, n1129};
  /* alu.vhd:83:45  */
  assign n1193 = a[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:83:67  */
  assign n1194 = b[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:84:46  */
  assign n1195 = a[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:84:68  */
  assign n1196 = b[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:85:46  */
  assign n1197 = a[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:86:51  */
  assign n1198 = b[bit_index * 1 +: 1]; //(Bmux)
  /* alu.vhd:88:29  */
  assign n1199 = bit_index[4]; // extract
  /* alu.vhd:88:29  */
  assign n1200 = ~n1199;
  /* alu.vhd:88:29  */
  assign n1201 = bit_index[3]; // extract
  /* alu.vhd:88:29  */
  assign n1202 = ~n1201;
  /* alu.vhd:88:29  */
  assign n1203 = n1200 & n1202;
  /* alu.vhd:88:29  */
  assign n1204 = n1200 & n1201;
  /* alu.vhd:88:29  */
  assign n1205 = n1199 & n1202;
  /* alu.vhd:88:29  */
  assign n1206 = n1199 & n1201;
  /* alu.vhd:88:29  */
  assign n1207 = bit_index[2]; // extract
  /* alu.vhd:88:29  */
  assign n1208 = ~n1207;
  /* alu.vhd:88:29  */
  assign n1209 = n1203 & n1208;
  /* alu.vhd:88:29  */
  assign n1210 = n1203 & n1207;
  /* alu.vhd:88:29  */
  assign n1211 = n1204 & n1208;
  /* alu.vhd:88:29  */
  assign n1212 = n1204 & n1207;
  /* alu.vhd:88:29  */
  assign n1213 = n1205 & n1208;
  /* alu.vhd:88:29  */
  assign n1214 = n1205 & n1207;
  /* alu.vhd:88:29  */
  assign n1215 = n1206 & n1208;
  /* alu.vhd:88:29  */
  assign n1216 = n1206 & n1207;
  /* alu.vhd:88:29  */
  assign n1217 = bit_index[1]; // extract
  /* alu.vhd:88:29  */
  assign n1218 = ~n1217;
  /* alu.vhd:88:29  */
  assign n1219 = n1209 & n1218;
  /* alu.vhd:88:29  */
  assign n1220 = n1209 & n1217;
  /* alu.vhd:88:29  */
  assign n1221 = n1210 & n1218;
  /* alu.vhd:88:29  */
  assign n1222 = n1210 & n1217;
  /* alu.vhd:88:29  */
  assign n1223 = n1211 & n1218;
  /* alu.vhd:88:29  */
  assign n1224 = n1211 & n1217;
  /* alu.vhd:88:29  */
  assign n1225 = n1212 & n1218;
  /* alu.vhd:88:29  */
  assign n1226 = n1212 & n1217;
  /* alu.vhd:88:29  */
  assign n1227 = n1213 & n1218;
  /* alu.vhd:88:29  */
  assign n1228 = n1213 & n1217;
  /* alu.vhd:88:29  */
  assign n1229 = n1214 & n1218;
  /* alu.vhd:88:29  */
  assign n1230 = n1214 & n1217;
  /* alu.vhd:88:29  */
  assign n1231 = n1215 & n1218;
  /* alu.vhd:88:29  */
  assign n1232 = n1215 & n1217;
  /* alu.vhd:88:29  */
  assign n1233 = n1216 & n1218;
  /* alu.vhd:88:29  */
  assign n1234 = n1216 & n1217;
  /* alu.vhd:88:29  */
  assign n1235 = bit_index[0]; // extract
  /* alu.vhd:88:29  */
  assign n1236 = ~n1235;
  /* alu.vhd:88:29  */
  assign n1237 = n1219 & n1236;
  /* alu.vhd:88:29  */
  assign n1238 = n1219 & n1235;
  /* alu.vhd:88:29  */
  assign n1239 = n1220 & n1236;
  /* alu.vhd:88:29  */
  assign n1240 = n1220 & n1235;
  /* alu.vhd:88:29  */
  assign n1241 = n1221 & n1236;
  /* alu.vhd:88:29  */
  assign n1242 = n1221 & n1235;
  /* alu.vhd:88:29  */
  assign n1243 = n1222 & n1236;
  /* alu.vhd:88:29  */
  assign n1244 = n1222 & n1235;
  /* alu.vhd:88:29  */
  assign n1245 = n1223 & n1236;
  /* alu.vhd:88:29  */
  assign n1246 = n1223 & n1235;
  /* alu.vhd:88:29  */
  assign n1247 = n1224 & n1236;
  /* alu.vhd:88:29  */
  assign n1248 = n1224 & n1235;
  /* alu.vhd:88:29  */
  assign n1249 = n1225 & n1236;
  /* alu.vhd:88:29  */
  assign n1250 = n1225 & n1235;
  /* alu.vhd:88:29  */
  assign n1251 = n1226 & n1236;
  /* alu.vhd:88:29  */
  assign n1252 = n1226 & n1235;
  /* alu.vhd:88:29  */
  assign n1253 = n1227 & n1236;
  /* alu.vhd:88:29  */
  assign n1254 = n1227 & n1235;
  /* alu.vhd:88:29  */
  assign n1255 = n1228 & n1236;
  /* alu.vhd:88:29  */
  assign n1256 = n1228 & n1235;
  /* alu.vhd:88:29  */
  assign n1257 = n1229 & n1236;
  /* alu.vhd:88:29  */
  assign n1258 = n1229 & n1235;
  /* alu.vhd:88:29  */
  assign n1259 = n1230 & n1236;
  /* alu.vhd:88:29  */
  assign n1260 = n1230 & n1235;
  /* alu.vhd:88:29  */
  assign n1261 = n1231 & n1236;
  /* alu.vhd:88:29  */
  assign n1262 = n1231 & n1235;
  /* alu.vhd:88:29  */
  assign n1263 = n1232 & n1236;
  /* alu.vhd:88:29  */
  assign n1264 = n1232 & n1235;
  /* alu.vhd:88:29  */
  assign n1265 = n1233 & n1236;
  /* alu.vhd:88:29  */
  assign n1266 = n1233 & n1235;
  /* alu.vhd:88:29  */
  assign n1267 = n1234 & n1236;
  /* alu.vhd:88:29  */
  assign n1268 = n1234 & n1235;
  assign n1269 = r[0]; // extract
  /* alu.vhd:88:29  */
  assign n1270 = n1237 ? n912 : n1269;
  assign n1271 = r[1]; // extract
  /* alu.vhd:88:29  */
  assign n1272 = n1238 ? n912 : n1271;
  assign n1273 = r[2]; // extract
  /* alu.vhd:88:29  */
  assign n1274 = n1239 ? n912 : n1273;
  assign n1275 = r[3]; // extract
  /* alu.vhd:88:29  */
  assign n1276 = n1240 ? n912 : n1275;
  assign n1277 = r[4]; // extract
  /* alu.vhd:88:29  */
  assign n1278 = n1241 ? n912 : n1277;
  assign n1279 = r[5]; // extract
  /* alu.vhd:88:29  */
  assign n1280 = n1242 ? n912 : n1279;
  assign n1281 = r[6]; // extract
  /* alu.vhd:88:29  */
  assign n1282 = n1243 ? n912 : n1281;
  assign n1283 = r[7]; // extract
  /* alu.vhd:88:29  */
  assign n1284 = n1244 ? n912 : n1283;
  assign n1285 = r[8]; // extract
  /* alu.vhd:88:29  */
  assign n1286 = n1245 ? n912 : n1285;
  assign n1287 = r[9]; // extract
  /* alu.vhd:88:29  */
  assign n1288 = n1246 ? n912 : n1287;
  assign n1289 = r[10]; // extract
  /* alu.vhd:88:29  */
  assign n1290 = n1247 ? n912 : n1289;
  assign n1291 = r[11]; // extract
  /* alu.vhd:88:29  */
  assign n1292 = n1248 ? n912 : n1291;
  assign n1293 = r[12]; // extract
  /* alu.vhd:88:29  */
  assign n1294 = n1249 ? n912 : n1293;
  assign n1295 = r[13]; // extract
  /* alu.vhd:88:29  */
  assign n1296 = n1250 ? n912 : n1295;
  assign n1297 = r[14]; // extract
  /* alu.vhd:88:29  */
  assign n1298 = n1251 ? n912 : n1297;
  assign n1299 = r[15]; // extract
  /* alu.vhd:88:29  */
  assign n1300 = n1252 ? n912 : n1299;
  assign n1301 = r[16]; // extract
  /* alu.vhd:88:29  */
  assign n1302 = n1253 ? n912 : n1301;
  assign n1303 = r[17]; // extract
  /* alu.vhd:88:29  */
  assign n1304 = n1254 ? n912 : n1303;
  assign n1305 = r[18]; // extract
  /* alu.vhd:88:29  */
  assign n1306 = n1255 ? n912 : n1305;
  assign n1307 = r[19]; // extract
  /* alu.vhd:88:29  */
  assign n1308 = n1256 ? n912 : n1307;
  assign n1309 = r[20]; // extract
  /* alu.vhd:88:29  */
  assign n1310 = n1257 ? n912 : n1309;
  assign n1311 = r[21]; // extract
  /* alu.vhd:88:29  */
  assign n1312 = n1258 ? n912 : n1311;
  assign n1313 = r[22]; // extract
  /* alu.vhd:88:29  */
  assign n1314 = n1259 ? n912 : n1313;
  assign n1315 = r[23]; // extract
  /* alu.vhd:88:29  */
  assign n1316 = n1260 ? n912 : n1315;
  assign n1317 = r[24]; // extract
  /* alu.vhd:88:29  */
  assign n1318 = n1261 ? n912 : n1317;
  assign n1319 = r[25]; // extract
  /* alu.vhd:88:29  */
  assign n1320 = n1262 ? n912 : n1319;
  assign n1321 = r[26]; // extract
  /* alu.vhd:88:29  */
  assign n1322 = n1263 ? n912 : n1321;
  assign n1323 = r[27]; // extract
  /* alu.vhd:88:29  */
  assign n1324 = n1264 ? n912 : n1323;
  assign n1325 = r[28]; // extract
  /* alu.vhd:88:29  */
  assign n1326 = n1265 ? n912 : n1325;
  assign n1327 = r[29]; // extract
  /* alu.vhd:88:29  */
  assign n1328 = n1266 ? n912 : n1327;
  assign n1329 = r[30]; // extract
  /* alu.vhd:88:29  */
  assign n1330 = n1267 ? n912 : n1329;
  assign n1331 = r[31]; // extract
  /* alu.vhd:88:29  */
  assign n1332 = n1268 ? n912 : n1331;
  assign n1333 = {n1332, n1330, n1328, n1326, n1324, n1322, n1320, n1318, n1316, n1314, n1312, n1310, n1308, n1306, n1304, n1302, n1300, n1298, n1296, n1294, n1292, n1290, n1288, n1286, n1284, n1282, n1280, n1278, n1276, n1274, n1272, n1270};
endmodule

module mux_b
  (input  clk,
   input  sel,
   input  [31:0] rs2,
   input  [31:0] imm,
   output [31:0] result);
  wire [31:0] result_next;
  wire [31:0] result_reg;
  wire n838;
  wire [31:0] n839;
  reg [31:0] n845;
  assign result = result_reg; //(module output)
  /* mux_b.vhd:16:12  */
  assign result_next = n839; // (signal)
  /* mux_b.vhd:17:12  */
  assign result_reg = n845; // (signal)
  /* mux_b.vhd:20:33  */
  assign n838 = ~sel;
  /* mux_b.vhd:20:24  */
  assign n839 = n838 ? rs2 : imm;
  /* mux_b.vhd:25:9  */
  always @(posedge clk)
    n845 <= result_next;
endmodule

module mux_a
  (input  clk,
   input  [1:0] sel,
   input  [31:0] rs1,
   input  [31:0] pc,
   output [31:0] result);
  wire [31:0] result_next;
  wire [31:0] result_reg;
  wire n822;
  wire n824;
  wire n826;
  wire [2:0] n827;
  reg [31:0] n829;
  reg [31:0] n836;
  assign result = result_reg; //(module output)
  /* mux_a.vhd:16:12  */
  assign result_next = n829; // (signal)
  /* mux_a.vhd:17:12  */
  assign result_reg = n836; // (signal)
  /* mux_a.vhd:23:13  */
  assign n822 = sel == 2'b00;
  /* mux_a.vhd:24:13  */
  assign n824 = sel == 2'b01;
  /* mux_a.vhd:25:13  */
  assign n826 = sel == 2'b10;
  assign n827 = {n826, n824, n822};
  /* mux_a.vhd:22:9  */
  always @*
    case (n827)
      3'b100: n829 = 32'b00000000000000000000000000000000;
      3'b010: n829 = pc;
      3'b001: n829 = rs1;
      default: n829 = rs1;
    endcase
  /* mux_a.vhd:33:9  */
  always @(posedge clk)
    n836 <= result_next;
endmodule

module imm_gen
  (input  [31:0] instr,
   input  [2:0] imm_type,
   output [31:0] imm_out);
  wire [31:0] imm;
  wire [11:0] n775;
  wire [31:0] n776;
  wire n778;
  wire [6:0] n779;
  wire [4:0] n780;
  wire [11:0] n781;
  wire [31:0] n782;
  wire n784;
  wire n785;
  wire n786;
  wire [1:0] n787;
  wire [5:0] n788;
  wire [7:0] n789;
  wire [3:0] n790;
  wire [11:0] n791;
  wire [12:0] n793;
  wire [31:0] n794;
  wire n796;
  wire [19:0] n797;
  wire [31:0] n799;
  wire n801;
  wire n802;
  wire [7:0] n803;
  wire [8:0] n804;
  wire n805;
  wire [9:0] n806;
  wire [9:0] n807;
  wire [19:0] n808;
  wire [20:0] n810;
  wire [31:0] n811;
  wire n813;
  wire [4:0] n814;
  reg [31:0] n816;
  assign imm_out = imm; //(module output)
  /* imm_gen.vhd:14:12  */
  assign imm = n816; // (signal)
  /* imm_gen.vhd:20:43  */
  assign n775 = instr[31:20]; // extract
  /* imm_gen.vhd:20:24  */
  assign n776 = {{20{n775[11]}}, n775}; // sext
  /* imm_gen.vhd:19:13  */
  assign n778 = imm_type == 3'b000;
  /* imm_gen.vhd:23:43  */
  assign n779 = instr[31:25]; // extract
  /* imm_gen.vhd:23:65  */
  assign n780 = instr[11:7]; // extract
  /* imm_gen.vhd:23:58  */
  assign n781 = {n779, n780};
  /* imm_gen.vhd:23:24  */
  assign n782 = {{20{n781[11]}}, n781}; // sext
  /* imm_gen.vhd:22:13  */
  assign n784 = imm_type == 3'b001;
  /* imm_gen.vhd:27:33  */
  assign n785 = instr[31]; // extract
  /* imm_gen.vhd:27:45  */
  assign n786 = instr[7]; // extract
  /* imm_gen.vhd:27:38  */
  assign n787 = {n785, n786};
  /* imm_gen.vhd:27:56  */
  assign n788 = instr[30:25]; // extract
  /* imm_gen.vhd:27:49  */
  assign n789 = {n787, n788};
  /* imm_gen.vhd:27:78  */
  assign n790 = instr[11:8]; // extract
  /* imm_gen.vhd:27:71  */
  assign n791 = {n789, n790};
  /* imm_gen.vhd:27:92  */
  assign n793 = {n791, 1'b0};
  /* imm_gen.vhd:26:24  */
  assign n794 = {{19{n793[12]}}, n793}; // sext
  /* imm_gen.vhd:25:13  */
  assign n796 = imm_type == 3'b010;
  /* imm_gen.vhd:32:36  */
  assign n797 = instr[31:12]; // extract
  /* imm_gen.vhd:32:51  */
  assign n799 = {n797, 12'b000000000000};
  /* imm_gen.vhd:31:13  */
  assign n801 = imm_type == 3'b011;
  /* imm_gen.vhd:36:33  */
  assign n802 = instr[31]; // extract
  /* imm_gen.vhd:36:45  */
  assign n803 = instr[19:12]; // extract
  /* imm_gen.vhd:36:38  */
  assign n804 = {n802, n803};
  /* imm_gen.vhd:36:67  */
  assign n805 = instr[20]; // extract
  /* imm_gen.vhd:36:60  */
  assign n806 = {n804, n805};
  /* imm_gen.vhd:36:79  */
  assign n807 = instr[30:21]; // extract
  /* imm_gen.vhd:36:72  */
  assign n808 = {n806, n807};
  /* imm_gen.vhd:36:94  */
  assign n810 = {n808, 1'b0};
  /* imm_gen.vhd:35:24  */
  assign n811 = {{11{n810[20]}}, n810}; // sext
  /* imm_gen.vhd:34:13  */
  assign n813 = imm_type == 3'b100;
  assign n814 = {n813, n801, n796, n784, n778};
  /* imm_gen.vhd:18:9  */
  always @*
    case (n814)
      5'b10000: n816 = n811;
      5'b01000: n816 = n799;
      5'b00100: n816 = n794;
      5'b00010: n816 = n782;
      5'b00001: n816 = n776;
      default: n816 = 32'b00000000000000000000000000000000;
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
  wire n543;
  wire n544;
  wire \gen_regfiles_n1_regfile_inst.AD0 ;
  wire \gen_regfiles_n1_regfile_inst.AD1 ;
  wire \gen_regfiles_n1_regfile_inst.AD2 ;
  wire \gen_regfiles_n1_regfile_inst.AD3 ;
  wire \gen_regfiles_n1_regfile_inst.BD0 ;
  wire \gen_regfiles_n1_regfile_inst.BD1 ;
  wire \gen_regfiles_n1_regfile_inst.BD2 ;
  wire \gen_regfiles_n1_regfile_inst.BD3 ;
  wire n546;
  wire n547;
  wire n548;
  wire n549;
  wire n550;
  wire n551;
  wire n552;
  wire n553;
  wire n554;
  wire n559;
  wire n560;
  wire n561;
  wire n562;
  wire n563;
  wire n568;
  wire n569;
  wire n570;
  wire n571;
  wire n572;
  wire \gen_regfiles_n2_regfile_inst.AD0 ;
  wire \gen_regfiles_n2_regfile_inst.AD1 ;
  wire \gen_regfiles_n2_regfile_inst.AD2 ;
  wire \gen_regfiles_n2_regfile_inst.AD3 ;
  wire \gen_regfiles_n2_regfile_inst.BD0 ;
  wire \gen_regfiles_n2_regfile_inst.BD1 ;
  wire \gen_regfiles_n2_regfile_inst.BD2 ;
  wire \gen_regfiles_n2_regfile_inst.BD3 ;
  wire n573;
  wire n574;
  wire n575;
  wire n576;
  wire n577;
  wire n578;
  wire n579;
  wire n580;
  wire n581;
  wire n586;
  wire n587;
  wire n588;
  wire n589;
  wire n590;
  wire n595;
  wire n596;
  wire n597;
  wire n598;
  wire n599;
  wire \gen_regfiles_n3_regfile_inst.AD0 ;
  wire \gen_regfiles_n3_regfile_inst.AD1 ;
  wire \gen_regfiles_n3_regfile_inst.AD2 ;
  wire \gen_regfiles_n3_regfile_inst.AD3 ;
  wire \gen_regfiles_n3_regfile_inst.BD0 ;
  wire \gen_regfiles_n3_regfile_inst.BD1 ;
  wire \gen_regfiles_n3_regfile_inst.BD2 ;
  wire \gen_regfiles_n3_regfile_inst.BD3 ;
  wire n600;
  wire n601;
  wire n602;
  wire n603;
  wire n604;
  wire n605;
  wire n606;
  wire n607;
  wire n608;
  wire n613;
  wire n614;
  wire n615;
  wire n616;
  wire n617;
  wire n622;
  wire n623;
  wire n624;
  wire n625;
  wire n626;
  wire \gen_regfiles_n4_regfile_inst.AD0 ;
  wire \gen_regfiles_n4_regfile_inst.AD1 ;
  wire \gen_regfiles_n4_regfile_inst.AD2 ;
  wire \gen_regfiles_n4_regfile_inst.AD3 ;
  wire \gen_regfiles_n4_regfile_inst.BD0 ;
  wire \gen_regfiles_n4_regfile_inst.BD1 ;
  wire \gen_regfiles_n4_regfile_inst.BD2 ;
  wire \gen_regfiles_n4_regfile_inst.BD3 ;
  wire n627;
  wire n628;
  wire n629;
  wire n630;
  wire n631;
  wire n632;
  wire n633;
  wire n634;
  wire n635;
  wire n640;
  wire n641;
  wire n642;
  wire n643;
  wire n644;
  wire n649;
  wire n650;
  wire n651;
  wire n652;
  wire n653;
  wire \gen_regfiles_n5_regfile_inst.AD0 ;
  wire \gen_regfiles_n5_regfile_inst.AD1 ;
  wire \gen_regfiles_n5_regfile_inst.AD2 ;
  wire \gen_regfiles_n5_regfile_inst.AD3 ;
  wire \gen_regfiles_n5_regfile_inst.BD0 ;
  wire \gen_regfiles_n5_regfile_inst.BD1 ;
  wire \gen_regfiles_n5_regfile_inst.BD2 ;
  wire \gen_regfiles_n5_regfile_inst.BD3 ;
  wire n654;
  wire n655;
  wire n656;
  wire n657;
  wire n658;
  wire n659;
  wire n660;
  wire n661;
  wire n662;
  wire n667;
  wire n668;
  wire n669;
  wire n670;
  wire n671;
  wire n676;
  wire n677;
  wire n678;
  wire n679;
  wire n680;
  wire \gen_regfiles_n6_regfile_inst.AD0 ;
  wire \gen_regfiles_n6_regfile_inst.AD1 ;
  wire \gen_regfiles_n6_regfile_inst.AD2 ;
  wire \gen_regfiles_n6_regfile_inst.AD3 ;
  wire \gen_regfiles_n6_regfile_inst.BD0 ;
  wire \gen_regfiles_n6_regfile_inst.BD1 ;
  wire \gen_regfiles_n6_regfile_inst.BD2 ;
  wire \gen_regfiles_n6_regfile_inst.BD3 ;
  wire n681;
  wire n682;
  wire n683;
  wire n684;
  wire n685;
  wire n686;
  wire n687;
  wire n688;
  wire n689;
  wire n694;
  wire n695;
  wire n696;
  wire n697;
  wire n698;
  wire n703;
  wire n704;
  wire n705;
  wire n706;
  wire n707;
  wire \gen_regfiles_n7_regfile_inst.AD0 ;
  wire \gen_regfiles_n7_regfile_inst.AD1 ;
  wire \gen_regfiles_n7_regfile_inst.AD2 ;
  wire \gen_regfiles_n7_regfile_inst.AD3 ;
  wire \gen_regfiles_n7_regfile_inst.BD0 ;
  wire \gen_regfiles_n7_regfile_inst.BD1 ;
  wire \gen_regfiles_n7_regfile_inst.BD2 ;
  wire \gen_regfiles_n7_regfile_inst.BD3 ;
  wire n708;
  wire n709;
  wire n710;
  wire n711;
  wire n712;
  wire n713;
  wire n714;
  wire n715;
  wire n716;
  wire n721;
  wire n722;
  wire n723;
  wire n724;
  wire n725;
  wire n730;
  wire n731;
  wire n732;
  wire n733;
  wire n734;
  wire \gen_regfiles_n8_regfile_inst.AD0 ;
  wire \gen_regfiles_n8_regfile_inst.AD1 ;
  wire \gen_regfiles_n8_regfile_inst.AD2 ;
  wire \gen_regfiles_n8_regfile_inst.AD3 ;
  wire \gen_regfiles_n8_regfile_inst.BD0 ;
  wire \gen_regfiles_n8_regfile_inst.BD1 ;
  wire \gen_regfiles_n8_regfile_inst.BD2 ;
  wire \gen_regfiles_n8_regfile_inst.BD3 ;
  wire n735;
  wire n736;
  wire n737;
  wire n738;
  wire n739;
  wire n740;
  wire n741;
  wire n742;
  wire n743;
  wire n748;
  wire n749;
  wire n750;
  wire n751;
  wire n752;
  wire n757;
  wire n758;
  wire n759;
  wire n760;
  wire n761;
  wire n764;
  wire [31:0] n765;
  wire n768;
  wire [31:0] n769;
  wire [31:0] n770;
  wire [31:0] n771;
  assign rs1_data = n765; //(module output)
  assign rs2_data = n769; //(module output)
  /* reg_file.vhd:50:10  */
  assign rs1_slices = n770; // (signal)
  /* reg_file.vhd:51:10  */
  assign rs2_slices = n771; // (signal)
  /* reg_file.vhd:54:10  */
  assign we_int = n544; // (signal)
  /* reg_file.vhd:61:36  */
  assign n543 = rd_addr != 5'b00000;
  /* reg_file.vhd:61:23  */
  assign n544 = n543 ? reg_write : 1'b0;
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n1_regfile_inst (
    .D0(n546),
    .D1(n547),
    .D2(n548),
    .D3(n549),
    .W_ADR0(n550),
    .W_ADR1(n551),
    .W_ADR2(n552),
    .W_ADR3(n553),
    .W_ADR4(n554),
    .W_en(we_int),
    .A_ADR0(n559),
    .A_ADR1(n560),
    .A_ADR2(n561),
    .A_ADR3(n562),
    .A_ADR4(n563),
    .B_ADR0(n568),
    .B_ADR1(n569),
    .B_ADR2(n570),
    .B_ADR3(n571),
    .B_ADR4(n572),
    .CLK(clk),
    .AD0(\gen_regfiles_n1_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n1_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n1_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n1_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n1_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n1_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n1_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n1_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n546 = rd_data[0]; // extract
  /* reg_file.vhd:75:22  */
  assign n547 = rd_data[1]; // extract
  /* reg_file.vhd:76:22  */
  assign n548 = rd_data[2]; // extract
  /* reg_file.vhd:77:22  */
  assign n549 = rd_data[3]; // extract
  /* reg_file.vhd:78:26  */
  assign n550 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n551 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n552 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n553 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n554 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n559 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n560 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n561 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n562 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n563 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n568 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n569 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n570 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n571 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n572 = rs2_addr[4]; // extract
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n2_regfile_inst (
    .D0(n573),
    .D1(n574),
    .D2(n575),
    .D3(n576),
    .W_ADR0(n577),
    .W_ADR1(n578),
    .W_ADR2(n579),
    .W_ADR3(n580),
    .W_ADR4(n581),
    .W_en(we_int),
    .A_ADR0(n586),
    .A_ADR1(n587),
    .A_ADR2(n588),
    .A_ADR3(n589),
    .A_ADR4(n590),
    .B_ADR0(n595),
    .B_ADR1(n596),
    .B_ADR2(n597),
    .B_ADR3(n598),
    .B_ADR4(n599),
    .CLK(clk),
    .AD0(\gen_regfiles_n2_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n2_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n2_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n2_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n2_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n2_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n2_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n2_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n573 = rd_data[4]; // extract
  /* reg_file.vhd:75:22  */
  assign n574 = rd_data[5]; // extract
  /* reg_file.vhd:76:22  */
  assign n575 = rd_data[6]; // extract
  /* reg_file.vhd:77:22  */
  assign n576 = rd_data[7]; // extract
  /* reg_file.vhd:78:26  */
  assign n577 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n578 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n579 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n580 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n581 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n586 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n587 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n588 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n589 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n590 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n595 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n596 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n597 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n598 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n599 = rs2_addr[4]; // extract
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n3_regfile_inst (
    .D0(n600),
    .D1(n601),
    .D2(n602),
    .D3(n603),
    .W_ADR0(n604),
    .W_ADR1(n605),
    .W_ADR2(n606),
    .W_ADR3(n607),
    .W_ADR4(n608),
    .W_en(we_int),
    .A_ADR0(n613),
    .A_ADR1(n614),
    .A_ADR2(n615),
    .A_ADR3(n616),
    .A_ADR4(n617),
    .B_ADR0(n622),
    .B_ADR1(n623),
    .B_ADR2(n624),
    .B_ADR3(n625),
    .B_ADR4(n626),
    .CLK(clk),
    .AD0(\gen_regfiles_n3_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n3_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n3_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n3_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n3_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n3_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n3_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n3_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n600 = rd_data[8]; // extract
  /* reg_file.vhd:75:22  */
  assign n601 = rd_data[9]; // extract
  /* reg_file.vhd:76:22  */
  assign n602 = rd_data[10]; // extract
  /* reg_file.vhd:77:22  */
  assign n603 = rd_data[11]; // extract
  /* reg_file.vhd:78:26  */
  assign n604 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n605 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n606 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n607 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n608 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n613 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n614 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n615 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n616 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n617 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n622 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n623 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n624 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n625 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n626 = rs2_addr[4]; // extract
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n4_regfile_inst (
    .D0(n627),
    .D1(n628),
    .D2(n629),
    .D3(n630),
    .W_ADR0(n631),
    .W_ADR1(n632),
    .W_ADR2(n633),
    .W_ADR3(n634),
    .W_ADR4(n635),
    .W_en(we_int),
    .A_ADR0(n640),
    .A_ADR1(n641),
    .A_ADR2(n642),
    .A_ADR3(n643),
    .A_ADR4(n644),
    .B_ADR0(n649),
    .B_ADR1(n650),
    .B_ADR2(n651),
    .B_ADR3(n652),
    .B_ADR4(n653),
    .CLK(clk),
    .AD0(\gen_regfiles_n4_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n4_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n4_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n4_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n4_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n4_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n4_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n4_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n627 = rd_data[12]; // extract
  /* reg_file.vhd:75:22  */
  assign n628 = rd_data[13]; // extract
  /* reg_file.vhd:76:22  */
  assign n629 = rd_data[14]; // extract
  /* reg_file.vhd:77:22  */
  assign n630 = rd_data[15]; // extract
  /* reg_file.vhd:78:26  */
  assign n631 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n632 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n633 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n634 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n635 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n640 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n641 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n642 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n643 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n644 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n649 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n650 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n651 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n652 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n653 = rs2_addr[4]; // extract
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n5_regfile_inst (
    .D0(n654),
    .D1(n655),
    .D2(n656),
    .D3(n657),
    .W_ADR0(n658),
    .W_ADR1(n659),
    .W_ADR2(n660),
    .W_ADR3(n661),
    .W_ADR4(n662),
    .W_en(we_int),
    .A_ADR0(n667),
    .A_ADR1(n668),
    .A_ADR2(n669),
    .A_ADR3(n670),
    .A_ADR4(n671),
    .B_ADR0(n676),
    .B_ADR1(n677),
    .B_ADR2(n678),
    .B_ADR3(n679),
    .B_ADR4(n680),
    .CLK(clk),
    .AD0(\gen_regfiles_n5_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n5_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n5_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n5_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n5_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n5_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n5_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n5_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n654 = rd_data[16]; // extract
  /* reg_file.vhd:75:22  */
  assign n655 = rd_data[17]; // extract
  /* reg_file.vhd:76:22  */
  assign n656 = rd_data[18]; // extract
  /* reg_file.vhd:77:22  */
  assign n657 = rd_data[19]; // extract
  /* reg_file.vhd:78:26  */
  assign n658 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n659 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n660 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n661 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n662 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n667 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n668 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n669 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n670 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n671 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n676 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n677 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n678 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n679 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n680 = rs2_addr[4]; // extract
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n6_regfile_inst (
    .D0(n681),
    .D1(n682),
    .D2(n683),
    .D3(n684),
    .W_ADR0(n685),
    .W_ADR1(n686),
    .W_ADR2(n687),
    .W_ADR3(n688),
    .W_ADR4(n689),
    .W_en(we_int),
    .A_ADR0(n694),
    .A_ADR1(n695),
    .A_ADR2(n696),
    .A_ADR3(n697),
    .A_ADR4(n698),
    .B_ADR0(n703),
    .B_ADR1(n704),
    .B_ADR2(n705),
    .B_ADR3(n706),
    .B_ADR4(n707),
    .CLK(clk),
    .AD0(\gen_regfiles_n6_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n6_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n6_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n6_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n6_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n6_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n6_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n6_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n681 = rd_data[20]; // extract
  /* reg_file.vhd:75:22  */
  assign n682 = rd_data[21]; // extract
  /* reg_file.vhd:76:22  */
  assign n683 = rd_data[22]; // extract
  /* reg_file.vhd:77:22  */
  assign n684 = rd_data[23]; // extract
  /* reg_file.vhd:78:26  */
  assign n685 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n686 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n687 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n688 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n689 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n694 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n695 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n696 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n697 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n698 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n703 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n704 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n705 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n706 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n707 = rs2_addr[4]; // extract
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n7_regfile_inst (
    .D0(n708),
    .D1(n709),
    .D2(n710),
    .D3(n711),
    .W_ADR0(n712),
    .W_ADR1(n713),
    .W_ADR2(n714),
    .W_ADR3(n715),
    .W_ADR4(n716),
    .W_en(we_int),
    .A_ADR0(n721),
    .A_ADR1(n722),
    .A_ADR2(n723),
    .A_ADR3(n724),
    .A_ADR4(n725),
    .B_ADR0(n730),
    .B_ADR1(n731),
    .B_ADR2(n732),
    .B_ADR3(n733),
    .B_ADR4(n734),
    .CLK(clk),
    .AD0(\gen_regfiles_n7_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n7_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n7_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n7_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n7_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n7_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n7_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n7_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n708 = rd_data[24]; // extract
  /* reg_file.vhd:75:22  */
  assign n709 = rd_data[25]; // extract
  /* reg_file.vhd:76:22  */
  assign n710 = rd_data[26]; // extract
  /* reg_file.vhd:77:22  */
  assign n711 = rd_data[27]; // extract
  /* reg_file.vhd:78:26  */
  assign n712 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n713 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n714 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n715 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n716 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n721 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n722 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n723 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n724 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n725 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n730 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n731 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n732 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n733 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n734 = rs2_addr[4]; // extract
  /* reg_file.vhd:67:5  */
  RegFile_32x4 #(
    .AD_reg(1'b0),
    .BD_reg(1'b0))
    gen_regfiles_n8_regfile_inst (
    .D0(n735),
    .D1(n736),
    .D2(n737),
    .D3(n738),
    .W_ADR0(n739),
    .W_ADR1(n740),
    .W_ADR2(n741),
    .W_ADR3(n742),
    .W_ADR4(n743),
    .W_en(we_int),
    .A_ADR0(n748),
    .A_ADR1(n749),
    .A_ADR2(n750),
    .A_ADR3(n751),
    .A_ADR4(n752),
    .B_ADR0(n757),
    .B_ADR1(n758),
    .B_ADR2(n759),
    .B_ADR3(n760),
    .B_ADR4(n761),
    .CLK(clk),
    .AD0(\gen_regfiles_n8_regfile_inst.AD0 ),
    .AD1(\gen_regfiles_n8_regfile_inst.AD1 ),
    .AD2(\gen_regfiles_n8_regfile_inst.AD2 ),
    .AD3(\gen_regfiles_n8_regfile_inst.AD3 ),
    .BD0(\gen_regfiles_n8_regfile_inst.BD0 ),
    .BD1(\gen_regfiles_n8_regfile_inst.BD1 ),
    .BD2(\gen_regfiles_n8_regfile_inst.BD2 ),
    .BD3(\gen_regfiles_n8_regfile_inst.BD3 ));
  /* reg_file.vhd:74:22  */
  assign n735 = rd_data[28]; // extract
  /* reg_file.vhd:75:22  */
  assign n736 = rd_data[29]; // extract
  /* reg_file.vhd:76:22  */
  assign n737 = rd_data[30]; // extract
  /* reg_file.vhd:77:22  */
  assign n738 = rd_data[31]; // extract
  /* reg_file.vhd:78:26  */
  assign n739 = rd_addr[0]; // extract
  /* reg_file.vhd:79:26  */
  assign n740 = rd_addr[1]; // extract
  /* reg_file.vhd:80:26  */
  assign n741 = rd_addr[2]; // extract
  /* reg_file.vhd:81:26  */
  assign n742 = rd_addr[3]; // extract
  /* reg_file.vhd:82:26  */
  assign n743 = rd_addr[4]; // extract
  /* reg_file.vhd:90:27  */
  assign n748 = rs1_addr[0]; // extract
  /* reg_file.vhd:91:27  */
  assign n749 = rs1_addr[1]; // extract
  /* reg_file.vhd:92:27  */
  assign n750 = rs1_addr[2]; // extract
  /* reg_file.vhd:93:27  */
  assign n751 = rs1_addr[3]; // extract
  /* reg_file.vhd:94:27  */
  assign n752 = rs1_addr[4]; // extract
  /* reg_file.vhd:101:27  */
  assign n757 = rs2_addr[0]; // extract
  /* reg_file.vhd:102:27  */
  assign n758 = rs2_addr[1]; // extract
  /* reg_file.vhd:103:27  */
  assign n759 = rs2_addr[2]; // extract
  /* reg_file.vhd:104:27  */
  assign n760 = rs2_addr[3]; // extract
  /* reg_file.vhd:105:27  */
  assign n761 = rs2_addr[4]; // extract
  /* reg_file.vhd:115:45  */
  assign n764 = rs1_addr == 5'b00000;
  /* reg_file.vhd:115:31  */
  assign n765 = n764 ? 32'b00000000000000000000000000000000 : rs1_slices;
  /* reg_file.vhd:116:45  */
  assign n768 = rs2_addr == 5'b00000;
  /* reg_file.vhd:116:31  */
  assign n769 = n768 ? 32'b00000000000000000000000000000000 : rs2_slices;
  assign n770 = {\gen_regfiles_n8_regfile_inst.AD3 , \gen_regfiles_n8_regfile_inst.AD2 , \gen_regfiles_n8_regfile_inst.AD1 , \gen_regfiles_n8_regfile_inst.AD0 , \gen_regfiles_n7_regfile_inst.AD3 , \gen_regfiles_n7_regfile_inst.AD2 , \gen_regfiles_n7_regfile_inst.AD1 , \gen_regfiles_n7_regfile_inst.AD0 , \gen_regfiles_n6_regfile_inst.AD3 , \gen_regfiles_n6_regfile_inst.AD2 , \gen_regfiles_n6_regfile_inst.AD1 , \gen_regfiles_n6_regfile_inst.AD0 , \gen_regfiles_n5_regfile_inst.AD3 , \gen_regfiles_n5_regfile_inst.AD2 , \gen_regfiles_n5_regfile_inst.AD1 , \gen_regfiles_n5_regfile_inst.AD0 , \gen_regfiles_n4_regfile_inst.AD3 , \gen_regfiles_n4_regfile_inst.AD2 , \gen_regfiles_n4_regfile_inst.AD1 , \gen_regfiles_n4_regfile_inst.AD0 , \gen_regfiles_n3_regfile_inst.AD3 , \gen_regfiles_n3_regfile_inst.AD2 , \gen_regfiles_n3_regfile_inst.AD1 , \gen_regfiles_n3_regfile_inst.AD0 , \gen_regfiles_n2_regfile_inst.AD3 , \gen_regfiles_n2_regfile_inst.AD2 , \gen_regfiles_n2_regfile_inst.AD1 , \gen_regfiles_n2_regfile_inst.AD0 , \gen_regfiles_n1_regfile_inst.AD3 , \gen_regfiles_n1_regfile_inst.AD2 , \gen_regfiles_n1_regfile_inst.AD1 , \gen_regfiles_n1_regfile_inst.AD0 };
  assign n771 = {\gen_regfiles_n8_regfile_inst.BD3 , \gen_regfiles_n8_regfile_inst.BD2 , \gen_regfiles_n8_regfile_inst.BD1 , \gen_regfiles_n8_regfile_inst.BD0 , \gen_regfiles_n7_regfile_inst.BD3 , \gen_regfiles_n7_regfile_inst.BD2 , \gen_regfiles_n7_regfile_inst.BD1 , \gen_regfiles_n7_regfile_inst.BD0 , \gen_regfiles_n6_regfile_inst.BD3 , \gen_regfiles_n6_regfile_inst.BD2 , \gen_regfiles_n6_regfile_inst.BD1 , \gen_regfiles_n6_regfile_inst.BD0 , \gen_regfiles_n5_regfile_inst.BD3 , \gen_regfiles_n5_regfile_inst.BD2 , \gen_regfiles_n5_regfile_inst.BD1 , \gen_regfiles_n5_regfile_inst.BD0 , \gen_regfiles_n4_regfile_inst.BD3 , \gen_regfiles_n4_regfile_inst.BD2 , \gen_regfiles_n4_regfile_inst.BD1 , \gen_regfiles_n4_regfile_inst.BD0 , \gen_regfiles_n3_regfile_inst.BD3 , \gen_regfiles_n3_regfile_inst.BD2 , \gen_regfiles_n3_regfile_inst.BD1 , \gen_regfiles_n3_regfile_inst.BD0 , \gen_regfiles_n2_regfile_inst.BD3 , \gen_regfiles_n2_regfile_inst.BD2 , \gen_regfiles_n2_regfile_inst.BD1 , \gen_regfiles_n2_regfile_inst.BD0 , \gen_regfiles_n1_regfile_inst.BD3 , \gen_regfiles_n1_regfile_inst.BD2 , \gen_regfiles_n1_regfile_inst.BD1 , \gen_regfiles_n1_regfile_inst.BD0 };
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
  wire n223;
  wire n225;
  wire [3:0] n228;
  wire [3:0] n230;
  wire n232;
  wire n234;
  wire n236;
  wire n238;
  wire n240;
  wire n242;
  wire n244;
  wire [3:0] n247;
  wire [3:0] n249;
  wire n251;
  wire n253;
  wire n255;
  wire [7:0] n256;
  reg [3:0] n264;
  wire n266;
  wire n268;
  wire n270;
  wire n272;
  wire n274;
  wire n276;
  wire n278;
  wire n280;
  wire [3:0] n283;
  wire [3:0] n285;
  wire n287;
  wire n289;
  wire n291;
  wire [7:0] n292;
  reg [3:0] n301;
  wire n303;
  wire n305;
  wire n307;
  wire n310;
  wire n312;
  wire n313;
  wire [3:0] n314;
  wire n317;
  wire n319;
  wire n320;
  wire [3:0] n321;
  wire n324;
  wire n326;
  wire n328;
  wire n330;
  wire n332;
  wire [8:0] n333;
  reg [3:0] n341;
  reg n345;
  reg n349;
  reg n353;
  reg n357;
  reg n361;
  reg n371;
  reg [1:0] n377;
  reg [2:0] n388;
  reg [1:0] n400;
  reg n412;
  wire [2:0] n419;
  wire n425;
  wire n427;
  wire n429;
  wire n432;
  wire n435;
  wire n436;
  wire n439;
  wire [2:0] n442;
  wire n445;
  wire n447;
  wire n449;
  wire [2:0] n451;
  wire n453;
  wire n454;
  wire n456;
  wire [2:0] n458;
  wire n460;
  wire n462;
  wire n464;
  wire [2:0] n466;
  wire n468;
  wire n470;
  wire n472;
  wire [2:0] n473;
  wire n475;
  wire n478;
  wire n481;
  wire [2:0] n483;
  wire n485;
  wire n488;
  wire n490;
  wire [2:0] n492;
  wire n494;
  wire n497;
  wire n499;
  wire [5:0] n500;
  reg n504;
  reg n509;
  reg n513;
  reg n517;
  reg n521;
  reg n526;
  reg n530;
  reg [2:0] n537;
  reg [2:0] n539;
  assign ir_write = n504; //(module output)
  assign pc_write = n509; //(module output)
  assign reg_write = n513; //(module output)
  assign mem_read = n517; //(module output)
  assign mem_write = n521; //(module output)
  assign alu_src_a = d_alu_src_a; //(module output)
  assign alu_src_b = d_alu_src_b; //(module output)
  assign alu_control = d_alu_control; //(module output)
  assign alu_start = n526; //(module output)
  assign latch_store_data = n530; //(module output)
  assign wb_sel = d_wb_sel; //(module output)
  assign is_branch = d_is_branch; //(module output)
  assign is_jalr = d_is_jalr; //(module output)
  assign is_jal = d_is_jal; //(module output)
  assign imm_type = d_imm_type; //(module output)
  /* control_unit.vhd:39:12  */
  assign state = n539; // (signal)
  /* control_unit.vhd:39:19  */
  assign next_state = n537; // (signal)
  /* control_unit.vhd:44:12  */
  assign d_alu_control = n341; // (signal)
  /* control_unit.vhd:45:12  */
  assign d_is_load = n345; // (signal)
  /* control_unit.vhd:45:23  */
  assign d_is_store = n349; // (signal)
  /* control_unit.vhd:45:35  */
  assign d_is_branch = n353; // (signal)
  /* control_unit.vhd:45:48  */
  assign d_is_jal = n357; // (signal)
  /* control_unit.vhd:45:58  */
  assign d_is_jalr = n361; // (signal)
  /* control_unit.vhd:45:69  */
  assign d_reg_write = n371; // (signal)
  /* control_unit.vhd:46:12  */
  assign d_wb_sel = n377; // (signal)
  /* control_unit.vhd:47:12  */
  assign d_imm_type = n388; // (signal)
  /* control_unit.vhd:48:12  */
  assign d_alu_src_a = n400; // (signal)
  /* control_unit.vhd:49:12  */
  assign d_alu_src_b = n412; // (signal)
  /* control_unit.vhd:72:35  */
  assign n223 = funct7 == 7'b0000000;
  /* control_unit.vhd:74:38  */
  assign n225 = funct7 == 7'b0100000;
  /* control_unit.vhd:74:25  */
  assign n228 = n225 ? 4'b0001 : 4'b0000;
  /* control_unit.vhd:72:25  */
  assign n230 = n223 ? 4'b0000 : n228;
  /* control_unit.vhd:71:21  */
  assign n232 = funct3 == 3'b000;
  /* control_unit.vhd:77:21  */
  assign n234 = funct3 == 3'b001;
  /* control_unit.vhd:78:21  */
  assign n236 = funct3 == 3'b010;
  /* control_unit.vhd:79:21  */
  assign n238 = funct3 == 3'b011;
  /* control_unit.vhd:80:21  */
  assign n240 = funct3 == 3'b100;
  /* control_unit.vhd:82:35  */
  assign n242 = funct7 == 7'b0000000;
  /* control_unit.vhd:84:38  */
  assign n244 = funct7 == 7'b0100000;
  /* control_unit.vhd:84:25  */
  assign n247 = n244 ? 4'b0111 : 4'b0000;
  /* control_unit.vhd:82:25  */
  assign n249 = n242 ? 4'b0110 : n247;
  /* control_unit.vhd:81:21  */
  assign n251 = funct3 == 3'b101;
  /* control_unit.vhd:87:21  */
  assign n253 = funct3 == 3'b110;
  /* control_unit.vhd:88:21  */
  assign n255 = funct3 == 3'b111;
  assign n256 = {n255, n253, n251, n240, n238, n236, n234, n232};
  /* control_unit.vhd:70:17  */
  always @*
    case (n256)
      8'b10000000: n264 = 4'b0010;
      8'b01000000: n264 = 4'b0011;
      8'b00100000: n264 = n249;
      8'b00010000: n264 = 4'b0100;
      8'b00001000: n264 = 4'b1001;
      8'b00000100: n264 = 4'b1000;
      8'b00000010: n264 = 4'b0101;
      8'b00000001: n264 = n230;
      default: n264 = 4'b0000;
    endcase
  /* control_unit.vhd:65:13  */
  assign n266 = opcode == 7'b0110011;
  /* control_unit.vhd:100:21  */
  assign n268 = funct3 == 3'b000;
  /* control_unit.vhd:101:21  */
  assign n270 = funct3 == 3'b001;
  /* control_unit.vhd:102:21  */
  assign n272 = funct3 == 3'b010;
  /* control_unit.vhd:103:21  */
  assign n274 = funct3 == 3'b011;
  /* control_unit.vhd:104:21  */
  assign n276 = funct3 == 3'b100;
  /* control_unit.vhd:106:35  */
  assign n278 = funct7 == 7'b0000000;
  /* control_unit.vhd:108:38  */
  assign n280 = funct7 == 7'b0100000;
  /* control_unit.vhd:108:25  */
  assign n283 = n280 ? 4'b0111 : 4'b0000;
  /* control_unit.vhd:106:25  */
  assign n285 = n278 ? 4'b0110 : n283;
  /* control_unit.vhd:105:21  */
  assign n287 = funct3 == 3'b101;
  /* control_unit.vhd:111:21  */
  assign n289 = funct3 == 3'b110;
  /* control_unit.vhd:112:21  */
  assign n291 = funct3 == 3'b111;
  assign n292 = {n291, n289, n287, n276, n274, n272, n270, n268};
  /* control_unit.vhd:99:17  */
  always @*
    case (n292)
      8'b10000000: n301 = 4'b0010;
      8'b01000000: n301 = 4'b0011;
      8'b00100000: n301 = n285;
      8'b00010000: n301 = 4'b0100;
      8'b00001000: n301 = 4'b1001;
      8'b00000100: n301 = 4'b1000;
      8'b00000010: n301 = 4'b0101;
      8'b00000001: n301 = 4'b0000;
      default: n301 = 4'b0000;
    endcase
  /* control_unit.vhd:93:13  */
  assign n303 = opcode == 7'b0010011;
  /* control_unit.vhd:117:13  */
  assign n305 = opcode == 7'b0000011;
  /* control_unit.vhd:126:13  */
  assign n307 = opcode == 7'b0100011;
  /* control_unit.vhd:139:40  */
  assign n310 = funct3 == 3'b000;
  /* control_unit.vhd:139:58  */
  assign n312 = funct3 == 3'b001;
  /* control_unit.vhd:139:48  */
  assign n313 = n310 | n312;
  /* control_unit.vhd:139:28  */
  assign n314 = n313 ? 4'b0001 : n321;
  /* control_unit.vhd:140:40  */
  assign n317 = funct3 == 3'b100;
  /* control_unit.vhd:140:58  */
  assign n319 = funct3 == 3'b101;
  /* control_unit.vhd:140:48  */
  assign n320 = n317 | n319;
  /* control_unit.vhd:139:66  */
  assign n321 = n320 ? 4'b1000 : 4'b1001;
  /* control_unit.vhd:133:13  */
  assign n324 = opcode == 7'b1100011;
  /* control_unit.vhd:143:13  */
  assign n326 = opcode == 7'b1101111;
  /* control_unit.vhd:152:13  */
  assign n328 = opcode == 7'b1100111;
  /* control_unit.vhd:161:13  */
  assign n330 = opcode == 7'b0110111;
  /* control_unit.vhd:168:13  */
  assign n332 = opcode == 7'b0010111;
  assign n333 = {n332, n330, n328, n326, n324, n307, n305, n303, n266};
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n341 = 4'b0000;
      9'b010000000: n341 = 4'b0000;
      9'b001000000: n341 = 4'b0000;
      9'b000100000: n341 = 4'b0000;
      9'b000010000: n341 = n314;
      9'b000001000: n341 = 4'b0000;
      9'b000000100: n341 = 4'b0000;
      9'b000000010: n341 = n301;
      9'b000000001: n341 = n264;
      default: n341 = 4'b0000;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n345 = 1'b0;
      9'b010000000: n345 = 1'b0;
      9'b001000000: n345 = 1'b0;
      9'b000100000: n345 = 1'b0;
      9'b000010000: n345 = 1'b0;
      9'b000001000: n345 = 1'b0;
      9'b000000100: n345 = 1'b1;
      9'b000000010: n345 = 1'b0;
      9'b000000001: n345 = 1'b0;
      default: n345 = 1'b0;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n349 = 1'b0;
      9'b010000000: n349 = 1'b0;
      9'b001000000: n349 = 1'b0;
      9'b000100000: n349 = 1'b0;
      9'b000010000: n349 = 1'b0;
      9'b000001000: n349 = 1'b1;
      9'b000000100: n349 = 1'b0;
      9'b000000010: n349 = 1'b0;
      9'b000000001: n349 = 1'b0;
      default: n349 = 1'b0;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n353 = 1'b0;
      9'b010000000: n353 = 1'b0;
      9'b001000000: n353 = 1'b0;
      9'b000100000: n353 = 1'b0;
      9'b000010000: n353 = 1'b1;
      9'b000001000: n353 = 1'b0;
      9'b000000100: n353 = 1'b0;
      9'b000000010: n353 = 1'b0;
      9'b000000001: n353 = 1'b0;
      default: n353 = 1'b0;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n357 = 1'b0;
      9'b010000000: n357 = 1'b0;
      9'b001000000: n357 = 1'b0;
      9'b000100000: n357 = 1'b1;
      9'b000010000: n357 = 1'b0;
      9'b000001000: n357 = 1'b0;
      9'b000000100: n357 = 1'b0;
      9'b000000010: n357 = 1'b0;
      9'b000000001: n357 = 1'b0;
      default: n357 = 1'b0;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n361 = 1'b0;
      9'b010000000: n361 = 1'b0;
      9'b001000000: n361 = 1'b1;
      9'b000100000: n361 = 1'b0;
      9'b000010000: n361 = 1'b0;
      9'b000001000: n361 = 1'b0;
      9'b000000100: n361 = 1'b0;
      9'b000000010: n361 = 1'b0;
      9'b000000001: n361 = 1'b0;
      default: n361 = 1'b0;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n371 = 1'b1;
      9'b010000000: n371 = 1'b1;
      9'b001000000: n371 = 1'b1;
      9'b000100000: n371 = 1'b1;
      9'b000010000: n371 = 1'b0;
      9'b000001000: n371 = 1'b0;
      9'b000000100: n371 = 1'b1;
      9'b000000010: n371 = 1'b1;
      9'b000000001: n371 = 1'b1;
      default: n371 = 1'b0;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n377 = 2'b00;
      9'b010000000: n377 = 2'b00;
      9'b001000000: n377 = 2'b10;
      9'b000100000: n377 = 2'b10;
      9'b000010000: n377 = 2'b00;
      9'b000001000: n377 = 2'b00;
      9'b000000100: n377 = 2'b01;
      9'b000000010: n377 = 2'b00;
      9'b000000001: n377 = 2'b00;
      default: n377 = 2'b00;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n388 = 3'b011;
      9'b010000000: n388 = 3'b011;
      9'b001000000: n388 = 3'b000;
      9'b000100000: n388 = 3'b100;
      9'b000010000: n388 = 3'b010;
      9'b000001000: n388 = 3'b001;
      9'b000000100: n388 = 3'b000;
      9'b000000010: n388 = 3'b000;
      9'b000000001: n388 = 3'b000;
      default: n388 = 3'b000;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n400 = 2'b01;
      9'b010000000: n400 = 2'b10;
      9'b001000000: n400 = 2'b00;
      9'b000100000: n400 = 2'b01;
      9'b000010000: n400 = 2'b00;
      9'b000001000: n400 = 2'b00;
      9'b000000100: n400 = 2'b00;
      9'b000000010: n400 = 2'b00;
      9'b000000001: n400 = 2'b00;
      default: n400 = 2'b00;
    endcase
  /* control_unit.vhd:63:9  */
  always @*
    case (n333)
      9'b100000000: n412 = 1'b1;
      9'b010000000: n412 = 1'b1;
      9'b001000000: n412 = 1'b1;
      9'b000100000: n412 = 1'b1;
      9'b000010000: n412 = 1'b0;
      9'b000001000: n412 = 1'b1;
      9'b000000100: n412 = 1'b1;
      9'b000000010: n412 = 1'b1;
      9'b000000001: n412 = 1'b0;
      default: n412 = 1'b0;
    endcase
  /* control_unit.vhd:185:13  */
  assign n419 = reset ? 3'b000 : next_state;
  /* control_unit.vhd:212:13  */
  assign n425 = state == 3'b000;
  /* control_unit.vhd:215:13  */
  assign n427 = state == 3'b001;
  /* control_unit.vhd:219:13  */
  assign n429 = state == 3'b010;
  /* control_unit.vhd:236:25  */
  assign n432 = d_reg_write ? 1'b1 : 1'b0;
  /* control_unit.vhd:241:25  */
  assign n435 = d_reg_write ? 1'b1 : 1'b0;
  /* control_unit.vhd:244:43  */
  assign n436 = d_is_load | d_is_store;
  /* control_unit.vhd:244:21  */
  assign n439 = n436 ? 1'b1 : 1'b0;
  /* control_unit.vhd:244:21  */
  assign n442 = n436 ? 3'b100 : 3'b101;
  /* control_unit.vhd:239:21  */
  assign n445 = d_is_jalr ? 1'b1 : 1'b0;
  /* control_unit.vhd:239:21  */
  assign n447 = d_is_jalr ? n435 : 1'b0;
  /* control_unit.vhd:239:21  */
  assign n449 = d_is_jalr ? 1'b0 : n439;
  /* control_unit.vhd:239:21  */
  assign n451 = d_is_jalr ? 3'b000 : n442;
  /* control_unit.vhd:234:21  */
  assign n453 = d_is_jal ? 1'b1 : n445;
  /* control_unit.vhd:234:21  */
  assign n454 = d_is_jal ? n432 : n447;
  /* control_unit.vhd:234:21  */
  assign n456 = d_is_jal ? 1'b0 : n449;
  /* control_unit.vhd:234:21  */
  assign n458 = d_is_jal ? 3'b000 : n451;
  /* control_unit.vhd:226:21  */
  assign n460 = d_is_branch ? 1'b1 : n453;
  /* control_unit.vhd:226:21  */
  assign n462 = d_is_branch ? 1'b0 : n454;
  /* control_unit.vhd:226:21  */
  assign n464 = d_is_branch ? 1'b0 : n456;
  /* control_unit.vhd:226:21  */
  assign n466 = d_is_branch ? 3'b000 : n458;
  /* control_unit.vhd:225:17  */
  assign n468 = alu_done ? n460 : 1'b0;
  /* control_unit.vhd:225:17  */
  assign n470 = alu_done ? n462 : 1'b0;
  /* control_unit.vhd:225:17  */
  assign n472 = alu_done ? n464 : 1'b0;
  /* control_unit.vhd:225:17  */
  assign n473 = alu_done ? n466 : state;
  /* control_unit.vhd:224:13  */
  assign n475 = state == 3'b011;
  /* control_unit.vhd:258:17  */
  assign n478 = d_is_store ? 1'b1 : 1'b0;
  /* control_unit.vhd:258:17  */
  assign n481 = d_is_store ? 1'b1 : 1'b0;
  /* control_unit.vhd:258:17  */
  assign n483 = d_is_store ? 3'b000 : state;
  /* control_unit.vhd:255:17  */
  assign n485 = d_is_load ? 1'b0 : n478;
  /* control_unit.vhd:255:17  */
  assign n488 = d_is_load ? 1'b1 : 1'b0;
  /* control_unit.vhd:255:17  */
  assign n490 = d_is_load ? 1'b0 : n481;
  /* control_unit.vhd:255:17  */
  assign n492 = d_is_load ? 3'b101 : n483;
  /* control_unit.vhd:254:13  */
  assign n494 = state == 3'b100;
  /* control_unit.vhd:265:17  */
  assign n497 = d_reg_write ? 1'b1 : 1'b0;
  /* control_unit.vhd:264:13  */
  assign n499 = state == 3'b101;
  assign n500 = {n499, n494, n475, n429, n427, n425};
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n504 = 1'b0;
      6'b010000: n504 = 1'b0;
      6'b001000: n504 = 1'b0;
      6'b000100: n504 = 1'b0;
      6'b000010: n504 = 1'b1;
      6'b000001: n504 = 1'b0;
      default: n504 = 1'bX;
    endcase
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n509 = 1'b1;
      6'b010000: n509 = n485;
      6'b001000: n509 = n468;
      6'b000100: n509 = 1'b0;
      6'b000010: n509 = 1'b0;
      6'b000001: n509 = 1'b0;
      default: n509 = 1'bX;
    endcase
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n513 = n497;
      6'b010000: n513 = 1'b0;
      6'b001000: n513 = n470;
      6'b000100: n513 = 1'b0;
      6'b000010: n513 = 1'b0;
      6'b000001: n513 = 1'b0;
      default: n513 = 1'bX;
    endcase
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n517 = 1'b0;
      6'b010000: n517 = n488;
      6'b001000: n517 = 1'b0;
      6'b000100: n517 = 1'b0;
      6'b000010: n517 = 1'b0;
      6'b000001: n517 = 1'b0;
      default: n517 = 1'bX;
    endcase
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n521 = 1'b0;
      6'b010000: n521 = n490;
      6'b001000: n521 = 1'b0;
      6'b000100: n521 = 1'b0;
      6'b000010: n521 = 1'b0;
      6'b000001: n521 = 1'b0;
      default: n521 = 1'bX;
    endcase
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n526 = 1'b0;
      6'b010000: n526 = 1'b0;
      6'b001000: n526 = 1'b0;
      6'b000100: n526 = 1'b1;
      6'b000010: n526 = 1'b0;
      6'b000001: n526 = 1'b0;
      default: n526 = 1'bX;
    endcase
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n530 = 1'b0;
      6'b010000: n530 = 1'b0;
      6'b001000: n530 = n472;
      6'b000100: n530 = 1'b0;
      6'b000010: n530 = 1'b0;
      6'b000001: n530 = 1'b0;
      default: n530 = 1'bX;
    endcase
  /* control_unit.vhd:211:9  */
  always @*
    case (n500)
      6'b100000: n537 = 3'b000;
      6'b010000: n537 = n492;
      6'b001000: n537 = n473;
      6'b000100: n537 = 3'b011;
      6'b000010: n537 = 3'b010;
      6'b000001: n537 = 3'b001;
      default: n537 = 3'bX;
    endcase
  /* control_unit.vhd:184:9  */
  always @(posedge clk)
    n539 <= n419;
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
  wire [7:0] n177;
  wire [5:0] n179;
  wire [7:0] n181;
  wire [5:0] n183;
  reg [31:0] n203; // mem_rd
  reg [31:0] n205; // mem_rd
  assign instr_data = instr_reg; //(module output)
  assign data_data = data_reg; //(module output)
  /* rom.vhd:19:12  */
  assign instr_word_addr = n179; // (signal)
  /* rom.vhd:20:12  */
  assign data_word_addr = n183; // (signal)
  /* rom.vhd:23:12  */
  always @*
    rom_array = 2048'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001101111000000000010000010100000001000110000011011000000000000010001001100100000000000000000000010110111; // (isignal)
  initial
    rom_array = 2048'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001101111000000000010000010100000001000110000011011000000000000010001001100100000000000000000000010110111;
  /* rom.vhd:32:12  */
  assign instr_reg = n205; // (signal)
  /* rom.vhd:33:12  */
  assign data_reg = n203; // (signal)
  /* rom.vhd:36:35  */
  assign n177 = instr_addr >> 31'b0000000000000000000000000000010;
  /* rom.vhd:36:24  */
  assign n179 = n177[5:0];  // trunc
  /* rom.vhd:37:35  */
  assign n181 = data_addr >> 31'b0000000000000000000000000000010;
  /* rom.vhd:37:24  */
  assign n183 = n181[5:0];  // trunc
  /* rom.vhd:43:36  */
  reg [31:0] n200[63:0] ; // memory
  initial begin
    n200[63] = 32'b00000000000000000000000000000000;
    n200[62] = 32'b00000000000000000000000000000000;
    n200[61] = 32'b00000000000000000000000000000000;
    n200[60] = 32'b00000000000000000000000000000000;
    n200[59] = 32'b00000000000000000000000000000000;
    n200[58] = 32'b00000000000000000000000000000000;
    n200[57] = 32'b00000000000000000000000000000000;
    n200[56] = 32'b00000000000000000000000000000000;
    n200[55] = 32'b00000000000000000000000000000000;
    n200[54] = 32'b00000000000000000000000000000000;
    n200[53] = 32'b00000000000000000000000000000000;
    n200[52] = 32'b00000000000000000000000000000000;
    n200[51] = 32'b00000000000000000000000000000000;
    n200[50] = 32'b00000000000000000000000000000000;
    n200[49] = 32'b00000000000000000000000000000000;
    n200[48] = 32'b00000000000000000000000000000000;
    n200[47] = 32'b00000000000000000000000000000000;
    n200[46] = 32'b00000000000000000000000000000000;
    n200[45] = 32'b00000000000000000000000000000000;
    n200[44] = 32'b00000000000000000000000000000000;
    n200[43] = 32'b00000000000000000000000000000000;
    n200[42] = 32'b00000000000000000000000000000000;
    n200[41] = 32'b00000000000000000000000000000000;
    n200[40] = 32'b00000000000000000000000000000000;
    n200[39] = 32'b00000000000000000000000000000000;
    n200[38] = 32'b00000000000000000000000000000000;
    n200[37] = 32'b00000000000000000000000000000000;
    n200[36] = 32'b00000000000000000000000000000000;
    n200[35] = 32'b00000000000000000000000000000000;
    n200[34] = 32'b00000000000000000000000000000000;
    n200[33] = 32'b00000000000000000000000000000000;
    n200[32] = 32'b00000000000000000000000000000000;
    n200[31] = 32'b00000000000000000000000000000000;
    n200[30] = 32'b00000000000000000000000000000000;
    n200[29] = 32'b00000000000000000000000000000000;
    n200[28] = 32'b00000000000000000000000000000000;
    n200[27] = 32'b00000000000000000000000000000000;
    n200[26] = 32'b00000000000000000000000000000000;
    n200[25] = 32'b00000000000000000000000000000000;
    n200[24] = 32'b00000000000000000000000000000000;
    n200[23] = 32'b00000000000000000000000000000000;
    n200[22] = 32'b00000000000000000000000000000000;
    n200[21] = 32'b00000000000000000000000000000000;
    n200[20] = 32'b00000000000000000000000000000000;
    n200[19] = 32'b00000000000000000000000000000000;
    n200[18] = 32'b00000000000000000000000000000000;
    n200[17] = 32'b00000000000000000000000000000000;
    n200[16] = 32'b00000000000000000000000000000000;
    n200[15] = 32'b00000000000000000000000000000000;
    n200[14] = 32'b00000000000000000000000000000000;
    n200[13] = 32'b00000000000000000000000000000000;
    n200[12] = 32'b00000000000000000000000000000000;
    n200[11] = 32'b00000000000000000000000000000000;
    n200[10] = 32'b00000000000000000000000000000000;
    n200[9] = 32'b00000000000000000000000000000000;
    n200[8] = 32'b00000000000000000000000000000000;
    n200[7] = 32'b00000000000000000000000000000000;
    n200[6] = 32'b00000000000000000000000000000000;
    n200[5] = 32'b00000000000000000000000000000000;
    n200[4] = 32'b00000000000000000000000000000000;
    n200[3] = 32'b00000000000000000000000001101111;
    n200[2] = 32'b00000000001000001010000000100011;
    n200[1] = 32'b00000110110000000000000100010011;
    n200[0] = 32'b00100000000000000000000010110111;
    end
  always @(posedge clk)
    if (1'b1)
      n203 <= n200[data_word_addr];
  always @(posedge clk)
    if (1'b1)
      n205 <= n200[instr_word_addr];
  /* rom.vhd:44:36  */
  /* rom.vhd:44:35  */
endmodule

module programcounter
  (input  clk,
   input  reset,
   input  pc_write,
   input  [31:0] pc_in,
   output [31:0] pc_out);
  reg [31:0] pc_reg;
  wire [31:0] n167;
  wire [31:0] n169;
  reg [31:0] n172;
  assign pc_out = pc_reg; //(module output)
  /* pc.vhd:16:12  */
  always @*
    pc_reg = n172; // (isignal)
  initial
    pc_reg = 32'b00000000000000000000000000000000;
  /* pc.vhd:24:13  */
  assign n167 = pc_write ? pc_in : pc_reg;
  /* pc.vhd:22:13  */
  assign n169 = reset ? 32'b00000000000000000000000000000000 : n167;
  /* pc.vhd:21:9  */
  always @(posedge clk)
    n172 <= n169;
  initial
    n172 = 32'b00000000000000000000000000000000;
endmodule

module top_flat
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
  wire [1:0] uart_addr;
  wire rom_en;
  wire uart_en;
  wire mem_write;
  wire uart_write_en;
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
  wire [31:0] \regfile_inst.rs1_data ;
  wire [31:0] \regfile_inst.rs2_data ;
  wire \addr_dec_inst.ram_en ;
  wire [7:0] \addr_dec_inst.ram_addr ;
  wire \addr_dec_inst.io_en ;
  wire n129;
  wire n130;
  wire \uart_inst.rstx ;
  wire [7:0] n144;
  wire [31:0] n145;
  wire [31:0] n146;
  wire [31:0] \mux_wb_inst.y ;
  reg n149;
  reg n150;
  reg [31:0] n151;
  reg [31:0] n154;
  wire [11:0] n156;
  wire [1:0] n157;
  wire [23:0] n158;
  wire [11:0] n159;
  wire n160;
  wire [23:0] n161;
  assign io_out = n158; //(module output)
  assign io_oeb = n161; //(module output)
  /* top.vhd:21:12  */
  assign reset = n16; // (signal)
  /* top.vhd:22:12  */
  assign internal_reset = reset_sync_1; // (signal)
  /* top.vhd:23:12  */
  always @*
    reset_sync_0 = n149; // (isignal)
  initial
    reset_sync_0 = 1'b1;
  /* top.vhd:23:26  */
  always @*
    reset_sync_1 = n150; // (isignal)
  initial
    reset_sync_1 = 1'b1;
  /* top.vhd:26:12  */
  always @*
    pc = \pc_unit.pc_out ; // (isignal)
  initial
    pc = 32'b00000000000000000000000000000000;
  /* top.vhd:26:16  */
  always @*
    pc_plus_four = n37; // (isignal)
  initial
    pc_plus_four = 32'b00000000000000000000000000000000;
  /* top.vhd:26:30  */
  always @*
    next_pc = n77; // (isignal)
  initial
    next_pc = 32'b00000000000000000000000000000000;
  /* top.vhd:26:39  */
  always @*
    jalr_target = n39; // (isignal)
  initial
    jalr_target = 32'b00000000000000000000000000000000;
  /* top.vhd:26:52  */
  always @*
    branch_target = n40; // (isignal)
  initial
    branch_target = 32'b00000000000000000000000000000000;
  /* top.vhd:29:12  */
  assign instr_reg = n151; // (signal)
  /* top.vhd:30:12  */
  assign opcode = n92; // (signal)
  /* top.vhd:31:12  */
  assign funct3 = n94; // (signal)
  /* top.vhd:32:12  */
  assign funct7 = n97; // (signal)
  /* top.vhd:33:12  */
  assign rs1_addr = n95; // (signal)
  /* top.vhd:33:22  */
  assign rs2_addr = n96; // (signal)
  /* top.vhd:33:32  */
  assign rd_addr = n93; // (signal)
  /* top.vhd:36:12  */
  always @*
    rs1_data = \regfile_inst.rs1_data ; // (isignal)
  initial
    rs1_data = 32'b00000000000000000000000000000000;
  /* top.vhd:36:22  */
  always @*
    rs2_data = \regfile_inst.rs2_data ; // (isignal)
  initial
    rs2_data = 32'b00000000000000000000000000000000;
  /* top.vhd:36:32  */
  always @*
    reg_write_data = \mux_wb_inst.y ; // (isignal)
  initial
    reg_write_data = 32'b00000000000000000000000000000000;
  /* top.vhd:47:12  */
  assign mem_data = n145; // (signal)
  /* top.vhd:51:33  */
  assign uart_write_en = n130; // (signal)
  /* top.vhd:61:12  */
  assign branch_taken = n75; // (signal)
  /* top.vhd:68:12  */
  always @*
    store_data = n154; // (isignal)
  initial
    store_data = 32'b00000000000000000000000000000000;
  /* top.vhd:73:19  */
  assign n16 = io_in[23]; // extract
  /* top.vhd:88:13  */
  assign n25 = latch_store_data ? rs2_data : store_data;
  /* top.vhd:86:13  */
  assign n27 = internal_reset ? 32'b00000000000000000000000000000000 : n25;
  /* top.vhd:106:51  */
  assign n37 = pc + 32'b00000000000000000000000000000100;
  /* top.vhd:107:33  */
  assign n39 = alu_result & 32'b11111111111111111111111111111110;
  /* top.vhd:108:50  */
  assign n40 = pc + imm;
  /* top.vhd:110:17  */
  assign n43 = funct3 == 3'b000;
  /* top.vhd:110:25  */
  assign n44 = zero_flag & n43;
  /* top.vhd:111:17  */
  assign n46 = funct3 == 3'b001;
  /* top.vhd:111:39  */
  assign n47 = ~zero_flag;
  /* top.vhd:111:25  */
  assign n48 = n47 & n46;
  /* top.vhd:110:46  */
  assign n49 = n44 | n48;
  /* top.vhd:112:17  */
  assign n51 = funct3 == 3'b100;
  /* top.vhd:112:40  */
  assign n53 = alu_result == 32'b00000000000000000000000000000001;
  /* top.vhd:112:25  */
  assign n54 = n53 & n51;
  /* top.vhd:111:46  */
  assign n55 = n49 | n54;
  /* top.vhd:113:17  */
  assign n57 = funct3 == 3'b101;
  /* top.vhd:113:40  */
  assign n59 = alu_result == 32'b00000000000000000000000000000000;
  /* top.vhd:113:25  */
  assign n60 = n59 & n57;
  /* top.vhd:112:55  */
  assign n61 = n55 | n60;
  /* top.vhd:114:17  */
  assign n63 = funct3 == 3'b110;
  /* top.vhd:114:40  */
  assign n65 = alu_result == 32'b00000000000000000000000000000001;
  /* top.vhd:114:25  */
  assign n66 = n65 & n63;
  /* top.vhd:113:55  */
  assign n67 = n61 | n66;
  /* top.vhd:115:17  */
  assign n69 = funct3 == 3'b111;
  /* top.vhd:115:40  */
  assign n71 = alu_result == 32'b00000000000000000000000000000000;
  /* top.vhd:115:25  */
  assign n72 = n71 & n69;
  /* top.vhd:114:55  */
  assign n73 = n67 | n72;
  /* top.vhd:109:47  */
  assign n74 = n73 & is_branch;
  /* top.vhd:109:26  */
  assign n75 = n74 ? 1'b1 : 1'b0;
  /* top.vhd:119:23  */
  assign n77 = is_jalr ? jalr_target : n78;
  /* top.vhd:119:44  */
  assign n78 = is_jal ? alu_result : n79;
  /* top.vhd:120:43  */
  assign n79 = branch_taken ? branch_target : pc_plus_four;
  /* top.vhd:124:5  */
  programcounter pc_unit (
    .clk(clk),
    .reset(internal_reset),
    .pc_write(pc_write),
    .pc_in(next_pc),
    .pc_out(\pc_unit.pc_out ));
  /* top.vhd:134:5  */
  rom_6 rom_inst (
    .clk(clk),
    .instr_addr(n81),
    .data_addr(rom_addr),
    .instr_data(rom_instr_data),
    .data_data(rom_read_data));
  /* top.vhd:137:30  */
  assign n81 = pc[7:0]; // extract
  /* top.vhd:149:13  */
  assign n87 = ir_write ? rom_instr_data : instr_reg;
  /* top.vhd:147:13  */
  assign n89 = internal_reset ? 32'b00000000000000000000000000000000 : n87;
  /* top.vhd:156:26  */
  assign n92 = instr_reg[6:0]; // extract
  /* top.vhd:157:26  */
  assign n93 = instr_reg[11:7]; // extract
  /* top.vhd:158:26  */
  assign n94 = instr_reg[14:12]; // extract
  /* top.vhd:159:26  */
  assign n95 = instr_reg[19:15]; // extract
  /* top.vhd:160:26  */
  assign n96 = instr_reg[24:20]; // extract
  /* top.vhd:161:26  */
  assign n97 = instr_reg[31:25]; // extract
  /* top.vhd:164:5  */
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
    .mem_write(mem_write),
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
  /* top.vhd:192:5  */
  reg_file regfile_inst (
    .clk(clk),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .rd_addr(rd_addr),
    .rd_data(reg_write_data),
    .reg_write(reg_write),
    .rs1_data(\regfile_inst.rs1_data ),
    .rs2_data(\regfile_inst.rs2_data ));
  /* top.vhd:205:5  */
  imm_gen immgen_inst (
    .instr(instr_reg),
    .imm_type(imm_type),
    .imm_out(imm));
  /* top.vhd:213:5  */
  mux_a mux_a_inst (
    .clk(clk),
    .sel(alu_src_a),
    .rs1(rs1_data),
    .pc(pc),
    .result(alu_input_a));
  /* top.vhd:222:5  */
  mux_b mux_b_inst (
    .clk(clk),
    .sel(alu_src_b),
    .rs2(rs2_data),
    .imm(imm),
    .result(alu_input_b));
  /* top.vhd:232:5  */
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
  /* top.vhd:246:5  */
  address_decoder addr_dec_inst (
    .addr(alu_result),
    .ram_en(),
    .ram_addr(),
    .uart_en(uart_en),
    .uart_addr(uart_addr),
    .rom_en(rom_en),
    .rom_addr(rom_addr),
    .io_en());
  /* top.vhd:259:48  */
  assign n129 = uart_en & mem_write;
  /* top.vhd:259:26  */
  assign n130 = n129 ? 1'b1 : 1'b0;
  /* top.vhd:260:5  */
  uart uart_inst (
    .clk(clk),
    .reset(internal_reset),
    .addr(uart_addr),
    .wr_en(uart_write_en),
    .write_data(store_data),
    .read_data(uart_read_data),
    .rstx(\uart_inst.rstx ));
  /* top.vhd:281:39  */
  assign n144 = store_data[7:0]; // extract
  /* top.vhd:284:32  */
  assign n145 = uart_en ? uart_read_data : n146;
  /* top.vhd:284:51  */
  assign n146 = rom_en ? rom_read_data : 32'b00000000000000000000000000000000;
  /* top.vhd:289:5  */
  mux_wb mux_wb_inst (
    .clk(clk),
    .sel(wb_sel),
    .a(alu_result),
    .b(mem_data),
    .c(pc_plus_four),
    .y(\mux_wb_inst.y ));
  /* top.vhd:97:9  */
  always @(posedge clk)
    n149 <= reset;
  initial
    n149 = 1'b1;
  /* top.vhd:97:9  */
  always @(posedge clk)
    n150 <= reset_sync_0;
  initial
    n150 = 1'b1;
  /* top.vhd:146:9  */
  always @(posedge clk)
    n151 <= n89;
  /* top.vhd:85:9  */
  always @(posedge clk)
    n154 <= n27;
  initial
    n154 = 32'b00000000000000000000000000000000;
  assign n156 = n0[12:1]; // extract
  assign n157 = n0[23:22]; // extract
  assign n158 = {n157, n144, \uart_inst.rstx , n156, 1'b1};
  assign n159 = n2[12:1]; // extract
  assign n160 = n2[22]; // extract
  assign n161 = {1'b0, n160, 8'b11111111, 1'b1, n159, 1'b1};
endmodule

