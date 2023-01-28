`define c   32'd262   // C3
`define g   32'd392   // G3
`define b   32'd494   // B3
`define hc  32'd524   // C4
`define hd  32'd588   // D4
`define he  32'd660   // E4
`define hf  32'd698   // F4
`define hg  32'd784   // G4

`define sil   32'd50000000 // slience

module sound1 (
	input [25:0] ibeatNum,
	input en,
    input pause,
	output reg [31:0] toneL,
    output reg [31:0] toneR
);

    always @* begin
        if(en == 1 && pause == 0) begin
            case(ibeatNum)
                // --- Measure 1 ---
                12'd0: toneR = `hg;      12'd1: toneR = `hg; // HG (half-beat)
                12'd2: toneR = `hg;      12'd3: toneR = `hg;
                12'd4: toneR = `hg;      12'd5: toneR = `hg;
                12'd6: toneR = `hg;      12'd7: toneR = `hg;
                12'd8: toneR = `hg;	    12'd9: toneR = `hg;
                12'd10: toneR = `hg;	12'd11: toneR = `hg;
                12'd12: toneR = `hg;	12'd13: toneR = `hg;
                12'd14: toneR = `hg;	12'd15: toneR = `hg;

                12'd16: toneR = `hg;	12'd17: toneR = `hg;
                12'd18: toneR = `hg;	12'd19: toneR = `hg;
                12'd20: toneR = `hg;	12'd21: toneR = `hg;
                12'd22: toneR = `hg;	12'd23: toneR = `hg;
                12'd24: toneR = `hg;	12'd25: toneR = `hg;
                12'd26: toneR = `hg;	12'd27: toneR = `hg;
                12'd28: toneR = `hg;	12'd29: toneR = `hg;
                12'd30: toneR = `hg;	12'd31: toneR = `hg;
                12'd32: toneR = `hg;    12'd33: toneR = `hg;
                12'd34: toneR = `hg;    12'd35: toneR = `hg;
                12'd36: toneR = `hg;    12'd37: toneR = `hg;
                12'd38: toneR = `hg;	12'd39: toneR = `hg;
                12'd40: toneR = `hg;	12'd41: toneR = `hg;
                12'd42: toneR = `hg;	12'd43: toneR = `hg;
                12'd44: toneR = `hg;	12'd45: toneR = `hg;

                12'd46: toneR = `hg;	12'd47: toneR = `hg;
                12'd48: toneR = `hg;	12'd49: toneR = `hg;
                12'd50: toneR = `hg;	12'd51: toneR = `hg;
                12'd52: toneR = `hg;	12'd53: toneR = `hg;
                12'd54: toneR = `hg;	12'd55: toneR = `hg;
                12'd56: toneR = `hg;	12'd57: toneR = `hg;
                12'd58: toneR = `hg;	12'd59: toneR = `hg;
                12'd60: toneR = `hg;	12'd61: toneR = `hg;

                12'd62: toneR = `hg;  	12'd63: toneR = `hg;
                12'd64: toneR = `hg;	12'd65: toneR = `hg;
                12'd66: toneR = `hg;  	12'd67: toneR = `hg;
                12'd68: toneR = `hg;	12'd69: toneR = `hg;
                12'd70: toneR = `hg;	12'd71: toneR = `hg;
                12'd72: toneR = `hg;	12'd73: toneR = `hg;
                12'd74: toneR = `hg;	12'd75: toneR = `hg;

                12'd76: toneR = `hg;	12'd77: toneR = `hg;
                12'd78: toneR = `hg;	12'd79: toneR = `hg;
                12'd80: toneR = `hg;	12'd81: toneR = `hg;
                12'd82: toneR = `hg;	12'd83: toneR = `hg;
                12'd84: toneR = `hg;	12'd85: toneR = `hg;
                12'd86: toneR = `hg;	12'd87: toneR = `hg;
                12'd88: toneR = `hg;	12'd89: toneR = `hg;
                12'd90: toneR = `hg;	12'd91: toneR = `hg;

                default: toneR = `sil;
            endcase
        end else begin
            toneR = `sil;
        end
    end

    always @(*) begin
        if(en == 1 && pause == 0)begin
            case(ibeatNum)
                12'd0: toneL = `hc;  	12'd1: toneL = `hc; // HC (two-beat)
                12'd2: toneL = `hc;  	12'd3: toneL = `hc;
                12'd4: toneL = `hc;	    12'd5: toneL = `hc;
                12'd6: toneL = `hc;  	12'd7: toneL = `hc;
                12'd8: toneL = `hc;	    12'd9: toneL = `hc;
                12'd10: toneL = `hc;	12'd11: toneL = `hc;
                12'd12: toneL = `hc;	12'd13: toneL = `hc;
                12'd14: toneL = `hc;	12'd15: toneL = `hc;

                12'd16: toneL = `hc;	12'd17: toneL = `hc;
                12'd18: toneL = `hc;	12'd19: toneL = `hc;
                12'd20: toneL = `hc;	12'd21: toneL = `hc;
                12'd22: toneL = `hc;	12'd23: toneL = `hc;
                12'd24: toneL = `hc;	12'd25: toneL = `hc;
                12'd26: toneL = `hc;	12'd27: toneL = `hc;
                12'd28: toneL = `hc;	12'd29: toneL = `hc;
                12'd30: toneL = `hc;	12'd31: toneL = `hc;
                12'd32: toneL = `hc;  	12'd33: toneL = `hc;
                12'd34: toneL = `hc;	12'd35: toneL = `hc;
                12'd36: toneL = `hc;  	12'd37: toneL = `hc;
                12'd38: toneL = `hc;	12'd39: toneL = `hc;
                12'd40: toneL = `hc;	12'd41: toneL = `hc;
                12'd42: toneL = `hc;	12'd43: toneL = `hc;
                12'd44: toneL = `hc;	12'd45: toneL = `hc;

                12'd46: toneL = `hc;	12'd47: toneL = `hc;
                12'd48: toneL = `hc;	12'd49: toneL = `hc;
                12'd50: toneL = `hc;	12'd51: toneL = `hc;
                12'd52: toneL = `hc;	12'd53: toneL = `hc;
                12'd54: toneL = `hc;	12'd55: toneL = `hc;
                12'd56: toneL = `hc;	12'd57: toneL = `hc;
                12'd58: toneL = `hc;	12'd59: toneL = `hc;
                12'd60: toneL = `hc;	12'd61: toneL = `hc;

                12'd62: toneL = `hc;  	12'd63: toneL = `hc;
                12'd64: toneL = `hc;	12'd65: toneL = `hc;
                12'd66: toneL = `hc;  	12'd67: toneL = `hc;
                12'd68: toneL = `hc;	12'd69: toneL = `hc;
                12'd70: toneL = `hc;	12'd71: toneL = `hc;
                12'd72: toneL = `hc;	12'd73: toneL = `hc;
                12'd74: toneL = `hc;	12'd75: toneL = `hc;

                12'd76: toneL = `hc;	12'd77: toneL = `hc;
                12'd78: toneL = `hc;	12'd79: toneL = `hc;
                12'd80: toneL = `hc;	12'd81: toneL = `hc;
                12'd82: toneL = `hc;	12'd83: toneL = `hc;
                12'd84: toneL = `hc;	12'd85: toneL = `hc;
                12'd86: toneL = `hc;	12'd87: toneL = `hc;
                12'd88: toneL = `hc;	12'd89: toneL = `hc;
                12'd90: toneL = `hc;	12'd91: toneL = `hc;

                

                default : toneL = `sil;
            endcase
        end
        else begin
            toneL = `sil;
        end
    end
endmodule