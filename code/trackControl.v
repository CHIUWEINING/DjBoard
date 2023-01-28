module track_control (
	input clk, 
	input reset, 
    input [15:0] track_vec,
    input [3:0] track_iter,
	output reg play_or_not
);

    reg next_play_or_not;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			play_or_not <= 0;
		end else begin
            play_or_not <= next_play_or_not;
		end
	end

    always @* begin
		next_play_or_not = track_vec[track_iter];
    end


endmodule