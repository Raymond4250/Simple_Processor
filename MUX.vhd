library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX is
	port(
	sel: in std_logic;
	in0: in std_logic_vector(4 downto 0);
	in1: in std_logic_vector(4 downto 0);
	MUXout: out std_logic_vector(4 downto 0)
	);
end MUX;

architecture MUX of MUX is
	begin
		MUXout <= in0 when (sel = '0') else in1;
end MUX;