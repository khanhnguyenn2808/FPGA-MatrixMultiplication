//multiple bits addition module
module ADD_BITS #(
	parameter BITS = 2
) (
	output [BITS-1:0]	SUM_,
	output 				COUT_,
	input  [BITS-1:0]	_A,_B,
	input 				_CIN
);
wire [BITS:0]w;
assign w[0] = _CIN, COUT_ = w[BITS];
genvar i;
generate
	for (i = 0; i < BITS;i = i + 1) begin: add_block
		FULL_ADDER FA (SUM_[i],w[i+1],_A[i],_B[i],w[i]);
	end
endgenerate
endmodule