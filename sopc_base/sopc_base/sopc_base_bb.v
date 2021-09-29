
module sopc_base (
	clk_clk,
	cpu_custom_instruction_master_readra,
	leds_external_connection_export,
	boutons_external_connection_export);	

	input		clk_clk;
	output		cpu_custom_instruction_master_readra;
	output	[7:0]	leds_external_connection_export;
	input	[1:0]	boutons_external_connection_export;
endmodule
