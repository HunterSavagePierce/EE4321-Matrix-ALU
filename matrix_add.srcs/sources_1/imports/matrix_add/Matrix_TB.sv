///////////////////////////////////////////////////////////////////////////////
// Project: Matrix ALU
// Author: Hunter Savage-Pierce
// Date: November 6th, 2024
// Version: 1.0
///////////////////////////////////////////////////////////////////////////////
// Description:
// Test File for a Custom Matrix Alu
//
// References:
// - Mark W. Welker EE4321 Matrix Alu Supplied Code Texas State University
// - ChatGPT 4o
///////////////////////////////////////////////////////////////////////////////
module TestMatrix  (Clk,MemDataOut,MatrixDataOut,TestDataOut, address, nRead,nWrite,nReset);

	output logic Clk,nReset, nWrite, nRead; // we are driving these signals from here. 
    output logic [15:0] address;
    output logic [255:0]TestDataOut;
    input logic [255:0] MemDataOut,MatrixDataOut;

	initial begin
		Clk = 0;
		nReset = 1;
		nRead = 0; // start with a read
		nWrite = 1;
		address = 0; // point to mainmemory position 0
// each clock is #10 		
	#5 nReset = 0;
	#7 nReset = 1;
	// data is on memdata out
	#10 TestDataOut = MemDataOut;
	      nRead = 1;
	      nWrite = 0; // Put it in the matrix S0
	      address[15:12] = AluEn;
	      address [11:0] = 0;
	#10 TestDataOut = MemDataOut; // get second matrix
	      nRead = 0;
	      nWrite = 1; 
	      address[15:12] = MainMemEn;
	      address [11:0] = 1;
	       
	#10 TestDataOut = MemDataOut;
	      nRead = 1;
	      nWrite = 0; // Put it in the matrix S1
	      address[15:12] = AluEn;
	      address [11:0] = 1;
    // kill time to allow write to work
    #10     nWrite = 1;
     // tell matrix to do the add.
	#10 TestDataOut = 3; // 
	      nRead = 1;
	      nWrite = 0; // Put it in the matrix Status in
	      address[15:12] = AluEn;
	      address [11:0] = 3;
	#10   nWrite = 1; // allow write to work and matrix to do the add
    #10   nRead=0; // get the result
	      address[15:12] = AluEn;
	      address [11:0] = 2;
	 #10  TestDataOut = MatrixDataOut; // {ut it in memory 
	       address[15:12] = 0;
	       address[11:0] = 2;
	       nWrite = 0;
   
	 #10 nWrite = 1;
	 #10 $finish;      
	
	
	
	end
	// Now start the transfers
	// Get S0 where it belongs





	always  #5 Clk = ~Clk;

	
	endmodule
