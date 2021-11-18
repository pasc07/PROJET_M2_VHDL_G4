
module sopc_be (
	clk_clk,
	gpio_in_external_connection_export,
	gpio_out_external_connection_export,
	uart_external_connection_rxd,
	uart_external_connection_txd,
	avalon_pwm_0_conduit_end_response);	

	input		clk_clk;
	input	[7:0]	gpio_in_external_connection_export;
	output	[7:0]	gpio_out_external_connection_export;
	input		uart_external_connection_rxd;
	output		uart_external_connection_txd;
	output		avalon_pwm_0_conduit_end_response;
endmodule
