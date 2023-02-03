library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity evan_boyd_MUX_structural is
	Port (A : in std_logic;
			B : in std_logic;
			S : in std_logic;
			Y : out std_logic);
end evan_boyd_MUX_structural;

architecture structural of evan_boyd_MUX_structural is
	begin 
		Y <= (A and (not S)) or (B and S);
end structural;