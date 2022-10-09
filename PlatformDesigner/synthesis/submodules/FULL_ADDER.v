module FULL_ADDER (
output SUM_,COUT_,
input _A,_B,_CIN
);
wire cout1,cout2,sout1;
HALF_ADDER HA1 (sout1,cout1,_A,_B);
HALF_ADDER HA2 (SUM_,cout2,sout1,_CIN);
or OR (COUT_,cout1,cout2);
endmodule