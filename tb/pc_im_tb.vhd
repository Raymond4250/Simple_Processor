library ieee;
use ieee.std_logic_1164.all;

entity pc_im_tb is
	port(
		clk: in std_logic;
		pc_addr: out std_logic_vector(4 downto 0);
		op: out std_logic_vector(5 downto 0);
		rs1: out std_logic_vector(4 downto 0);
		rs2: out std_logic_vector(4 downto 0);
		rd: out std_logic_vector(4 downto 0);
		fnt: out std_logic_vector(5 downto 0)
	);
  
end pc_im_tb;
 

architecture Structural of pc_im_tb is

	component PC is
		port(
			clk: in std_logic;
			addr: in std_logic_vector(4 downto 0);
			nxt_addr: out std_logic_vector(4 downto 0)
		);
	end component;

	component inst_mem is
		port(
			addr: in std_logic_vector(4 downto 0);
			op: out std_logic_vector(5 downto 0);
			rs1: out std_logic_vector(4 downto 0);
			rs2: out std_logic_vector(4 downto 0);
			rd: out std_logic_vector(4 downto 0);
			funct: out std_logic_vector(5 downto 0)
		);
	end component;

	signal pc_tmp: std_logic_vector(4 downto 0);
	signal op_tmp: std_logic_vector(5 downto 0);
	signal reg_addr1_tmp: std_logic_vector(4 downto 0);
	signal reg_addr2_tmp: std_logic_vector(4 downto 0);
	signal reg_des_tmp: std_logic_vector(4 downto 0);
	signal funct: std_logic_vector(5 downto 0);
	
	begin
	ProgramC:PC
		port map(clk, pc_tmp, pc_tmp);
	IM:inst_mem
		port map(pc_tmp, op_tmp, reg_addr1_tmp, reg_addr2_tmp, reg_des_tmp, funct);
	
	pc_addr <= pc_tmp;
	op <= op_tmp;
	rs1 <= reg_addr1_tmp;
	rs2 <= reg_addr2_tmp;
	rd <= reg_des_tmp;
	fnt <= funct;
  
end Structural;
