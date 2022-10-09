//multiple bits multiplication module
module MULT #(
	parameter BITS = 2
) (
	output [BITS*2-1:0] OUT_,
	input  [BITS-1:0] 	_A,_B
);
genvar i;
generate
	for (i = 0; i < BITS; i = i + 1) begin: and_block
		wire [BITS-1:0] and_out;
		AND_BITS #(BITS) an (and_out,_A,{BITS{_B[i]}});
	end
	for (i = 0; i < BITS - 1; i = i + 1) begin: add_block
		wire [BITS+i:0] add_out;
		wire cout;
		if (i == 0) begin
			ADD_BITS #(BITS + 1) add (
				add_out,
				cout,
				and_block[0].and_out,
				{and_block[1].and_out,1'b0},
				0
			);
		end
		else begin
			ADD_BITS #(BITS + i + 1) add (
				add_out,
				cout,
				{add_block[i-1].cout,add_block[i-1].add_out},
				{and_block[i+1].and_out,{i+1{1'b0}}},
				0
			);
		end
	end
endgenerate
assign OUT_ = {add_block[BITS-2].cout,add_block[BITS-2].add_out};
endmodule