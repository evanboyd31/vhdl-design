library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity evan_boyd_barrel_shifter_behavioral is
	Port (X : in std_logic_vector(3 downto 0);
			sel : in std_logic_vector(1 downto 0);
			Y : out std_logic_vector(3 downto 0));
end evan_boyd_barrel_shifter_behavioral;

architecture barrel_shifter_behavioral of evan_boyd_barrel_shifter_behavioral is
	begin
		with sel select
			Y <= X when "00",
					(X(2) & X(1) & X(0) & X(3)) when "01",
					(X(1) & X(0) & X(3) & X(2)) when "10",
					(X(0) & X(3) & X(2) & X(1)) when "11",
					"----" when others;
end barrel_shifter_behavioral;