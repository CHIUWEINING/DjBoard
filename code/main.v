`define silence   32'd50000000
`define c   32'd262   // C3
`define d   32'd294   // D3
`define e   32'd330   // E3
`define f   32'd349   // F3
`define g   32'd392   // G3
`define a   32'd440   // A3
`define b   32'd494   // B3

module main(
    input wire clk,
    input wire btn_c,
    input wire btn_u,
    input wire btn_d,
    input wire btn_l,
    input wire btn_r,
    input wire [15:0] sw,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    output reg [15:0] LED,
    output wire [3:0] digit,
    output wire [6:0] display,
    output wire audio_mclk_A,
    output wire audio_lrck_A, 
    output wire audio_sck_A, 
    output wire audio_sdin_A,
    output wire audio_mclk_B,
    output wire audio_lrck_B, 
    output wire audio_sck_B, 
    output wire audio_sdin_B,
    output wire audio_mclk_C,
    output wire audio_lrck_C, 
    output wire audio_sck_C, 
    output wire audio_sdin_C,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync
);

// clkDiv
wire clkDiv25, clkDiv22, clkDiv25M;
clock_divider #(.n(25)) clock_25(.clk(clk), .clk_div(clkDiv25));    // for a beat of 16-beat
clock_divider #(.n(22)) clock_22(.clk(clk), .clk_div(clkDiv22));    // for keyboard and audio
clock_divider #(.n(2)) clock_2(.clk(clk), .clk_div(clkDiv25M));     // for VGA

//state declare
parameter FIXED = 3'd1;
parameter FREE = 3'd2;
reg [2:0] state, next_state;

//push button declare
wire db_c, db_u, db_d, db_l, db_r, rst, opu, op_d, op_l, op_r;
debounce db0(.clk(clk), .pb(btn_c), .pb_debounced(db_c));
debounce db1(.clk(clk), .pb(btn_u), .pb_debounced(db_u));
debounce db2(.clk(clk), .pb(btn_d), .pb_debounced(db_d));
debounce db3(.clk(clk), .pb(btn_l), .pb_debounced(db_l));
debounce db4(.clk(clk), .pb(btn_r), .pb_debounced(db_r));
OnePulse op0(.clock(clk), .signal(db_c), .signal_single_pulse(rst));   //btn_c -> rst
OnePulse op1(.clock(clk), .signal(db_u), .signal_single_pulse(op_u));
OnePulse op2(.clock(clk), .signal(db_d), .signal_single_pulse(op_d));
OnePulse op3(.clock(clk), .signal(db_l), .signal_single_pulse(op_l));
OnePulse op4(.clock(clk), .signal(db_r), .signal_single_pulse(op_r));

//seven segment parameters declare
reg [15:0] num, next_num;

//keyboard parameters declare
wire [511:0] key_down;
wire [8:0] last_change;
wire been_ready;

//key codes declare
parameter [8:0] KEY_CODES [0:19] = {
    9'b0_0100_0101,	// 0 => 45
    9'b0_0001_0110,	// 1 => 16
    9'b0_0001_1110,	// 2 => 1E
    9'b0_0010_0110,	// 3 => 26
    9'b0_0010_0101,	// 4 => 25
    9'b0_0010_1110,	// 5 => 2E
    9'b0_0011_0110,	// 6 => 36
    9'b0_0011_1101,	// 7 => 3D
    9'b0_0011_1110,	// 8 => 3E
    9'b0_0100_0110,	// 9 => 46
    
    9'b0_0111_0000, // right_0 => 70
    9'b0_0110_1001, // right_1 => 69
    9'b0_0111_0010, // right_2 => 72
    9'b0_0111_1010, // right_3 => 7A
    9'b0_0110_1011, // right_4 => 6B
    9'b00101001, // sapce
    9'b00011101, // W
    9'b00011100, // A
    9'b00011011, // S
    9'b00100011  // D
};



//music parameters declare
wire [11:0] ibeat;
wire [25:0] ibeat_sound;
reg [31:0] freqL_example, freqR_example;
wire [15:0] audio_in_left_A, audio_in_right_A, audio_in_left_B, audio_in_right_B, audio_in_left_C, audio_in_right_C;
wire [21:0] freq_out_0, freq_out_1;

