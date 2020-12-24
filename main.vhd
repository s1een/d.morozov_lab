library ieee;
use ieee.std_logic_1164.all;

entity main is

	port(
		clk_in          : in  std_logic;
		button_in       : in  std_logic;		
		rgb_in			 : in std_logic_vector(7 downto 0);
		--nios            : in  std_logic_vector(31 downto 0);
		--nios2           : in  std_logic_vector(31 downto 0);
		--nios3           : in  std_logic_vector(31 downto 0);
		rgb_out			 : out std_logic_vector(7 downto 0)
	);

end main;

architecture rtl of main is
 
 signal rgb :std_logic_vector(7 downto 0) := "00000000";
 
begin
		process(clk_in, button_in, rgb_in)
		begin
		
				if (rising_edge(button_in)) then
					rgb(7 downto 0) <= rgb_in(7 downto 0);
				end if;
		end process;
		rgb_out <= rgb;
end rtl;
