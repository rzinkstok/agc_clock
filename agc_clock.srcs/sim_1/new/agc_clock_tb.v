`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2019 01:39:08 PM
// Design Name: 
// Module Name: agc_clock_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module agc_clock_tb();
    reg clk=0;
    reg rst_n=1;
    
    wire prop_clk;
    wire prop_clk_locked;
    wire agc_clk;

    // Zynq PS
    wire [14:0]DDR_addr;
    wire [2:0]DDR_ba;
    wire DDR_cas_n;
    wire DDR_ck_n;
    wire DDR_ck_p;
    wire DDR_cke;
    wire DDR_cs_n;
    wire [3:0]DDR_dm;
    wire [31:0]DDR_dq;
    wire [3:0]DDR_dqs_n;
    wire [3:0]DDR_dqs_p;
    wire DDR_odt;
    wire DDR_ras_n;
    wire DDR_reset_n;
    wire DDR_we_n;
    wire FIXED_IO_ddr_vrn;
    wire FIXED_IO_ddr_vrp;
    wire [53:0]FIXED_IO_mio;
    wire FIXED_IO_ps_clk;
    wire FIXED_IO_ps_porb;
    wire FIXED_IO_ps_srstb;
    
    always
		#5 clk = !clk;
    
    agc_clock c(
        clk,
        rst_n,
        prop_clk,
        prop_clk_locked,
        agc_clk,
        DDR_addr,
        DDR_cas_n,
        DDR_ck_n,
        DDR_ck_p,
        DDR_cke,
        DDR_cs_n,
        DDR_dm,
        DDR_dq,
        DDR_dqs_n,
        DDR_dqs_p,
        DDR_odt,
        DDR_ras_n,
        DDR_reset_n,
        DDR_we_n,
        FIXED_IO_ddr_vrn,
        FIXED_IO_ddr_vrp,
        FIXED_IO_mio,
        FIXED_IO_ps_clk,
        FIXED_IO_ps_porb,
        FIXED_IO_ps_srstb
    );
    
    initial
	begin
		#100000 $stop;
	end
    
endmodule
