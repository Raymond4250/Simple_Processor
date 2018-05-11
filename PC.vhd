library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity PC is
	port(
		clk: in std_logic;
		addr: in std_logic_vector(4 downto 0);
		nxt_addr: out std_logic_vector(4 downto 0)
	);
end PC;

architecture behav of PC is
	begin
	process(clk)
		begin
		if clk'event and clk='1' then
			nxt_addr <= addr+1;
		end if;
	end process;
end behav;