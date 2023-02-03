library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity evan_boyd_jkff is
Port ( clk : in std_logic;
J : in std_logic;
K : in std_logic;
Q : out std_logic);
end evan_boyd_jkff;

architecture behavior of evan_boyd_jkff is
signal QT : std_logic := '0';
begin
	process (clk)
	begin
	if RISING_EDGE(clk) then
		if J = '0' and K = '0' then
			QT <= QT;
		elsif J = '1' and K = '0' then
			QT <= '1';
		elsif J = '0' and K = '1' then
			QT <= '0';
		elsif J = '1' and K = '1' then
			QT <= not(QT);
		end if;
	end if;
	end process;
	Q <= QT;
end behavior;