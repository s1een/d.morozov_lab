library ieee;
use ieee.std_logic_1164.all;

entity mg_frequency is

	generic
	(
		FREQ_IN  : natural := 50_000_000;
		FREQ_OUT : natural := 1_000_000 
		
	);

	port(
		clk_in	: in  std_logic;
		clk_out  : out std_logic	
	);

end mg_frequency ;

architecture rtl of mg_frequency is

	signal clk_reg : std_logic := '0';
begin
	process (clk_in ) is
		variable counter : natural := 0;
	begin
		if(rising_edge(clk_in)) then
			--rising_edge - обнаруживает нарастающий фронт сигнала. возвращает 1, когда сигнал изменится с низкого значения на высокое значение.
			if(counter = ((FREQ_IN  / 2) / FREQ_OUT) - 1) then
				clk_reg <= not clk_reg;
				counter := 0;
			else
				counter := counter + 1;
			end if;
		end if;
	end process;
	clk_out  <= clk_reg;
end rtl;