//connect module: SevenSegment
SevenSegment seven_seg (
    .display(display),
    .digit(digit),
    .nums(num),
    .rst(rst),
    .clk(clk)
);

//connect module: KeyboardDecoder
KeyboardDecoder key_de (
    .key_down(key_down),
    .last_change(last_change),
    .key_valid(been_ready),
    .PS2_DATA(PS2_DATA),
    .PS2_CLK(PS2_CLK),
    .rst(rst),
    .clk(clk)
);

//state machine
always @(posedge clk, posedge rst) begin
    if (rst) begin
        state <= FIXED;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    if (sw[15]) next_state = FREE;
    else next_state = FIXED;
end

// Record last pressed keyboard
reg [15:0] last_down, next_last_down;
always @(posedge clk, posedge rst) begin
    if (rst) begin
        last_down = 0;
    end
    else begin
        last_down = next_last_down;
    end
end

always @(*) begin 
    if (key_down[KEY_CODES[15]]) next_last_down = KEY_CODES[15];
    else if (key_down[KEY_CODES[16]]) next_last_down = KEY_CODES[16];
    else if (key_down[KEY_CODES[17]]) next_last_down = KEY_CODES[17];
    else if (key_down[KEY_CODES[18]]) next_last_down = KEY_CODES[18];
    else if (key_down[KEY_CODES[19]]) next_last_down = KEY_CODES[19];
    else next_last_down = 0;
end

// Track iterator
// wire [3:0] track_iter;
reg [15:0] track0, track1, track2; 



// Track changer
reg [1:0] track_change, next_track_change;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        track_change = 0;
    end
    else begin
        track_change = next_track_change;
    end
end

always @(*) begin 
    if (state == FIXED) begin
        if (key_down[KEY_CODES[16]] && last_down != KEY_CODES[16]) begin
            if (track_change == 2) next_track_change = 0;
            else next_track_change = track_change+1;
        end
        else if (key_down[KEY_CODES[18]] && last_down != KEY_CODES[18]) begin
            if (track_change == 0) next_track_change = 2;
            else next_track_change = track_change-1;
        end
        else next_track_change = track_change;
    end
    else next_track_change = track_change;
end


// Track selector
reg [3:0] track_select, next_track_select;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        track_select = 0;
    end
    else begin
        track_select = next_track_select;
    end
end

always @(*) begin 
    if (state == FIXED) begin
        if (key_down[KEY_CODES[17]] && last_down != KEY_CODES[17]) begin
            if (track_select == 0) next_track_select = 4'd15;
            else next_track_select = track_select-1;
        end
        else if (key_down[KEY_CODES[19]] && last_down != KEY_CODES[19]) begin
            if (track_select == 15) next_track_select = 4'd0;
            else next_track_select = track_select+1;
        end
        else next_track_select = track_select;
    end
    else next_track_select = track_select;
end

// Change track0 vector value
reg [15:0] next_track0;
always @(posedge clk, posedge rst) begin
    if (rst) begin
        track0 = 16'b0000000000000000;
    end
    else begin
        track0 = next_track0;
    end
end

always @(*) begin 
    next_track0 = track0;
    if (track_change == 0 && state == FIXED) begin
        if (key_down[KEY_CODES[15]] && last_down != KEY_CODES[15]) begin
            next_track0[track_select] = ~track0[track_select];
        end
    end
end

// Change track1 vector value
reg [15:0] next_track1;
always @(posedge clk, posedge rst) begin
    if (rst) begin
        track1 = 16'b0000000000000000;
    end
    else begin
        track1 = next_track1;
    end
end

always @(*) begin 
    next_track1 = track1;
    if (track_change == 1 && state == FIXED) begin
        if (key_down[KEY_CODES[15]] && last_down != KEY_CODES[15]) begin
            next_track1[track_select] = ~track1[track_select];
        end
    end
end

// Change track2 vector value
reg [15:0] next_track2;
always @(posedge clk, posedge rst) begin
    if (rst) begin
        track2 = 16'b0000000000000000;
    end
    else begin
        track2 = next_track2;
    end
end

always @(*) begin 
    next_track2 = track2;
    if (track_change == 2 && state == FIXED) begin
        if (key_down[KEY_CODES[15]] && last_down != KEY_CODES[15]) begin
            next_track2[track_select] = ~track2[track_select];
        end
    end
