module top(input wire clk, input wire [23:0] io_in, output wire [23:0] io_out, io_oeb);
	localparam OUTPUT_ENABLE = 1'b1;
	localparam OUTPUT_DISABLE = 1'b0;

	localparam PIN_RESET = 23;
	localparam PIN_ENABLE = 22;
	localparam NUM_LED_PINS = 22;

	wire rst_n = io_in[PIN_RESET];
	wire en = io_in[PIN_ENABLE];
	reg [31:0] ctr;

	always @(posedge clk)
		if (!rst_n)
			ctr <= 'b0;
		else
			if (en)
				ctr <= ctr + 1'b1;
			else
				ctr <= ctr;

	//assign io_out[PIN_ENABLE-1:0] = {NUM_LED_PINS{ctr[20]}}; // eFPGA target
	assign io_out[PIN_ENABLE-1:0] = ctr[NUM_LED_PINS-1:0]; // simulation target
	assign io_oeb[PIN_ENABLE-1:0] = {NUM_LED_PINS{OUTPUT_ENABLE}};
	assign io_oeb[PIN_RESET] = OUTPUT_DISABLE;
	assign io_oeb[PIN_ENABLE] = OUTPUT_DISABLE;
    // assign io_out[PIN_RESET] = 1'b0;
    // assign io_out[PIN_ENABLE] = 1'b0;
endmodule
