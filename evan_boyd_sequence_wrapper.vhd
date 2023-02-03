library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity evan_boyd_sequence_wrapper is
Port (reset : in std_logic;
enable : in std_logic;
clk : in std_logic;
HEX0 : out std_logic_vector(6 downto 0);
HEX5 : out std_logic_vector(6 downto 0));
end evan_boyd_sequence_wrapper;

architecture sequence_wrapper_behavior of evan_boyd_sequence_wrapper is

component seven_segment_decoder
port(code : in std_logic_vector(3 downto 0) ;
    segments_out : out std_logic_vector(6 downto 0));
end component;

component ROM
port(
    clk : in std_logic;
    reset : in std_logic;
    data : out std_logic
);
end component;

component evan_boyd_sequence_detector
Port ( seq : in std_logic;
enable : in std_logic;
reset : in std_logic;
clk : in std_logic;
cnt_1 : out std_logic_vector(2 downto 0); -- counts the occurrence of the pattern "1011".
cnt_2 : out std_logic_vector(2 downto 0)); -- counts the occurrence of the pattern "0010".
end component;


component evan_boyd_clock_divider
Port( enable: in std_logic;
		reset : in std_logic;
		clk : in std_logic;
		en_out : out std_logic);
end component;
signal div_out : std_logic;
signal rom_out : std_logic;
signal not_reset : std_logic;
signal cnt1 : std_logic_vector(2 downto 0) := "000";
signal cnt2 : std_logic_vector(2 downto 0) := "000";
signal cnt1_length4 : std_logic_vector(3 downto 0) := "0000"; 
signal cnt2_length4 : std_logic_vector(3 downto 0) := "0000";
begin
	not_reset <= not(reset);
	clock_div : evan_boyd_clock_divider port map(enable, reset, clk, div_out);
	rom_inst : ROM port map(div_out, not_reset, rom_out);
	sequence_detect : evan_boyd_sequence_detector port map(rom_out, div_out, reset, clk, cnt1, cnt2);
	cnt1_length4 <= '0' & cnt1;
	cnt2_length4 <= '0' & cnt2;
	decode1 : seven_segment_decoder port map(cnt1_length4, HEX0);
	decode2 : seven_segment_decoder port map(cnt2_length4, HEX5);
	
	

end sequence_wrapper_behavior;
