`timescale 1ns / 1ps

module agc_clock(
    input wire clk,
    input wire reset,
    output wire prop_clk,
    output wire prop_clk_locked,
    output wire agc_clk,

    output wire CLK,
    output wire MT01,
    output wire MT02,
    output wire MT03,
    output wire MT04,
    output wire MT05,
    output wire MT06,
    output wire MT07,
    output wire MT08,
    output wire MT09,
    output wire MT10,
    output wire MT11,
    output wire MT12,

    // Zynq PS
    inout wire [14:0]DDR_addr,
    inout wire [2:0]DDR_ba,
    inout wire DDR_cas_n,
    inout wire DDR_ck_n,
    inout wire DDR_ck_p,
    inout wire DDR_cke,
    inout wire DDR_cs_n,
    inout wire [3:0]DDR_dm,
    inout wire [31:0]DDR_dq,
    inout wire [3:0]DDR_dqs_n,
    inout wire [3:0]DDR_dqs_p,
    inout wire DDR_odt,
    inout wire DDR_ras_n,
    inout wire DDR_reset_n,
    inout wire DDR_we_n,
    inout wire FIXED_IO_ddr_vrn,
    inout wire FIXED_IO_ddr_vrp,
    inout wire [53:0]FIXED_IO_mio,
    inout wire FIXED_IO_ps_clk,
    inout wire FIXED_IO_ps_porb,
    inout wire FIXED_IO_ps_srstb
);
    
    //input wire CLOCK,
    reg SBY = 0; 
    reg ALGA = 0;
    reg MSTRTP = 0;
    reg STRT1 = 0; 
    reg STRT2 = 0; 
    wire GOJ1 = 0;
    reg MSTP = 0;
    reg WL15 = 0;
    reg WL15_ = 1;
    reg WL16 = 0;
    reg WL16_ = 1;
 
    wire PHS2_;
    wire PHS3_;
    wire PHS4;
    wire PHS4_; 
    wire CT;
    wire CT_; 
    wire RT_;
    wire WT_;
    wire TT_; 
    wire MONWT;
    wire Q2A;
    wire P02;
    wire P02_; 
    wire P03;
    wire P03_;
    wire P04_;
    wire F01A; 
    wire F01B; 
    wire FS01;
    wire FS01_;
    wire SB0_;
    wire SB1_;
    wire SB2;
    wire SB2_; 
    wire SB4; 

    wire GOJAM;
    wire STOP;
    wire TIMR;
    wire MSTPIT_; 
    wire MGOJAM;

    wire T01; 
    wire T01_; 
    wire T02;
    wire T02_; 
    wire T03;
    wire T03_; 
    wire T04;
    wire T04_; 
    wire T05;
    wire T05_; 
    wire T06;
    wire T06_; 
    wire T07;
    wire T07_; 
    wire T08;
    wire T08_; 
    wire T09;
    wire T09_; 
    wire T10;
    wire T10_; 
    wire T11;
    wire T11_;
    wire T12; 
    wire T12_;
    wire T12A; 
    wire UNF_;
    wire OVF_;

    reg n0VDCA = 0;
    reg p4VDC = 1;
    reg p4SW = 1;
    //input wire reset
    
    
    prop_clock_divisor prop_clk_div(
        .clk_in1(clk),
        .reset(reset),
        .clk_out1(prop_clk),
        .locked(prop_clk_locked)
    );
    
    agc_clock_divisor agc_clk_div(
        .prop_clk(prop_clk),
        .prop_clk_locked(prop_clk_locked),
        .rst_n(~reset),
        .agc_clk(agc_clk)
    );
    
    
    a02_timer a02(
        // inputs
        agc_clk,
        SBY, 
        ALGA, 
        MSTRTP, 
        STRT1, 
        STRT2, 
        GOJ1, 
        MSTP,
        WL15, 
        WL15_, 
        WL16, 
        WL16_,
    
        // outputs
        CLK,
        PHS2_,
        PHS3_, 
        PHS4, 
        PHS4_, 
        CT, 
        CT_, 
        RT_,
        WT_,
        TT_, 
        MONWT,
        Q2A, 
        P02,
        P02_, 
        P03, 
        P03_,
        P04_,
        F01A, 
        F01B, 
        FS01,
        FS01_,
        SB0_,
        SB1_,
        SB2, 
        SB2_, 
        SB4, 
    
        GOJAM,
        STOP,
        TIMR,
        MSTPIT_, 
        MGOJAM,
    
        T01, 
        T01_, 
        T02,
        T02_, 
        T03,
        T03_, 
        T04,
        T04_, 
        T05,
        T05_, 
        T06,
        T06_, 
        T07,
        T07_, 
        T08,
        T08_, 
        T09,
        T09_, 
        T10,
        T10_, 
        T11,
        T11_,
        T12, 
        T12_,
        T12A,
        MT01,
        MT02, 
        MT03,
        MT04, 
        MT05, 
        MT06, 
        MT07, 
        MT08, 
        MT09, 
        MT10, 
        MT11, 
        MT12, 
        UNF_,
        OVF_,
    
        // inputs
        n0VDCA,
        p4VDC,
        p4SW,
        reset,
        prop_clk
    );
    
    zynq_ps_wrapper zync_ps(
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb)
    );
    
endmodule
