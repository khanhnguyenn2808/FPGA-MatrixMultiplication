#include <stdio.h>
#include <unistd.h>
#include <system.h>
#include <stdlib.h>
#include <stdint.h>

volatile unsigned* matrix_ptr = (unsigned*)MATRIX_MULT_0_BASE;
#define matrix_inA *matrix_ptr
#define matrix_inB *(matrix_ptr+1)
#define matrix_out *(matrix_ptr+2)

void inputMatrix(uint8_t** matrix, unsigned rows, unsigned cols)
{
	unsigned tmp;
	for(int i = 0; i < rows; i++)
	{
		for(int j = 0; j < cols; j++)
		{
			printf("[%i][%i]: ",i,j);
			scanf("%u",&tmp);
			matrix[i][j] = (uint8_t)tmp;
		}
	}
	printf("DONE!\n");
}

void printMatrix(unsigned rows, unsigned cols, unsigned matrix[][cols])
{
	for (int i = 0; i < rows; ++i)
	{
		for (int j = 0; j < cols; ++j)
		{
			usleep(1000);
			printf("[%u][%u]= %u ",i,j,matrix[i][j]);

		}
		printf("\n");
	}
}

unsigned mergeBits(unsigned a, unsigned b, unsigned c, unsigned d)
{
	return (a<<8*3 | b<<8*2 | c<<8 | d);
}

void multMatrix(unsigned rows, unsigned cols, uint8_t matrixA[][cols], uint8_t matrixB[][cols], unsigned matrixRe[][cols])
{
	unsigned tmp1,tmp2,tmp3;
	for (int i = 0; i < rows; ++i) {
		for (int j = 0; j < cols; ++j) {
			tmp1 = mergeBits(matrixA[i][0],matrixA[i][1],matrixA[i][2],matrixA[i][3]);
			matrix_inA = tmp1;
			tmp2 = mergeBits(matrixB[0][j],matrixB[1][j],matrixB[2][j],matrixB[3][j]);
			matrix_inB = tmp2;
			tmp3 = matrix_out;
			matrixRe[i][j] = tmp3;
			usleep(10000);
		}
	}
}

int main()
{
	printf("Hello from Nios II!\n");
	uint8_t matrixA[4][4] =
			{{4,4,4,4},
			{4,4,4,4},
			{4,4,4,4},
			{4,4,4,4}},
			matrixB[4][4] =
			{{4,4,4,4},
			{4,4,4,4},
			{4,4,4,4},
			{4,4,4,4}};
	unsigned C[4][4];
	unsigned tmp1,tmp2,tmp3,tmp4;
	for(int i=0;i<4;i++)
	{
		for(int j=0;j<4;j++)
		{
			tmp1 = mergeBits(0,0,0,0);
			matrix_inA = tmp1;
			tmp2 = mergeBits(0,0,0,0);
			tmp3 = matrix_out;
			tmp1 = mergeBits(matrixA[i][0], matrixA[i][1], matrixA[i][2], matrixA[i][3]);
			matrix_inA = tmp1;
			tmp2 = mergeBits(matrixB[0][j], matrixB[1][j], matrixB[2][j], matrixB[3][j]);
			matrix_inB = tmp2;
			tmp3 = matrix_out;
			usleep(100);
			tmp3 = matrix_out;
			printf("[%i][%i]=%u\t",i,j, tmp3);
		}
		printf("\n");
	}
	return 0;
}
