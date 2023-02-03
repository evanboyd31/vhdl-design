library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity rca_structural is
port (A: in std_logic_vector(3 downto 0);
		B: in std_logic_vector(3 downto 0);
		S: out std_logic_vector(4 downto 0));
end rca_structural;

architecture structural of rca_structural is
	
	component half_adder
		port (a : in std_logic;
				b : in std_logic;
				s : out std_logic;
				c : out std_logic);
	end component;
	
	component full_adder
		port (a: in std_logic;
				b: in std_logic;
				c_in: in std_logic;
				s: out std_logic;
				c_out : out std_logic);
	end component;

	signal c0, c1, c2 : std_logic;
	
	begin
		half: half_adder port map (B(0), A(0), S(0), c0);
		full1: full_adder port map (B(1), A(1), c0, S(1), c1);
		full2: full_adder port map (B(2), A(2), c1, S(2), c2);
		full3: full_adder port map (B(3), A(3), c2, S(3), S(4));
end structural;
