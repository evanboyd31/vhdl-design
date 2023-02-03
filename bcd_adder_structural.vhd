library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity bcd_adder_structural is
port(A: in std_logic_vector(3 downto 0);
	  B: in std_logic_vector(3 downto 0);
     S: out std_logic_vector(3 downto 0);
	  C: out std_logic);
end bcd_adder_structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vector_MUX_behavioral is
	Port (x1 : in std_logic_vector(4 downto 0);
			x2 : in std_logic_vector(4 downto 0);
			sel : in std_logic;
			Y : out std_logic_vector(4 downto 0));
end vector_MUX_behavioral;

architecture behavioral of vector_MUX_behavioral is
begin  
	with sel select
		Y <= x1 when '0',
			  x2 when '1',
			  "-----" when others;
end behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX_behavioral is
	Port (x1 : in std_logic;
			x2 : in std_logic;
			sel : in std_logic;
			Y : out std_logic);
end MUX_behavioral;

architecture behavioral of MUX_behavioral is
begin  
	with sel select
		Y <= x1 when '0',
			  x2 when '1',
			  '-' when others;
end behavioral;



architecture structural of bcd_adder_structural is
signal aIsBCD : std_logic;
signal bISBCD : std_logic;
signal sumGreaterThanNine : std_logic;
signal validBCD : std_logic;
signal sum : std_logic_vector(4 downto 0);
signal sumLength4 : std_logic_vector(3 downto 0);
signal sumPlus6 : std_logic_vector(4 downto 0);
signal adjusted : std_logic_vector(4 downto 0);
signal outputSum : std_logic_vector(4 downto 0);
signal outputCarry : std_logic;

component rca_behavioral is
port(a: in std_logic_vector(3 downto 0);
	  b: in std_logic_vector(3 downto 0) ;
	  s: out std_logic_vector(4 downto 0));
end component;

component vector_MUX_behavioral is 
port(x1 : in std_logic_vector(4 downto 0);
			x2 : in std_logic_vector(4 downto 0);
			sel : in std_logic;
			Y : out std_logic_vector(4 downto 0));
end component;

component MUX_behavioral is 
port(x1 : in std_logic;
			x2 : in std_logic;
			sel : in std_logic;
			Y : out std_logic);
end component;

begin
   -- check if the inputs are valid BCD numbers
	aIsBCD <= not(A(3)) or (not(A(2)) and not(A(1)));
	bIsBCD <= not(B(3)) or (not(B(2)) and not(B(1)));
	validBCD <= aIsBCD and bIsBCD;
	-- add inputs and check if resulting sum was greater than 9; get the 4 least significant bits of the sum
	rca1: rca_behavioral port map(A, B, sum);
	sumLength4 <= sum(3) & sum(2) & sum(1) & sum(0);
	sumGreaterThanNine <= sum(4) or (sum(3) and sum(2)) or (sum(3) and sum(1));
	-- add 6 to sum; the variable adjusted will be sum if the sum < 10, and sumPlus6 if sum > 9
	rca2: rca_behavioral port map(sumLength4, std_logic_vector(to_unsigned(6, 4)), sumPlus6);
	adjustMUX : vector_MUX_behavioral port map(sum, sumPlus6, sumGreaterThanNine, adjusted);
	-- output don't care if the inputs are not valid BCD numbers for both sum and carry
	sumMUX: vector_MUX_behavioral port map("-----", adjusted, validBCD, outputSum);
	carryMUX: MUX_behavioral port map('-', sumGreaterThanNine, validBCD, outputCarry);
	-- take the last 4 significant bits of outputSum
	S <= outputSum(3) & outputSum(2) & outputSum(1) & outputSum(0);
	C <= outputCarry;
end structural;