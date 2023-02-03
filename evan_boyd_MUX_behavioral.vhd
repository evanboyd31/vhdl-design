library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity evan_boyd_MUX_behavioral is
	Port (A : in std_logic;
			B : in std_logic;
			S : in std_logic;
			Y : out std_logic);
end evan_boyd_MUX_behavioral;

architecture behavioral of evan_boyd_MUX_behavioral is
begin  
	with S select
		Y <= A when '0',
			  B when '1',
			  'X' when others;
end behavioral;