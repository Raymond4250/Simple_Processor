library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
	port(
		in_16bit: in std_logic_vector(15 downto 0);
		out_32bit: out std_logic_vector(31 downto 0)
	);
end sign_extend;

architecture behav of sign_extend is

	begin
   out_32bit <= std_logic_vector(resize(unsigned(in_16bit), out_32bit'length));
	
end architecture;