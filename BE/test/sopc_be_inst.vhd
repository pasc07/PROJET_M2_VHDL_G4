	component sopc_be is
		port (
			clk_clk                             : in  std_logic                    := 'X';             -- clk
			gpio_in_external_connection_export  : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			gpio_out_external_connection_export : out std_logic_vector(7 downto 0);                    -- export
			uart_external_connection_rxd        : in  std_logic                    := 'X';             -- rxd
			uart_external_connection_txd        : out std_logic                                        -- txd
		);
	end component sopc_be;

	u0 : component sopc_be
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			gpio_in_external_connection_export  => CONNECTED_TO_gpio_in_external_connection_export,  --  gpio_in_external_connection.export
			gpio_out_external_connection_export => CONNECTED_TO_gpio_out_external_connection_export, -- gpio_out_external_connection.export
			uart_external_connection_rxd        => CONNECTED_TO_uart_external_connection_rxd,        --     uart_external_connection.rxd
			uart_external_connection_txd        => CONNECTED_TO_uart_external_connection_txd         --                             .txd
		);

