module track_iterator (
	input clk, 
	input reset,
    input [15:0] track_vec, 
    output reg [3:0] track_iter
);

    reg [3:0] next_track_iter = 0;

	always @(posedge clk, posedge reset) begin
        if (reset) begin
            track_iter <= 0;
        end else begin
            track_iter <= next_track_iter;
        end
    end

    always @* begin
        if (track_iter == 15) next_track_iter = 0;
        else next_track_iter = track_iter+1;
    end


endmodule