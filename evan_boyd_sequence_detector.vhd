library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity evan_boyd_sequence_detector is
Port ( seq : in std_logic;
enable : in std_logic;
reset : in std_logic;
clk : in std_logic;
cnt_1 : out std_logic_vector(2 downto 0); -- counts the occurrence of the pattern "1011".
cnt_2 : out std_logic_vector(2 downto 0)); -- counts the occurrence of the pattern "0010".
end evan_boyd_sequence_detector;

architecture detector of evan_boyd_sequence_detector is

component evan_boyd_FSM
Port ( seq : in std_logic;
enable : in std_logic;
reset : in std_logic;
clk : in std_logic;
out_1 : out std_logic; -- generates 1 when the pattern "1011" is detected ; otherwise 0.
out_2 : out std_logic); -- generates 1 when the pattern "0010" is detected ;otherwise 0.
end component;

component evan_boyd_counter
Port(enable : in std_logic;
reset : in std_logic;
clk : in std_logic;
count : out std_logic_vector(2 downto 0));
end component;
signal state1out : std_logic;
signal state2out : std_logic;
begin
	fsm : evan_boyd_FSM port map(seq, enable, reset, clk, state1out, state2out);
	counter1 : evan_boyd_counter port map(state1out, reset, clk, cnt_1);
	counter2 : evan_boyd_counter port map(state2out, reset, clk, cnt_2);

end detector;