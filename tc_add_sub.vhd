-- import required libraries
library ieee;
use ieee.std_logic_1164.all;

-- entity declaration
entity tc_add_sub is
    generic (n: positive);
    port (a, b: in std_logic_vector(n-1 downto 0);
        sel: in std_logic;
        sum: out std_logic_vector(n-1 downto 0);
        overflow: out std_logic);
end tc_add_sub;

architecture behavior of tc_add_sub is
	-- p_adder component declaration
    component p_adder is
    generic (n: positive);
    port (a, b: in std_logic_vector(n-1 downto 0);
    	c_in: in std_logic;
    	sum: out std_logic_vector(n-1 downto 0);
    	c_out: out std_logic);
    end component;

	-- declare required signals
    signal b_in : std_logic_vector(n-1 downto 0);
	signal sum_out : std_logic_vector(n-1 downto 0);
begin
    b_in <= not b when sel='1' else b; -- mux to choose between b and b' inputs
	sum <= sum_out; -- assign sum to sum_out in order to retrieve output value

	--instantiate p_adder component
    p_add0: p_adder generic map(n => n) port map(a => a, b => b_in, c_in => sel, sum => sum_out);
    overflow <= (a(n-1) xnor b_in(n-1)) and (a(n-1) xor sum_out(n-1)); -- overflow detection logic, making use of sum_out signal
end behavior;
