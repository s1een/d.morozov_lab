library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is

	generic(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 5
	);

	port(
		frq_in     		: in  std_logic;
		sig_b				: in std_logic;
		data_in			: in natural range 0 to 2**ADDR_WIDTH - 1;
		columns_out_t    : out std_logic_vector((DATA_WIDTH -1) downto 0);
		row_out_t      : out std_logic_vector(7 downto 0)
	);

end toplevel;

architecture struct of toplevel is

	component b_controller is

		port(
			clk_in     : in  std_logic;
			button_in  : in  std_logic;
			button_out : out std_logic
		);

	end component b_controller;
	
	component freq_contrl is

	port(
		clk_in			: in  std_logic;
		clk_out_button : out std_logic;
		clk_out_main	: out std_logic;
		clk_out_buffer	: out std_logic;
		clk_out_rgb		: out std_logic
	);

	end component freq_contrl;
	
	component rgb_contrl is

	port(
		clk_in     		: in  std_logic;
		rgb_in 	  		: in std_logic_vector (7 downto 0);
		
		columns_out    : out std_logic_vector((DATA_WIDTH -1) downto 0);
		row1_out       : out std_logic_vector(7 downto 0)
	);

	end component rgb_contrl;
	
	component buffer_strg is
	
	port 
	(
		clk	  : in std_logic;
		addr    : in natural range 0 to 2**ADDR_WIDTH - 1;
		columns : out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

	end component;
	
	component main is

	port(
		clk_in          : in  std_logic;
		button_in       : in  std_logic;		
		rgb_in			 : in std_logic_vector(7 downto 0);
		--nios            : in  std_logic_vector(31 downto 0);
		--nios2           : in  std_logic_vector(31 downto 0);
		--nios3           : in  std_logic_vector(31 downto 0);
		rgb_out			 : out std_logic_vector(7 downto 0)
	);

	end component main;
	
	signal button_out : std_logic;
	signal clk_out_button, clk_out_main, clk_out_buffer, clk_out_rgb : std_logic;
	signal rgb_out, columns		:  std_logic_vector(7 downto 0);
	
	begin
		z1: b_controller

		port map(
			clk_in     => clk_out_button,
			button_in  => sig_b,
			button_out => button_out
		);
		
		z2: freq_contrl

		port map(
			clk_in			=> frq_in,
			clk_out_button => clk_out_button ,
			clk_out_main	=> clk_out_main	,
			clk_out_buffer  => clk_out_buffer,
			clk_out_rgb		=> clk_out_rgb		
		);
		
		z3: rgb_contrl

		port map(
			clk_in     		=> clk_out_rgb,
			rgb_in 	  		=> rgb_out,		
			columns_out    => columns_out_t,
			row1_out       => row_out_t
		);
		
		z4: buffer_strg
		
		port map(
			clk	  => clk_out_buffer,
			addr    => data_in,
			columns => columns
		);
		
		z5: main

		port map(
			clk_in          => clk_out_main,
			button_in       => button_out,		
			rgb_in			 => columns,
			--nios            : in  std_logic_vector(31 downto 0);
			--nios2           : in  std_logic_vector(31 downto 0);
			--nios3           : in  std_logic_vector(31 downto 0);
			rgb_out			 => rgb_out
		);

end architecture;