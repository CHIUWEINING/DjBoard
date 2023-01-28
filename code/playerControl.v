module player_control (
	input clk, 
	input reset, 
	input [2:0] state, 
	input pause,
	input play_or_not,
	output reg [25:0] ibeat
);
	parameter LEN = 6250000;
	parameter FIXED = 3'd1;
	parameter FREE = 3'd2;
    reg [25:0] next_ibeat;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			ibeat <= 0;
		end else begin
            ibeat <= next_ibeat;
		end
	end

    always @* begin
		if (play_or_not == 0) next_ibeat = 0;
		if (pause == 0) next_ibeat = (ibeat + 1 < LEN) ? (ibeat + 1) : 0;
		else next_ibeat = ibeat;
    end


endmodule
