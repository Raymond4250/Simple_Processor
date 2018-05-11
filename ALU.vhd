library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ALU is
	port(
		x,y: in std_logic_vector(31 downto 0);
		alu_op: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(31 downto 0)
	);
end ALU;

architecture Behavioral of ALU is
	signal res: std_logic_vector(31 downto 0);
	
	begin
	process(x,y,alu_op)
		begin
		if alu_op = "0000" then
			res <= x + y;
		elsif alu_op = "0010" then
			res <= x - y;
		elsif alu_op = "0100" then
			res <= x and y;
		elsif alu_op = "0101" then
			res <= x or y;
		end if;
	end process;
	
	result <= res;

end Behavioral;