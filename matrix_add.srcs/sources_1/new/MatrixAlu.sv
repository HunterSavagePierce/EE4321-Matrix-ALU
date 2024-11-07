///////////////////////////////////////////////////////////////////////////////
// Project: Matrix ALU
// Author: Hunter Savage-Pierce
// Date: November 6th, 2024
// Version: 1.0
///////////////////////////////////////////////////////////////////////////////
// Description:
// Implementation File for a Custom Matrix Alu
//
// References:
// - Mark W. Welker EE4321 Matrix Alu Supplied Code Texas State University
// - ChatGPT 4o
///////////////////////////////////////////////////////////////////////////////
module MatrixAlu(Clk, Dataout, DataIn, address, nRead, nWrite, nReset);

    input logic [255:0] DataIn; // from the CPU
    input logic nRead, nWrite, nReset, Clk;
    input logic [15:0] address;

    output logic [255:0] Dataout; // to the CPU 

    logic [15:0] matrix_s0[15:0];
    logic [15:0] matrix_s1[15:0];
    logic [15:0] matrix_result[15:0];

    always_ff @(negedge Clk or negedge nReset) begin
        if (~nReset) begin
            Dataout <= 256'h0;
        end else begin 
            if (address[15:12] == AluEn) begin
                if (~nWrite && address[11:0] == 0) begin
                    // Load first matrix into matrix_s0
                    {matrix_s0[15], matrix_s0[14], matrix_s0[13], matrix_s0[12],
                     matrix_s0[11], matrix_s0[10], matrix_s0[9], matrix_s0[8],
                     matrix_s0[7], matrix_s0[6], matrix_s0[5], matrix_s0[4],
                     matrix_s0[3], matrix_s0[2], matrix_s0[1], matrix_s0[0]} <= DataIn;
                end else if (~nWrite && address[11:0] == 1) begin
                    // Load second matrix into matrix_s1
                    {matrix_s1[15], matrix_s1[14], matrix_s1[13], matrix_s1[12],
                     matrix_s1[11], matrix_s1[10], matrix_s1[9], matrix_s1[8],
                     matrix_s1[7], matrix_s1[6], matrix_s1[5], matrix_s1[4],
                     matrix_s1[3], matrix_s1[2], matrix_s1[1], matrix_s1[0]} <= DataIn;
                end else if (~nWrite && address[11:0] == 3) begin
                    // Perform element-wise addition of the two matrices
                    for (int i = 0; i < 16; i++) begin
                        matrix_result[i] <= matrix_s0[i] + matrix_s1[i];
                    end 
                end else if (~nRead && address[11:0] == 2) begin
                    // Write result to Dataout when address points to result location
                    Dataout <= {matrix_result[15], matrix_result[14], matrix_result[13], matrix_result[12],
                                matrix_result[11], matrix_result[10], matrix_result[9], matrix_result[8],
                                matrix_result[7], matrix_result[6], matrix_result[5], matrix_result[4],
                                matrix_result[3], matrix_result[2], matrix_result[1], matrix_result[0]};
                end
            end 
        end
    end

endmodule