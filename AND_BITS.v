//multiple bits and module
module AND_BITS #(
	parameter BITS = 2
) (
	output [BITS-1:0] OUT_,
	input  [BITS-1:0] _A,_B
);
genvar i;
generate
	for (i = 0; i < BITS; i = i + 1) begin: and_block
		and an(OUT_[i],_A[i],_B[i]);
	end
endgenerate
endmodule