end



// Track iterator cnt
reg [24:0] track_iter_cnt, next_track_iter_cnt;

always @(posedge clk, posedge rst) begin
    if (rst) track_iter_cnt <= 0;
    else track_iter_cnt <= next_track_iter_cnt;
end

always @* begin
    next_track_iter_cnt = track_iter_cnt+25'd1;
end

// Track iter
reg [3:0] track_iter, next_track_iter;
always @(posedge track_iter_cnt[24], posedge rst) begin
    if (rst) begin
        track_iter <= 0;
    end else begin
        track_iter <= next_track_iter;
    end
end

always @* begin
    if (track_iter == 15) next_track_iter = 0;
    else next_track_iter = track_iter+1;
end

track_iterator_edm_snare track_iterator_edm_snare(
    .clk(clk), 
	.reset(rst), 
    .track_vec(track2),
    .track_iter_cnt(track_iter_cnt),
    .track_iter(track_iter),
    .volume(3'd1),
    .audio(audio_in_left_C)
);

track_iterator_tom track_iterator_tom1(
    .clk(clk), 
	.reset(rst), 
    .track_vec(track0),
    .track_iter_cnt(track_iter_cnt),
    .track_iter(track_iter),
    .volume(3'd1),
    .audio(audio_in_left_A)
);

track_iterator_tom track_iterator_tom2(
    .clk(clk), 
	.reset(rst), 
    .track_vec(track0),
    .track_iter_cnt(track_iter_cnt),
    .track_iter(track_iter),
    .volume(3'd1),
    .audio(audio_in_right_A)
);

track_iterator_hihat track_iterator_hihat(
    .clk(clk), 
	.reset(rst), 
    .track_vec(track1),
    .track_iter_cnt(track_iter_cnt),
    .track_iter(track_iter),
    .volume(3'd1),
    .audio(audio_in_right_B)
);

// Record Block
parameter [28:0] UP_BOUND = 29'b11111111111111111111111111111;
reg [28:0] record_cnt, next_record_cnt;
wire [8:0] record_id;
reg [31:0] freq_kb, next_freq_kb, freq_record_0, next_freq_record_0, freq_record_1, next_freq_record_1;
reg [31:0] music_record_0 [0:511];
reg [31:0] music_record_1 [0:511];
reg [2:0] music_record_vga_0 [0:639];
reg [2:0] music_record_vga_1 [0:639];
reg record_press, next_record_press;
reg recording, next_recording;
reg has_record_0, next_has_record_0, has_record_1, next_has_record_1;
reg track_change_free, next_track_change_free;
reg [9:0] vga_iter, next_vga_iter;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        record_cnt = 0;
    end
    else record_cnt = next_record_cnt;
end

always @(*) begin
    next_record_cnt = record_cnt + 1;
end

assign record_id = record_cnt >> 20;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        freq_kb <= `silence;
        freq_record_0 <= `silence;
        freq_record_1 <= `silence;
    end else begin
        freq_kb <= next_freq_kb;
        freq_record_0 <= next_freq_record_0;
        freq_record_1 <= next_freq_record_1;
        if (recording) begin
            if (track_change_free == 0) begin
                music_record_0[record_id] <= next_freq_kb;
            end 
            else begin
                music_record_1[record_id] <= next_freq_kb;
            end 
        end 
    end
    
end

always @(*) begin
    next_freq_record_0 = music_record_0[record_id];
    next_freq_record_1 = music_record_1[record_id];
    case (state)
        FIXED: begin
            next_freq_kb = `silence;
        end
        FREE: begin
            if (key_down[last_change]) begin
                case (last_change)
                    KEY_CODES[1]: next_freq_kb = `c>>1;
                    KEY_CODES[2]: next_freq_kb = `d>>1;
                    KEY_CODES[3]: next_freq_kb = `e>>1;
                    KEY_CODES[4]: next_freq_kb = `f>>1;
                    KEY_CODES[5]: next_freq_kb = `g>>1;
                    KEY_CODES[6]: next_freq_kb = `a>>1;
                    KEY_CODES[7]: next_freq_kb = `b>>1;
                    default: next_freq_kb = `silence;
                endcase
            end
            else next_freq_kb = `silence;
        end
        default: next_freq_kb = `silence;
    endcase
    
end

always @(posedge clk, posedge rst) begin
    if (rst) begin
        record_press = 0;
    end
    else record_press = next_record_press;
end

always @(*) begin
    if (!recording && key_down[KEY_CODES[0]] && state == FREE) next_record_press = 1;
    else if (record_cnt == UP_BOUND) next_record_press = 0;
    else next_record_press = record_press;
end

always @(posedge clk, posedge rst) begin
    if (rst) begin
        recording = 0;
    end
    else recording = next_recording;
end

always @(*) begin
    if (record_cnt == UP_BOUND && record_press) begin
        next_recording = 1;
    end 
    else if (record_cnt == UP_BOUND && recording) begin
        next_recording = 0;
    end 
    else next_recording = recording;
end

always @(posedge clk, posedge rst) begin
    if (rst) begin
        has_record_0 = 0;
        has_record_1 = 0;
    end
    else begin
        has_record_0 = next_has_record_0;
        has_record_1 = next_has_record_1;
    end 
end

always @(*) begin
    if (record_cnt == UP_BOUND && recording) begin
        if (track_change_free == 0) begin
            next_has_record_0 = 1;
            next_has_record_1 = has_record_1;
        end 
        else if (track_change_free == 1) begin
            next_has_record_1 = 1;
            next_has_record_0 = has_record_0;
        end 
        else begin
            next_has_record_0 = has_record_0;
            next_has_record_1 = has_record_1;
        end
    end 
    else if (key_down[KEY_CODES[10]] && state == FREE) begin
        if (track_change_free == 0) begin
            next_has_record_0 = 0;
            next_has_record_1 = has_record_1;
        end
        else if (track_change_free == 1) begin
            next_has_record_1 = 0;
            next_has_record_0 = has_record_0;
        end
        else begin
            next_has_record_0 = has_record_0;
            next_has_record_1 = has_record_1;
        end
    end 
    else begin
        next_has_record_0 = has_record_0;
        next_has_record_1 = has_record_1;
    end 
end

always @(posedge clk, posedge rst) begin
    if (rst) begin
        track_change_free = 0;
    end
    else track_change_free = next_track_change_free;
end

always @(*) begin
    if (state == FREE) begin
        if (((key_down[KEY_CODES[16]] && last_down != KEY_CODES[16]) || (key_down[KEY_CODES[18]] && last_down != KEY_CODES[18])) && !recording) begin
            next_track_change_free = ~track_change_free;
        end
        else next_track_change_free = track_change_free;
    end
    else next_track_change_free = track_change_free;
end

// VGA iterator
reg [26:0] vga_cnt, next_vga_cnt;
always @(posedge track_iter_cnt[1], posedge rst) begin
    if (rst) begin
        vga_cnt = 0;
    end
    else vga_cnt = next_vga_cnt;
end

always @(*) begin
    next_vga_cnt = vga_cnt+1;
end

always @(posedge track_iter_cnt[1], posedge rst) begin
    if (rst) begin
        vga_iter = 0;
    end
    else vga_iter = next_vga_iter;
end

always @(*) begin
    if (vga_cnt%209715 == 0) begin
        if (vga_iter == 639) next_vga_iter = 0;
        else next_vga_iter = vga_iter+1;
    end
    else next_vga_iter = vga_iter;
end

//led control block
reg [15:0] next_LED;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        LED = 0;
    end
    else LED = next_LED;
end

always @(*) begin
    next_LED = 0;
    if (recording) next_LED[0] = 1;
    if (state == FREE) next_LED[15] = 1;
end

//num determination block
always @(posedge clk, posedge rst) begin
    if (rst) begin
        num = 0;
    end
    else begin
        num = next_num;
    end
end

always @(*) begin
    case (state)
        FREE: next_num = track_change_free;
        FIXED: next_num = track_change;
        default: next_num = 0;
    endcase
    
end


//output frequency determination block
// assign freq_outL = 50000000 / freqL_example;
wire [31:0] freq_vga_0, freq_vga_1;
assign freq_out_0 = 50000000 / (has_record_0 ? freq_record_0 : freq_kb);
assign freq_out_1 = 50000000 / (has_record_1 ? freq_record_1>>1 : freq_kb>>1);
assign freq_vga_0 = (has_record_0 ? freq_record_0 : freq_kb);
assign freq_vga_1 = (has_record_1 ? freq_record_1 : freq_kb);

reg [2:0] color_0, color_1, next_color_0, next_color_1;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        color_0 = 0;
        color_1 = 0;
    end
    else begin
        color_0 = next_color_0;
        color_1 = next_color_1;
    end 
end

always @(*) begin
    case (freq_vga_0)
        `c>>1: next_color_0 = 1;
        `d>>1: next_color_0 = 2;
        `e>>1: next_color_0 = 3;
        `f>>1: next_color_0 = 4;
        `g>>1: next_color_0 = 5;
        `a>>1: next_color_0 = 6;
        `b>>1: next_color_0 = 7;
        `silence: next_color_0 = 0;
    endcase
    case (freq_vga_1)
        `c>>1: next_color_1 = 1;
        `d>>1: next_color_1 = 2;
        `e>>1: next_color_1 = 3;
        `f>>1: next_color_1 = 4;
        `g>>1: next_color_1 = 5;
        `a>>1: next_color_1 = 6;
        `b>>1: next_color_1 = 7;
        `silence: next_color_1 = 0;
    endcase
end

// Note generation
// note_gen noteGen_00(
//     .clk(clk), 
//     .rst(rst), 
//     // .volume(vol),
//     // .note_div_left(freq_outL), 
//     .note_div(freq_out_0), 
//     // .audio_left(audio_in_left_A),     // left sound audio
//     .audio(audio_in_right_A)    // right sound audio
// );
track_iterator__edm_sound edm_sound1(
    .clk(clk), 
	.reset(rst),
    .volume(3'd1),
    .freq(freq_vga_0>>1),
    .audio(audio_in_right_C)
);

// note_gen noteGen_01(
//     .clk(clk), 
//     .rst(rst), 
//     // .volume(vol),
//     // .note_div_left(freq_outL), 
//     .note_div(freq_out_1), 
//     // .audio_left(audio_in_left_A),     // left sound audio
//     .audio(audio_in_left_B)    // right sound audio
// );
track_iterator__edm_sound edm_sound2(
    .clk(clk), 
	.reset(rst),
    .volume(3'd1),
    .freq(freq_vga_1),
    .audio(audio_in_left_B)
);

// Speaker controller
speaker_control sc(
    .clk(clk), 
    .rst(rst), 
    .audio_in_left(audio_in_left_A),      // left channel audio data input
    .audio_in_right(audio_in_right_A),    // right channel audio data input
    .audio_mclk(audio_mclk_A),            // master clock
    .audio_lrck(audio_lrck_A),            // left-right clock
    .audio_sck(audio_sck_A),              // serial clock
    .audio_sdin(audio_sdin_A)             // serial audio data input
);

speaker_control sc2(
    .clk(clk), 
    .rst(rst), 
    .audio_in_left(audio_in_left_B),      // left channel audio data input
    .audio_in_right(audio_in_right_B),    // right channel audio data input
    .audio_mclk(audio_mclk_B),            // master clock
    .audio_lrck(audio_lrck_B),            // left-right clock
    .audio_sck(audio_sck_B),              // serial clock
    .audio_sdin(audio_sdin_B)             // serial audio data input
);

speaker_control sc3(
    .clk(clk), 
    .rst(rst), 
    .audio_in_left(audio_in_left_C),      // left channel audio data input
    .audio_in_right(audio_in_right_C),    // right channel audio data input
    .audio_mclk(audio_mclk_C),            // master clock
    .audio_lrck(audio_lrck_C),            // left-right clock
    .audio_sck(audio_sck_C),              // serial clock
    .audio_sdin(audio_sdin_C)             // serial audio data input
);

// VGA Block
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480

pixel_gen pixel_gen(
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .valid(valid),
    .track0(track0),
    .track1(track1),
    .track2(track2),
    .track_change(track_change),
    .track_select(track_select),
    .vga_iter(vga_iter),
    .color_0(color_0),
    .color_1(color_1),
    .vgaRed(vgaRed),
    .vgaGreen(vgaGreen),
    .vgaBlue(vgaBlue)
);

vga_controller   vga_inst(
    .pclk(track_iter_cnt[1]),
    .reset(rst),
    .hsync(hsync),
    .vsync(vsync),
    .valid(valid),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt)
);
endmodule

