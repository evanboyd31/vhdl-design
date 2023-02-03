library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity full_adder is
port (a: in std_logic;
		b: in std_logic;
		c_in: in std_logic;
		s: out std_logic;
		c_out : out std_logic);
end full_adder;

architecture structural of full_adder is
	begin
		s <= c_in xor (a xor b);
		c_out <= (a and b) or (a and c_in) or (b and c_in);
end structural;