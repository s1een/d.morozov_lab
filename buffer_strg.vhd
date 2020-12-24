library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity buffer_strg is

	generic 
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 5
	);

	port 
	(
		clk	  : in std_logic;
		addr    : in natural range 0 to 2**ADDR_WIDTH - 1;
		columns : out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end entity;

architecture rtl of buffer_strg is

	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(0 to 2**ADDR_WIDTH-1) of word_t;

	function init_rom
		return memory_t is 
		variable tmp : memory_t := (others => (others => '0'));
	begin 
		for addr_pos in 0 to 2**ADDR_WIDTH - 1 loop 
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, DATA_WIDTH));
		end loop;
		return tmp;
	end init_rom;	 

	signal rom : memory_t := (
		"10100000","10100001","10101000","10110000",
		"01010000","01010010","01010100","01010010",
		"00101000","00101100","00101010","00111000",
		"00010100","00011100","00010101","00010100",
		"00001010","00011010","10001010","00011010",
		"00000101","00100101","01000101","00010101",
		"00000010","01000010","00100010","00010010",
		"00000001","10000001","00010001","00010001"
	);

begin

	process(clk)
	begin
	if(rising_edge(clk)) then
		columns <= rom(addr);
	end if;
	end process;

end rtl;
