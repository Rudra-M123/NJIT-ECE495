--import required libraries
library ieee;
use ieee.std_logic_1164.all;

-- entity declaration
entity full_circuit is
    port(a, b: in std_logic_vector(7 downto 0);
		add_sub: in std_logic;
		a_out1, a_out0, b_out1, b_out0, sum_out1, sum_out0 : out std_logic_vector(0 to 6);
		overflow : out std_logic);				
end full_circuit;


architecture behavior of full_circuit is
	-- tc_add_sub component declaration
	component tc_add_sub is
		generic (n: positive);
		port (a, b: in std_logic_vector(n-1 downto 0);
			sel: in std_logic;
			sum: out std_logic_vector(n-1 downto 0);
			overflow: out std_logic);
	end component;

	-- signal to collect data after add/sub takes place
	signal sum_data : std_logic_vector(7 downto 0);
begin
	-- tc_add_sub instantiation with signal assignment
	tc_add_sub0: tc_add_sub generic map(n => 8) port map(a => a, b => b, sel => add_sub, sum => sum_data, overflow => overflow);

	-- seven segment decoders for both 2-hex digit inputs and 2-hex digit output value
	with a(7 downto 4) select
		a_out1 <= "0000001" when x"0",
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

	with a(3 downto 0) select
		a_out0 <= "0000001" when x"0",
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
	
	with b(7 downto 4) select
		b_out1 <= "0000001" when x"0",
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

	with b(3 downto 0) select
		b_out0 <= "0000001" when x"0",
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
end behavior;
