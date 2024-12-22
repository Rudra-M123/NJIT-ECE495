-- import required libraries
library ieee;
use ieee.std_logic_1164.all;


-- entity declaration
entity ripple_4bit is
	port(a, b: in std_logic_vector(3 downto 0);
		c_in: in std_logic;
		c_out, sum_out : out std_logic_vector(0 to 6));
end ripple_4bit;

architecture behavior of ripple_4bit is
	-- p_adder component declaration
	component p_adder is
		generic (n: positive);
		port (a, b: in std_logic_vector(n-1 downto 0);
			c_in: in std_logic;
			sum: out std_logic_vector(n-1 downto 0);
			c_out: out std_logic);
		end component;

	-- signals to collect the data after the addition takes place
	signal sum_data : std_logic_vector(3 downto 0);
	signal c_out_data : std_logic;
begin
	-- p_adder instantiation with signal assignment
	p_add0: p_adder generic map(n => 4) port map(a => a, b => b, c_in => c_in, sum => sum_data, c_out => c_out_data);

	-- seven segment decoding for sum_out and c_out
	with sum_data select
		sum_out <=  "1111110" when x"0",
					"0110000" when x"1",
					"1101101" when x"2",
					"1111001" when x"3",
					"0110011" when x"4",
					"1011011" when x"5",
					"1011111" when x"6",
					"1110000" when x"7",
					"1111111" when x"8",
					"1110011" when x"9",
					"1110111" when x"A",
					"0011111" when x"B",
					"1001110" when x"C",
					"0111101" when x"D",
					"1001111" when x"E",
					"1000111" when x"F",
					"0000000" when others;
	
	with c_out_data select
		c_out <= "1111110" when '0',
				"0110000" when '1',
				"0000000" when others;
end behavior;
