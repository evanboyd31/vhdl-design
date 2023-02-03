library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity evan_boyd_counter is
Port(enable : in std_logic;
reset : in std_logic;
clk : in std_logic;
count : out std_logic_vector(2 downto 0));
end evan_boyd_counter;

architecture behavior of evan_boyd_counter is
signal count_temp : std_logic_vector(2 downto 0) := "000";
begin
process(count_temp,clk, reset, enable)
begin
	if reset = '0' then
		count_temp <= "000";
	elsif RISING_EDGE(clk) then
		if enable = '1' then
			if count_temp = "111" then
				count_temp <= "000";
			else
				count_temp <= count_temp + "001";
			end if;
		end if;
	else
		count_temp <= count_temp;
	end if;
end process;

count <= count_temp;

end behavior;
