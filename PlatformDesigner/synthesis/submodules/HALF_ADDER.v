module HALF_ADDER (
output SUM_,CARRY_,
input _A,_B
);
and AND (CARRY_,_A,_B);	//carry = in1 & in2
xor XOR (SUM_,_A,_B);	//sum = in1 ^ in2
endmodule