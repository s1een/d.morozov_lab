library ieee;
use ieee.std_logic_1164.all;

entity rgb_contrl is

	generic(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 5
	);

	port(
		clk_in     		: in  std_logic;
		rgb_in 	  		: in std_logic_vector (7 downto 0);
		
		columns_out    : out std_logic_vector((DATA_WIDTH -1) downto 0);
		row1_out       : out std_logic_vector(7 downto 0)
	);

end rgb_contrl;

architecture rtl of rgb_contrl is
	component decoder is
			port(
				addr : in std_logic_vector(2 downto 0);
		
				row1 : out std_logic_vector(7 downto 0)
			);
	end component decoder;
	
	component counter is
			port(
				clk         : in std_logic;            
		  
				cnt_out     : out std_logic_vector(2 downto 0)
			);
	end component counter;
	
	component buffer_out is
			port(
				clk	  : in std_logic_vector(2 downto 0);
				data    : in std_logic_vector (7 downto 0);
				columns : out std_logic_vector((DATA_WIDTH -1) downto 0)
			);
	end component buffer_out;

	signal clk_counter    : std_logic_vector(2 downto 0);

begin
	l_counter : counter
		port map(
			clk           => clk_in,
			cnt_out       => clk_counter
		);
	l_decoder : decoder
		port map(
			addr => clk_counter,		
			row1 => row1_out
		);	
	l_buffer_out : buffer_out
		port map(
			clk	  => clk_counter,	
			data    => rgb_in,
			columns => columns_out
		);

end rtl;
