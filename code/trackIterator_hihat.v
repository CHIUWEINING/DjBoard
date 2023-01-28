module track_iterator_hihat (
	input clk, 
	input reset,
    input [15:0] track_vec, 
    input [24:0] track_iter_cnt,
    input [3:0] track_iter,
    input [2:0] volume, 
    output reg [15:0] audio
);
    wire play_or_not,play_or_not_d,play_or_not_o;
    reg count,next_count;
    assign play_or_not=(!count)?track_vec[track_iter]:0;
    debounce play_or_not_debounce(.clk(clk),.pb(play_or_not),.pb_debounced(play_or_not_d));
    OnePulse play_or_not_onepulse(.clock(track_iter_cnt[1]),.signal(play_or_not_d),.signal_single_pulse(play_or_not_o));
	
    always @(posedge track_iter_cnt[23], posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            count <= count+1;
        end
    end


    // I/O declaration
    wire [15:0] data_in;
    wire [15:0] sound_A;
    wire [12:0] sound_addr_A;
    blk_mem_gen_0 b(
        .clka(track_iter_cnt[1]),
        .addra(sound_addr_A),
        .douta(sound_A),
        .wea(0),
        .dina(data_in)
    );
    // Declare internal signals
    
    reg [21:0] clk_cnt_next, clk_cnt;
    wire [28:0] Tleft_A;
    assign Tleft_A=25000000/9500;
    reg [28:0] cnt_A,next_cnt_A;
    reg flag_A,next_flag_A;
    assign sound_addr_A=(clk_cnt*4/Tleft_A+cnt_A*4)%6684;
    
    

    always @(posedge track_iter_cnt[1] or posedge reset)
        if (reset == 1'b1)
            begin
                clk_cnt <= 22'd0;
                cnt_A <= 29'd0;
                flag_A <= 0;
            end
        else
            begin
                clk_cnt <= clk_cnt_next;
                cnt_A <= next_cnt_A;
                flag_A <= next_flag_A;
            end
    
    always @* begin
        clk_cnt_next=clk_cnt;
        next_cnt_A=cnt_A;
        if(play_or_not_o)next_flag_A=1;
        else next_flag_A=flag_A;
        if(flag_A)begin
            if (clk_cnt == Tleft_A-1)begin
                clk_cnt_next = 22'd0;
                next_flag_A=flag_A;
                next_cnt_A=cnt_A+1;
                if(cnt_A==29'd1670)begin
                    next_cnt_A=29'd0;
                    next_flag_A=0;
                end
                else next_cnt_A=cnt_A+1;
            end
            else begin
                clk_cnt_next = clk_cnt + 1'b1;
                next_cnt_A=cnt_A;
                next_flag_A=flag_A;
            end
        end
    end

    

    // Assign the amplitude of the note
    // Volume is controlled here
    always@*begin
        case(volume)
            3'd0:audio=16'h0000;
            default:audio=(flag_A)?sound_A:16'h0000;
        endcase
    end
    // assign audio_left = (note_div_left == 22'd1) ? 16'h0000 : 
    //                             (b_clk == 1'b0) ? 16'hE000 : 16'h2000;
    // assign audio_right = (note_div_right == 22'd1) ? 16'h0000 : 
    //                             (c_clk == 1'b0) ? 16'hE000 : 16'h2000;

endmodule