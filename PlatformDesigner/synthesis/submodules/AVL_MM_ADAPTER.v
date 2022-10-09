module AVL_MM_ADAPTER (
	output reg  [31:0] 	DATA_OUT_,
	input 		[31:0]	_DATA_IN,
	input 		[1:0]	_ADDR,
	input 				_READ_DATA,_WRITE_DATA,_CS,_CLK,_RST
);

reg  [31:0] mult_in2,mult_in1;
wire [17:0] mult_out;

PARTIAL_MATRIX_MULT #(.BITS(8),.SIZE(4)) PMM (mult_out,mult_in1,mult_in2);

always @(posedge _CLK or posedge _RST) begin
	if (_RST) begin
		mult_in1  <= 0;
		mult_in2  <= 0;
		DATA_OUT_ <= 0;
	end
	else if(_CS)
		if (_WRITE_DATA)
			case (_ADDR)
				2'b00: mult_in1 <= _DATA_IN;
				2'b01: mult_in2 <= _DATA_IN;
			endcase
		else if (_READ_DATA && _ADDR == 2'b10) DATA_OUT_ = mult_out;
end
endmodule