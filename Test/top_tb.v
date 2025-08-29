`timescale 1ps/1ps
module top_tb;
    wire [27:0] I_top;
    wire [27:0] T_top;
    reg [27:0] O_top = 0;
    wire [55:0] A_cfg, B_cfg;

    reg CLK = 1'b0;
    reg resetn = 1'b1;
    reg SelfWriteStrobe = 1'b0;
    reg [31:0] SelfWriteData = 1'b0;
    reg Rx = 1'b1;
    wire ComActive;
    wire ReceiveLED;
    reg s_clk = 1'b0;
    reg s_data = 1'b0;

    // Instantiate both the fabric and the reference DUT
    eFPGA_top top_i (
        .I_top(I_top),
        .T_top(T_top),
        .O_top(O_top),
        .A_config_C(A_cfg), .B_config_C(B_cfg),
        .CLK(CLK), .resetn(resetn),
        .SelfWriteStrobe(SelfWriteStrobe), .SelfWriteData(SelfWriteData),
        .Rx(Rx),
        .ComActive(ComActive),
        .ReceiveLED(ReceiveLED),
        .s_clk(s_clk),
        .s_data(s_data)
    );




    localparam MAX_BITBYTES = 16384;
    reg [7:0] bitstream[0:MAX_BITBYTES-1];

    always #5000 CLK = (CLK === 1'b0);

    integer i;
    reg have_errors = 1'b0;

    reg [2047:0] bitstream_hex_arg; // 256 bytes for characters
    reg [2047:0] output_waveform_arg; // 256 bytes for characters
    initial begin

        if ($value$plusargs("output_waveform=%s", output_waveform_arg)) begin
            $dumpfile(output_waveform_arg);
            $dumpvars(0, top_tb);
            $display("Output waveform set to %s", output_waveform_arg);
        end

`ifndef EMULATION

        if ($value$plusargs("bitstream_hex=%s", bitstream_hex_arg)) begin
            $readmemh(bitstream_hex_arg, bitstream);
            $display("Read bitstream hex from %s", bitstream_hex_arg);
        end else begin
            $display("Error: No bitstream provided as $plusargs bitstream_hex.");
            $fatal;
        end


        #100;
        resetn = 1'b0;
        #10000;
        resetn = 1'b1;
        #10000;
        repeat (20) @(posedge CLK);
        #2500;
        for (i = 0; i < MAX_BITBYTES; i = i + 4) begin
            SelfWriteData <= {bitstream[i], bitstream[i+1], bitstream[i+2], bitstream[i+3]};
            repeat (2) @(posedge CLK);
            SelfWriteStrobe <= 1'b1;
            @(posedge CLK);
            SelfWriteStrobe <= 1'b0;
            repeat (2) @(posedge CLK);
        end
`endif
        repeat (100) @(posedge CLK);
        // Enable and reset the counter
        O_top = 28'b1000_0000_0000_0000_0000_0000_0000;
        repeat (5) @(posedge CLK);
        // Deassert reset while keeping the counter enabled
        O_top = 28'b0000_0000_0000_0000_0000_0000_0000;
        for (i = 0; i < 10000; i = i + 1) begin
            @(negedge CLK);
        end

        if (have_errors)
            $fatal;
        else
            $finish;
    end

endmodule

