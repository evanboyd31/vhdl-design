library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity bcd_adder_behavioral is
port(A: in std_logic_vector(3 downto 0);
	  B: in std_logic_vector(3 downto 0);
	  S: out std_logic_vector(3 downto 0);
     C: out std_logic);
end bcd_adder_behavioral;

architecture behavioral of bcd_adder_behavioral is
	signal binarySum : std_logic_vector(4 downto 0);
	signal binarySumPlus6 : std_logic_vector(4 downto 0);
begin
	binarySum <= ('0' & A) + ('0' & B);
	binarySumPlus6 <= binarySum + std_logic_vector(to_unsigned(6, 4));
	
	S <= "----" when (A > "1001") or (B > "1001") else
		  (binarySum(3) & binarySum(2) & binarySum(1) & binarySum(0)) when binarySum <= std_logic_vector(to_unsigned(9, 5)) else
		  (binarySumPlus6(3) & binarySumPlus6(2) & binarySumPlus6(1) & binarySumPlus6(0)) when (binarySum <= std_logic_vector(to_unsigned(18, 5))         and binarySum > std_logic_vector(to_unsigned(9, 5))) else
			"----";
			
	C <= '-' when (A > "1001") or (B > "1001") else 
		  '0' when binarySum <= std_logic_vector(to_unsigned(9, 5)) else
		  '1' when binarySum <= std_logic_vector(to_unsigned(18, 5)) and binarySum > std_logic_vector(to_unsigned(9, 5)) else
		  '-';

end behavioral;