module pixel_gen(
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input valid,
   input [15:0] track0,
   input [15:0] track1,
   input [15:0] track2,
   input [1:0] track_change,
   input [3:0] track_select,
   input [9:0] vga_iter,
   input [2:0] color_0,
   input [2:0] color_1,
   output reg [3:0] vgaRed,
   output reg [3:0] vgaGreen,
   output reg [3:0] vgaBlue
);
   
always @(*) begin
     if(!valid)
          {vgaRed, vgaGreen, vgaBlue} = 12'h0;
     else if (v_cnt < 94) begin
          if (h_cnt == vga_iter) {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
          else if (    (h_cnt >= 38 && h_cnt < 40) || (h_cnt >= 78 && h_cnt < 80) || (h_cnt >= 118 && h_cnt < 120) || (h_cnt >= 158 && h_cnt < 160)
               || (h_cnt >= 198 && h_cnt < 200) || (h_cnt >= 238 && h_cnt < 240) || (h_cnt >= 278 && h_cnt < 280) || (h_cnt >= 318 && h_cnt < 320)
               || (h_cnt >= 358 && h_cnt < 360) || (h_cnt >= 398 && h_cnt < 400) || (h_cnt >= 438 && h_cnt < 440) || (h_cnt >= 478 && h_cnt < 480)
               || (h_cnt >= 518 && h_cnt < 520) || (h_cnt >= 558 && h_cnt < 560) || (h_cnt >= 598 && h_cnt < 600) || (h_cnt >= 638 && h_cnt < 640))
               {vgaRed, vgaGreen, vgaBlue} = 12'h000;   // Draw black line
          else if (h_cnt < 38)
               if (track_change == 2 && track_select == 0) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[0]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 78)
               if (track_change == 2 && track_select == 1) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[1]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 118)
               if (track_change == 2 && track_select == 2) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[2]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 158)
               if (track_change == 2 && track_select == 3) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[3]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 198)
               if (track_change == 2 && track_select == 4) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[4]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 238)
               if (track_change == 2 && track_select == 5) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[5]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 278)
               if (track_change == 2 && track_select == 6) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[6]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 318)
               if (track_change == 2 && track_select == 7) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[7]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 358)
               if (track_change == 2 && track_select == 8) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[8]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 398)
               if (track_change == 2 && track_select == 9) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[9]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 438)
               if (track_change == 2 && track_select == 10) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[10]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 478)
               if (track_change == 2 && track_select == 11) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[11]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 518)
               if (track_change == 2 && track_select == 12) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[12]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 558)
               if (track_change == 2 && track_select == 13) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[13]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 598)
               if (track_change == 2 && track_select == 14) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[14]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 638)
               if (track_change == 2 && track_select == 15) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track2[15]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
     end
     else if (v_cnt >= 96 && v_cnt < 190) begin
          if (h_cnt == vga_iter) {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
          else if (    (h_cnt >= 38 && h_cnt < 40) || (h_cnt >= 78 && h_cnt < 80) || (h_cnt >= 118 && h_cnt < 120) || (h_cnt >= 158 && h_cnt < 160)
               || (h_cnt >= 198 && h_cnt < 200) || (h_cnt >= 238 && h_cnt < 240) || (h_cnt >= 278 && h_cnt < 280) || (h_cnt >= 318 && h_cnt < 320)
               || (h_cnt >= 358 && h_cnt < 360) || (h_cnt >= 398 && h_cnt < 400) || (h_cnt >= 438 && h_cnt < 440) || (h_cnt >= 478 && h_cnt < 480)
               || (h_cnt >= 518 && h_cnt < 520) || (h_cnt >= 558 && h_cnt < 560) || (h_cnt >= 598 && h_cnt < 600) || (h_cnt >= 638 && h_cnt < 640))
               {vgaRed, vgaGreen, vgaBlue} = 12'h000;   // Draw black line
          else if (h_cnt < 38)
               if (track_change == 1 && track_select == 0) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[0]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 78)
               if (track_change == 1 && track_select == 1) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[1]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 118)
               if (track_change == 1 && track_select == 2) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[2]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 158)
               if (track_change == 1 && track_select == 3) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[3]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 198)
               if (track_change == 1 && track_select == 4) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[4]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 238)
               if (track_change == 1 && track_select == 5) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[5]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 278)
               if (track_change == 1 && track_select == 6) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[6]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 318)
               if (track_change == 1 && track_select == 7) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[7]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 358)
               if (track_change == 1 && track_select == 8) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[8]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 398)
               if (track_change == 1 && track_select == 9) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[9]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 438)
               if (track_change == 1 && track_select == 10) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[10]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 478)
               if (track_change == 1 && track_select == 11) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[11]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 518)
               if (track_change == 1 && track_select == 12) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[12]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 558)
               if (track_change == 1 && track_select == 13) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[13]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 598)
               if (track_change == 1 && track_select == 14) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[14]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 638)
               if (track_change == 1 && track_select == 15) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track1[15]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
     end
     else if (v_cnt >= 192 && v_cnt < 286) begin
          if (h_cnt == vga_iter) {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
          else if (    (h_cnt >= 38 && h_cnt < 40) || (h_cnt >= 78 && h_cnt < 80) || (h_cnt >= 118 && h_cnt < 120) || (h_cnt >= 158 && h_cnt < 160)
               || (h_cnt >= 198 && h_cnt < 200) || (h_cnt >= 238 && h_cnt < 240) || (h_cnt >= 278 && h_cnt < 280) || (h_cnt >= 318 && h_cnt < 320)
               || (h_cnt >= 358 && h_cnt < 360) || (h_cnt >= 398 && h_cnt < 400) || (h_cnt >= 438 && h_cnt < 440) || (h_cnt >= 478 && h_cnt < 480)
               || (h_cnt >= 518 && h_cnt < 520) || (h_cnt >= 558 && h_cnt < 560) || (h_cnt >= 598 && h_cnt < 600) || (h_cnt >= 638 && h_cnt < 640))
               {vgaRed, vgaGreen, vgaBlue} = 12'h000;   // Draw black line
          else if (h_cnt < 38)
               if (track_change == 0 && track_select == 0) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[0]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 78)
               if (track_change == 0 && track_select == 1) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[1]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 118)
               if (track_change == 0 && track_select == 2) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[2]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 158)
               if (track_change == 0 && track_select == 3) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[3]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 198)
               if (track_change == 0 && track_select == 4) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[4]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 238)
               if (track_change == 0 && track_select == 5) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[5]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 278)
               if (track_change == 0 && track_select == 6) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[6]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 318)
               if (track_change == 0 && track_select == 7) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[7]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 358)
               if (track_change == 0 && track_select == 8) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[8]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 398)
               if (track_change == 0 && track_select == 9) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[9]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 438)
               if (track_change == 0 && track_select == 10) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[10]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 478)
               if (track_change == 0 && track_select == 11) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[11]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 518)
               if (track_change == 0 && track_select == 12) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[12]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 558)
               if (track_change == 0 && track_select == 13) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[13]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 598)
               if (track_change == 0 && track_select == 14) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[14]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else if (h_cnt < 638)
               if (track_change == 0 && track_select == 15) {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               else if (track0[15]) {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
          else {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
     end
     else if ((v_cnt >= 94 && v_cnt < 96) || (v_cnt >= 190 && v_cnt < 192) || (v_cnt >= 286 && v_cnt < 288) || (v_cnt >= 382 && v_cnt < 384) || (v_cnt >= 478 && v_cnt < 480))
          if (h_cnt == vga_iter) {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
          else {vgaRed, vgaGreen, vgaBlue} = 12'h000;   // Draw black line
     else if (v_cnt < 382)
          case (color_1)
               0: {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
               1: {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               2: {vgaRed, vgaGreen, vgaBlue} = 12'hf80;
               3: {vgaRed, vgaGreen, vgaBlue} = 12'hff0;
               4: {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               5: {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
               6: {vgaRed, vgaGreen, vgaBlue} = 12'h0ff;
               7: {vgaRed, vgaGreen, vgaBlue} = 12'hf0f;
          endcase
     else if (v_cnt < 478)
          case (color_0)
               0: {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
               1: {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
               2: {vgaRed, vgaGreen, vgaBlue} = 12'hf80;
               3: {vgaRed, vgaGreen, vgaBlue} = 12'hff0;
               4: {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
               5: {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
               6: {vgaRed, vgaGreen, vgaBlue} = 12'h0ff;
               7: {vgaRed, vgaGreen, vgaBlue} = 12'hf0f;
          endcase
end

endmodule
