library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.numeric_std.all;

entity counter is 
    port 
    ( 
        clk         : in std_logic;            
		
		  
        cnt_out     : out std_logic_vector(2 downto 0)            
    ); 
 
end counter; 
 
architecture rtl of counter is 
   signal a: unsigned (2 downto 0):= "000";
 
begin 

	cnt_out <= std_logic_vector(a);
	
	process(clk)
		
	begin
	
		if(rising_edge(clk)) then
			a <= a + "001";
		end if;
	
	end process;
 
end rtl;