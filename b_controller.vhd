library ieee;
use ieee.std_logic_1164.all;

entity b_controller is

	port(
		clk_in     : in  std_logic;
		button_in  : in  std_logic;
		button_out : out std_logic
	);

end b_controller;

architecture rtl of b_controller is

begin
	process(clk_in, button_in)
		begin
			if (rising_edge(clk_in)) then
				button_out <= button_in;
			end if;
	end process;
end rtl;
