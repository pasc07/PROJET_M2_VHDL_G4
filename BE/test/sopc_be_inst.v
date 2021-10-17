	sopc_be u0 (
		.clk_clk                             (<connected-to-clk_clk>),                             //                          clk.clk
		.gpio_in_external_connection_export  (<connected-to-gpio_in_external_connection_export>),  //  gpio_in_external_connection.export
		.gpio_out_external_connection_export (<connected-to-gpio_out_external_connection_export>), // gpio_out_external_connection.export
		.uart_external_connection_rxd        (<connected-to-uart_external_connection_rxd>),        //     uart_external_connection.rxd
		.uart_external_connection_txd        (<connected-to-uart_external_connection_txd>)         //                             .txd
	);

