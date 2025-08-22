module top(input wire clk, input wire [23:0] io_in, output wire [23:0] io_out, io_oeb);
	localparam OUTPUT_ENABLE = 1'b1;
	localparam OUTPUT_DISABLE = 1'b0;

	localparam PIN_RESET = 23;
	localparam PIN_ENABLE = 22;

    localparam PIN_SWITCH = 11;
    localparam PIN_BUTTON = 10;

    localparam NUM_UPPER_LED_PINS = PIN_ENABLE  - 1 - PIN_SWITCH;
    localparam NUM_LOWER_LED_PINS = PIN_BUTTON ;

    localparam COUNTER_MAX_OUTPUT_BIT = 25;


	wire rst_n = io_in[PIN_RESET];
	wire en = io_in[PIN_ENABLE];
	reg [31:0] ctr;



	always @(posedge clk)
		if (rst_n)
			ctr <= 'b0;
		else
			if (en)
				ctr <= ctr + 1'b1;
			else
				ctr <= ctr;

	//assign io_out[PIN_ENABLE-1:0] = ctr[PIN_ENABLE-1:0]}}; // simuation target
 
    // FPGA target
	assign io_out[PIN_ENABLE-1:PIN_SWITCH + 1] = ctr[COUNTER_MAX_OUTPUT_BIT:COUNTER_MAX_OUTPUT_BIT-NUM_UPPER_LED_PINS + 1];
	assign io_oeb[PIN_ENABLE-1:PIN_SWITCH + 1] = {NUM_UPPER_LED_PINS {OUTPUT_ENABLE}};

    assign io_out[PIN_BUTTON-1:0] = ctr[COUNTER_MAX_OUTPUT_BIT:COUNTER_MAX_OUTPUT_BIT-NUM_LOWER_LED_PINS + 1]; 
    assign io_oeb[PIN_BUTTON-1:0] = {NUM_LOWER_LED_PINS {OUTPUT_ENABLE}};

	assign io_oeb[PIN_RESET] = OUTPUT_DISABLE;
	assign io_oeb[PIN_ENABLE] = OUTPUT_DISABLE;
	assign io_oeb[PIN_SWITCH] = OUTPUT_DISABLE;
	assign io_oeb[PIN_BUTTON] = OUTPUT_DISABLE;
endmodule
