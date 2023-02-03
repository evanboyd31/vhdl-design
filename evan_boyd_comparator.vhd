library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity evan_boyd_comparator is
Port ( A, B : in std_logic_vector(3 downto 0) ;
AgtBplusOne : out std_logic;
AgteBplusOne : out std_logic;
AltBplusOne : out std_logic;
AlteBplusOne : out std_logic;
AeqBplusOne : out std_logic;
overflow : out std_logic);
end evan_boyd_comparator;

architecture comparator of evan_boyd_comparator is
signal BPlusOne : std_logic_vector(4 downto 0);
signal ALength5 : std_logic_vector(4 downto 0);
begin
	BPlusOne <= ('0' & B) + std_logic_vector(to_unsigned(1, 5));
	ALength5 <= '0' & A;
	process (ALength5, BPlusOne)
	begin
		AgtBplusOne <= '0';
		AgteBplusOne <= '0';
		AlteBplusOne <= '0';
		AltBplusOne <= '0';
		AeqBplusOne <= '0';
		overflow <= BPlusOne(4);
		if BPlusOne(4) /= '1' then
			if unsigned(ALength5) = unsigned(BPlusOne) then
				AeqBplusOne <= '1';
			end if;
			if unsigned(ALength5) <= unsigned(BPlusOne) then
				AlteBPlusOne <= '1';
			end if;
			if unsigned(ALength5) >= unsigned(BPlusOne) then
				AgteBplusOne <= '1';
			end if;
			if unsigned(ALength5) > unsigned(BPlusOne) then
				AgtBplusOne <= '1';
			end if;
			if unsigned(ALength5) < unsigned(BPlusOne) then
				AltBplusOne <= '1';
			end if;
		end if;
		
		
	end process;

end comparator;