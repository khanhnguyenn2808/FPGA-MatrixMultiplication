module PARTIAL_MATRIX_MULT #(
	parameter BITS = 2,
	parameter SIZE = 4
) (
	output [BITS*2+SIZE/2-1:0] OUT_,
	input [BITS*SIZE-1:0] _A,_B
);
genvar i;
generate
	for (i = 0; i < SIZE; i = i + 1) begin: mult_block
		wire [BITS*2-1:0] mult_out;
		MULT #(BITS) MU (mult_out,_A[i*BITS+BITS-1:i*BITS],_B[i*BITS+BITS-1:i*BITS]);
	end
	for (i = 0; i < SIZE - 1; i = i + 1) begin: add_block
		wire [BITS*2+i:0] add_out;
		wire cout;
		if (i == 0) begin
			ADD_BITS #(BITS*2+1) add (
				add_out,
				cout,
				mult_block[0].mult_out,
				mult_block[1].mult_out,
				0
			);
		end
		else begin
			ADD_BITS #(BITS*2+i+1) add (
				add_out,
				cout,
				mult_block[i+1].mult_out,
				{add_block[i-1].cout,add_block[i-1].add_out},
				0
			);
		end
	end
endgenerate
assign OUT_ = {add_block[SIZE-2].cout,add_block[SIZE-2].add_out};
endmodule