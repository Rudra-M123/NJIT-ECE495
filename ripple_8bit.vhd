-- import required libraries
library ieee;
use ieee.std_logic_1164.all;

-- entity declaration
entity ripple_8bit is
    port(a, b: in std_logic_vector(7 downto 0);
		c_in: in std_logic;
		c_out, sum_out1, sum_out0 : out std_logic_vector(0 to 6));
end ripple_8bit;

architecture behavior of ripple_8bit is
       -- p_adder component declaration
	component p_adder is
		generic (n: positive);
		port (a, b: in std_logic_vector(n-1 downto 0);
			c_in: in std_logic;
			sum: out std_logic_vector(n-1 downto 0);
			c_out: out std_logic);
    end component;

	-- signals to collect the data after the addition takes place
    signal sum_data : std_logic_vector(7 downto 0);
    signal c_out_data : std_logic;
begin
	-- p_adder instantiation with signal assignment
	p_add0: p_adder generic map(n => 8) port map(a => a, b => b, c_in => c_in, sum => sum_data, c_out => c_out_data);
	
	-- seven segment decoding for sum_out1 (high-order bits), sum_out0 (low-order bits), and c_out
	with sum_data(7 downto 4) select
		sum_out1 <= "0000001" when x"0",
					"1001111" when x"1",
					"0010010" when x"2",
					"0000110" when x"3",
					"1001100" when x"4",
					"0100100" when x"5",
					"0100000" when x"6",
					"0001111" when x"7",
					"0000000" when x"8",
					"0001100" when x"9",
					"0001000" when x"A",
					"1100000" when x"B",
					"0110001" when x"C",
					"1000010" when x"D",
					"0110000" when x"E",
					"0111000" when x"F",
					"1111111" when others;

	with sum_data(3 downto 0) select
		sum_out0 <= "0000001" when x"0",
					"1001111" when x"1",
					"0010010" when x"2",
					"0000110" when x"3",
					"1001100" when x"4",
					"0100100" when x"5",
					"0100000" when x"6",
					"0001111" when x"7",
					"0000000" when x"8",
					"0001100" when x"9",
					"0001000" when x"A",
					"1100000" when x"B",
					"0110001" when x"C",
					"1000010" when x"D",
					"0110000" when x"E",
					"0111000" when x"F",
					"1111111" when others;

	with c_out_data select
		c_out <= "0000001" when '0',
				"1001111" when '1',
				"1111111" when others;
end behavior;
