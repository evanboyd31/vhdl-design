library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity evan_boyd_FSM is
Port ( seq : in std_logic;
enable : in std_logic;
reset : in std_logic;
clk : in std_logic;
out_1 : out std_logic; -- generates 1 when the pattern "1011" is detected ; otherwise 0.
out_2 : out std_logic); -- generates 1 when the pattern "0010" is detected ;otherwise 0.
end evan_boyd_FSM;

architecture behavior of evan_boyd_FSM is 
type state_type is (s0, s1, s2, s3, s4);
signal state1 : state_type := s0;
signal state2 : state_type := s0;
begin
	process(clk, reset, enable, state1, state2)
	begin
		if(reset = '0') then
			state1 <= s0;
			state2 <= s0;
		elsif (enable = '0') then
				state1 <= state1;
				state2 <= state2;
		elsif(rising_edge(clk) and enable = '1') then
			case state1 is
				when s0 =>
					if seq = '1' then 
						state1 <= s1;
					end if;
				
				when s1 =>
					if seq = '0' then
						state1 <= s2;
					end if;
				
				when s2 =>
					if seq = '1' then
						state1 <= s3;
					else 
						state1 <= s0;
					end if;
					
				when s3 =>
					if seq = '1' then 
						state1 <= s4;
					else
						state1 <= s2;
					end if;
				
				when s4 =>
					if seq = '1' then
						state1 <= s1;
					else 
						state1 <= s2;
					end if;
					
				when others => 
					state1 <= s0;
			end case;
					
			case state2 is
				when s0 =>
					if seq = '0' then 
						state2 <= s1;
					end if;
				
				when s1 =>
					if seq = '0' then
						state2 <= s2;
					else
						state2 <= s0;
					end if;
				
				when s2 =>
					if seq = '1' then
						state2 <= s3;
					end if;
					
				when s3 =>
					if seq = '0' then 
						state2 <= s4;
					else
						state2 <= s0;
					end if;
				
				when s4 =>
					if seq = '0' then
						state2 <= s2;
					else 
						state2 <= s0;
					end if;
				when others => 
					state2 <= s0;
				end case;
			end if;
end process;

out_1 <= '1' when (state1 = s4 and enable = '1') else '0';
out_2 <= '1' when (state2 = s4 and enable = '1') else '0';

end behavior;