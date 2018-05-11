library ieee;
use ieee.std_logic_1164.all;

entity Processor is
	port(
		clk: in std_logic
		--pc_count: out std_logic_vector(4 downto 0);
		--rs1: out std_logic_vector(4 downto 0);
		----rs2: out std_logic_vector(4 downto 0);
		--RD1: out std_logic_vector(31 downto 0);
		--RD2: out std_logic_vector(31 downto 0);
		--alu_out: out std_logic_vector(31 downto 0);
		--wrreg: out std_logic_vector(4 downto 0)
	);
  
end Processor;
 

architecture Structural of Processor is

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
			funct: out std_logic_vector(5 downto 0);
			immediate:out std_logic_vector(15 downto 0)
		);
	end component;

	component Controls is
		port(
			clk: in std_logic;
			op: in std_logic_vector(5 downto 0);
			funct: in std_logic_vector(5 downto 0);
			alu_op: out std_logic_vector(3 downto 0);
			regwrite: out std_logic;
			alu_scr: out std_logic;
			reg_dst: out std_logic
		);
	end component;

	component Registers is
		port(
			clk: in std_logic;
			regWrite: in std_logic;
			RR1: in std_logic_vector(4 downto 0);
			RR2: in std_logic_vector(4 downto 0);
			WR: in std_logic_vector(4 downto 0);
			WD: in std_logic_vector(31 downto 0);
			RD1: out std_logic_vector(31 downto 0);
			RD2: out std_logic_vector(31 downto 0)
		);
	end component;

	component ALU is
		port(
			x,y: in std_logic_vector(31 downto 0);
			alu_op: in std_logic_vector(3 downto 0);
			result: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component sign_extend is
		port(
			in_16bit: in std_logic_vector(15 downto 0);
			out_32bit: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component MUX2 is
		port(
			sel: in std_logic;
			in0: in std_logic_vector(31 downto 0);
			in1: in std_logic_vector(31 downto 0);
			MUXout: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component MUX is
		port(
			sel: in std_logic;
			in0: in std_logic_vector(4 downto 0);
			in1: in std_logic_vector(4 downto 0);
			MUXout: out std_logic_vector(4 downto 0)
		);
	end component;
	
	signal pc_tmp: std_logic_vector(4 downto 0);
	signal op_tmp: std_logic_vector(5 downto 0);
	signal reg_addr1_tmp: std_logic_vector(4 downto 0);
	signal reg_addr2_tmp: std_logic_vector(4 downto 0);
	signal reg_des_tmp: std_logic_vector(4 downto 0);
	signal funct_tmp: std_logic_vector(5 downto 0);
	signal alu_op_tmp: std_logic_vector(3 downto 0);
	signal regwrite_tmp: std_logic;
	signal alu_scr_tmp: std_logic;
	signal reg_dst_tmp: std_logic;
	signal reg_data1_tmp: std_logic_vector(31 downto 0);
	signal reg_data2_tmp: std_logic_vector(31 downto 0);
	signal alu_result_tmp: std_logic_vector(31 downto 0);
	signal extend_in_tmp: std_logic_vector(15 downto 0);
	signal extend_out_tmp: std_logic_vector(31 downto 0);
	signal mux_data_tmp: std_logic_vector(31 downto 0);
	signal mux_WriteReg_temp: std_logic_vector(4 downto 0);
	
	begin
	ProgramCounter:PC
		port map(clk, pc_tmp, pc_tmp);
	IM:inst_mem
		port map(pc_tmp, op_tmp, reg_addr1_tmp, reg_addr2_tmp, reg_des_tmp, funct_tmp,extend_in_tmp);
	Control:Controls
		port map(clk, op_tmp, funct_tmp, alu_op_tmp, regwrite_tmp, alu_scr_tmp, reg_dst_tmp);
	Reg:Registers
		port map(clk, regwrite_tmp, reg_addr1_tmp, reg_addr2_tmp, mux_WriteReg_temp, alu_result_tmp, reg_data1_tmp, reg_data2_tmp);
	A_L_U:ALU
		port map(reg_data1_tmp, mux_data_tmp, alu_op_tmp, alu_result_tmp);
	Sign_Extender:sign_extend
		port map(extend_in_tmp, extend_out_tmp);
	MUX_alu:MUX2
		port map(alu_scr_tmp, reg_data2_tmp, extend_out_tmp, mux_data_tmp);
	MUX_WriteReg:MUX
		port map(reg_dst_tmp, reg_addr2_tmp, reg_des_tmp, mux_WriteReg_temp);
		
	--pc_count		<= pc_tmp;
	--rs1			<= reg_addr1_tmp;
	--rs2 			<= reg_addr2_tmp;
	
	--wrreg			<= mux_WriteReg_temp;

	--RD1			<= reg_data1_tmp;
	--RD2			<= reg_data2_tmp;
	
	--alu_out		<= alu_result_tmp;
	
  
end Structural;
