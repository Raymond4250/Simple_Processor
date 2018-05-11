library ieee;
use ieee.std_logic_1164.all;

entity Controls is
	port(
		clk: in std_logic;
		op: in std_logic_vector(5 downto 0);
		funct: in std_logic_vector(5 downto 0);
		alu_op: out std_logic_vector(3 downto 0);
		regwrite: out std_logic;
		alu_scr: out std_logic;
		reg_dst: out std_logic
	);
end Controls;

architecture Behavioral of Controls is
	
	begin
	process(clk)
		begin
		if op="000000" then
			if funct="100000" then
				alu_op <= "0000";
				regwrite <= '1';
				reg_dst <= '1';
				alu_scr <= '0';
			elsif funct="100010" then
				alu_op <= "0010";
				regwrite <= '1';
				reg_dst <= '1';
				alu_scr <= '0';
			elsif funct="100100" then
				alu_op <= "0100";
				regwrite <= '1';
				reg_dst <= '1';
				alu_scr <= '0';
			elsif funct="100101" then
				alu_op <= "0101";
				regwrite <= '1';
				reg_dst <= '1';
				alu_scr <= '0';
			else
				alu_op <= "0000";
				regwrite <= '0';
				reg_dst <= '1';
				alu_scr <= '0';
			end if;
			
		elsif op="001000" then
			alu_op <= "0000";
			regwrite <= '1';
			alu_scr <= '1';
			reg_dst <= '0';
		end if;
	end process;
	
end Behavioral;