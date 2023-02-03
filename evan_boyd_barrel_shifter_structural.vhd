library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity evan_boyd_barrel_shifter_structural is
Port (X : in std_logic_vector(3 downto 0);
		sel : in std_logic_vector(1 downto 0);
		Y : out std_logic_vector(3 downto 0));
end evan_boyd_barrel_shifter_structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity evan_boyd_MUX_structural is
	Port (x1 : in std_logic;
			x2 : in std_logic;
			S : in std_logic;
			F : out std_logic);
end evan_boyd_MUX_structural;

architecture MUX_structural of evan_boyd_MUX_structural is
	begin 
		F <= (x1 and (not S)) or (x2 and S);
end MUX_structural;

architecture barrel_shifter_structural of evan_boyd_barrel_shifter_structural is
	component evan_boyd_MUX_structural
	Port (x1 : in std_logic;
			x2 : in std_logic;
			S : in std_logic;
			F : out std_logic);
	end component;
	signal f1, f2, f3, f4 : std_logic;
	begin
	MUX_1 : evan_boyd_MUX_structural port map (X(0), X(2), sel(1), f1);
	MUX_2 : evan_boyd_MUX_structural port map (X(1), X(3), sel(1), f2);
	MUX_3 : evan_boyd_MUX_structural port map (X(2), X(0), sel(1), f3);
	MUX_4 : evan_boyd_MUX_structural port map (X(3), X(1), sel(1), f4);
	MUX_5 : evan_boyd_MUX_structural port map (f1, f4, sel(0), Y(0));
	MUX_6 : evan_boyd_MUX_structural port map (f2, f1, sel(0), Y(1));
	MUX_7 : evan_boyd_MUX_structural port map (f3, f2, sel(0), Y(2));
	MUX_8 : evan_boyd_MUX_structural port map (f4, f3, sel(0), Y(3));
end barrel_shifter_structural;