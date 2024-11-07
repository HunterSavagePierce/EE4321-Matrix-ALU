///////////////////////////////////////////////////////////////////////////////
// Project: Matrix ALU
// Author: Hunter Savage-Pierce
// Date: November 6th, 2024
// Version: 1.0
///////////////////////////////////////////////////////////////////////////////
// Description:
// Top File for a Custom Matrix Alu
//
// References:
// - Mark W. Welker EE4321 Matrix Alu Supplied Code Texas State University
// - ChatGPT 4o
///////////////////////////////////////////////////////////////////////////////
module top ();

logic [255:0] MemDataOut;
logic [255:0] MatrixDataOut;
logic [255:0] TestDataOut;    // this was missign from the example you need to understand not just copy


logic nRead,nWrite,nReset,Clk;
logic [15:0] address;


MainMemory  U2(Clk, MemDataOut, TestDataOut, address, nRead,nWrite, nReset);

MatrixAlu  U4(Clk,MatrixDataOut,TestDataOut, address, nRead,nWrite, nReset);

TestMatrix  UTEST(Clk,MemDataOut,MatrixDataOut,TestDataOut, address, nRead,nWrite,nReset);

endmodule


	
	

