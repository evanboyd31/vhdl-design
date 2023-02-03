library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity evan_boyd_clock_divider is
Port( enable: in std_logic;
		reset : in std_logic;
		clk : in std_logic;
		en_out : out std_logic);
end evan_boyd_clock_divider;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity down_counter is 
Port(clock : in std_logic;
	  r: in std_logic;
	  en: in std_logic;
	  output: out integer);
end down_counter;

architecture counter_behavior of down_counter is
signal temp_output: integer := 49999999;
begin
process(temp_output, clock, r, en)
begin
	if r = '0' then
		temp_output <= 49999999;
	elsif RISING_EDGE(clock) then
		if en = '1' then
			if temp_output = 0 then
				temp_output <= 49999999;
			else
				temp_output <= temp_output - 1;
			end if;
		end if;
	else
		temp_output <= temp_output;
	end if;
end process;

output <= temp_output;
end counter_behavior;

architecture divider_behavior of evan_boyd_clock_divider is
component down_counter
port(clock : in std_logic;
	  r : in std_logic;
	  en : in std_logic;
	  output : out integer);
end component;
signal result : integer := 0;
begin
	down1 : down_counter port map(clk, reset, enable, result);
	process(result)
	begin
	
		if result = 0 then
			en_out <= '1';
		else
			en_out <= '0';
		end if;
	
end process;
end divider_behavior;