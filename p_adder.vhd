-- import required libraries
library ieee;
use ieee.std_logic_1164.all;

-- entity declaration
entity p_adder is
	generic (n: positive := 4);
	port (a, b: in std_logic_vector(n-1 downto 0);
    	c_in: in std_logic;
    	sum: out std_logic_vector(n-1 downto 0);
    	c_out: out std_logic);
end p_adder;

architecture behavior of p_adder is
    -- full_adder component declaration
	component full_adder is
        port (a, b, c_in: in std_logic;
            sum, c_out: out std_logic);
    end component;

    -- signal to hold all the intermediary carry signals and final c_out signal
	signal carry : std_logic_vector(n downto 0);
begin
	-- first carry signal comes from p_adder's c_in port
	carry(0) <= c_in; 

	-- instantiate full_adders chained to each other, assigning all signals in the process
	L: for i in 0 to n-1 generate
		fa_n: full_adder port map(a => a(i), b => b(i), c_in => carry(i), sum => sum(i), c_out => carry(i+1));
	end generate;

	-- final carry signal goes to p_adder's c_out port
	c_out <= carry(n); 
end behavior;
