library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity evan_boyd_counter_wrapper is
Port (enable : in std_logic;
reset : in std_logic;
clk : in std_logic;
HEX0 : out std_logic_vector(6 downto 0));
end evan_boyd_counter_wrapper;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_decoder is
port(code : in std_logic_vector(3 downto 0) ;
    segments_out : out std_logic_vector(6 downto 0));
end seven_segment_decoder;

architecture decoder of seven_segment_decoder is
begin
WITH code SELECT
segments_out <=
"1000000" WHEN "0000", -- 0
"1111001" WHEN "0001", -- 1
"0100100" WHEN "0010", -- 2
"0110000" WHEN "0011", -- 3
"0011001" WHEN "0100", -- 4
"0010010" WHEN "0101", -- 5
"0000010" WHEN "0110", -- 6
"1111000" WHEN "0111", -- 7
"0000000" WHEN "1000", -- 8
"0010000" WHEN "1001", -- 9
"1111111" WHEN others;
end decoder;

architecture behavior of evan_boyd_counter_wrapper is
component evan_boyd_counter
	port(enable : in std_logic;
		  reset : in std_logic;
		  clk : in std_logic;
		  count : out std_logic_vector(2 downto 0));
end component;

component evan_boyd_clock_divider
	port(enable : in std_logic;
		  reset : in std_logic;
		  clk : in std_logic;
		  en_out : out std_logic);
end component;

component seven_segment_decoder
port(code : in std_logic_vector(3 downto 0);
	  segments_out : out std_logic_vector(6 downto 0));
end component;
signal temp_clock : std_logic;
signal temp_vector : std_logic_vector(2 downto 0);
signal temp_vector_length_4 : std_logic_vector(3 downto 0);
begin
	
	div : evan_boyd_clock_divider port map(enable, reset, clk, temp_clock);
	count : evan_boyd_counter port map(enable, reset, temp_clock, temp_vector);
	temp_vector_length_4 <= '0' & temp_vector;
	ss7 : seven_segment_decoder port map(temp_vector_length_4, HEX0);
	
end behavior;
