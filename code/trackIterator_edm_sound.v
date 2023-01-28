`define silence1   32'd6250000
module track_iterator__edm_sound (
	input clk, 
	input reset,
    input [2:0] volume,
    input [31:0] freq,
    output reg [15:0] audio
);
    reg [24:0] cnt, next_cnt;
	always @(posedge clk) begin
        cnt <= next_cnt;
    end
    // next_cnt
    always @* begin
        next_cnt = cnt+25'd1;
    end


    // I/O declaration
    wire [15:0] data_in;
    wire [15:0] sound_A;
    wire [13:0] sound_addr_A;
    blk_mem_gen_3 b(
        .clka(cnt[3]),
        .addra(sound_addr_A),
        .douta(sound_A),
        .wea(0),
        .dina(data_in)
    );
    // Declare internal signals
    
    reg [21:0] clk_cnt_next, clk_cnt;
    wire [28:0] Tleft_A;
    
    reg [31:0] old_freq,next_old_freq;
    assign Tleft_A=6250000/old_freq;
    reg [28:0] cnt_A,next_cnt_A;
    reg flag_A,next_flag_A;
    assign sound_addr_A=(clk_cnt*170/Tleft_A+cnt_A*170)%8770;
    
    
    always @(posedge cnt[3] or posedge reset)
        if (reset == 1'b1)
            begin
                clk_cnt <= 22'd0;
                cnt_A <= 29'd0;
                flag_A <= 0;
                old_freq <= `silence1;
            end
        else
            begin
                clk_cnt <= clk_cnt_next;
                cnt_A <= next_cnt_A;
                flag_A <= next_flag_A;
                old_freq <= next_old_freq;
            end

    always @* begin
        next_old_freq=freq;
        clk_cnt_next=clk_cnt;
        next_cnt_A=cnt_A;
        next_flag_A=flag_A;
        if(freq!=`silence1)begin
            if(old_freq!=freq)next_flag_A=1;
        end
        else next_flag_A=0;
        if(flag_A)begin
            if (clk_cnt == Tleft_A-1)begin
                clk_cnt_next = 22'd0;
                next_flag_A=flag_A;
                if(old_freq!=freq)begin
                    next_cnt_A=29'd0;
                end else begin
                    next_cnt_A=cnt_A+1;
                    if(cnt_A==29'd50)begin
                        next_cnt_A=29'd0;
                        next_flag_A=0;
                    end
                end
            end
            else begin
                if(old_freq!=freq)begin
                    next_cnt_A=29'd0;
                    clk_cnt_next=22'd0;
                end else begin
                    clk_cnt_next = clk_cnt + 1'b1;
                    next_cnt_A=cnt_A;
                    next_flag_A=flag_A;
                end
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