library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        opcode   : in  std_logic_vector(6 downto 0);
        funct3   : in  std_logic_vector(2 downto 0);
        funct7   : in  std_logic_vector(6 downto 0);
        zero_flag    : in  std_logic;
        alu_done     : in  std_logic;
        branch_taken : in std_logic;
        -- To datapath
        ir_write    : out std_logic;
        pc_write    : out std_logic;
        reg_write   : out std_logic;
        mem_read    : out std_logic;
        mem_write   : out std_logic;
        alu_src_a   : out std_logic_vector(1 downto 0);
        alu_src_b   : out std_logic;
        alu_control : out std_logic_vector(3 downto 0);
        alu_start   : out std_logic;
        pc_src      : out std_logic_vector(1 downto 0);
        wb_sel      : out std_logic_vector(1 downto 0);
        imm_type    : out std_logic_vector(2 downto 0)
    );
end entity;

architecture behavioral of control_unit is
    -----------------------------------------------------------------
    -- States
    -----------------------------------------------------------------
    type state_type is (S_IF1, S_IF2, S_ID, S_ID_WAIT, S_EX, S_MEM, S_WB);
    signal state, next_state : state_type;

    -----------------------------------------------------------------
    -- Decoder signals (combinational)
    -----------------------------------------------------------------
    signal d_alu_control : std_logic_vector(3 downto 0);
    signal d_is_load, d_is_store, d_is_branch, d_is_jal, d_is_jalr, d_reg_write : std_logic;
    signal d_wb_sel : std_logic_vector(1 downto 0);
    signal d_imm_type : std_logic_vector(2 downto 0);
    signal d_alu_src_a : std_logic_vector(1 downto 0);
    signal d_alu_src_b : std_logic;
begin

    -----------------------------------------------------------------
    -- Decoder (combinational)
    -----------------------------------------------------------------
    decode_process: process(opcode, funct3, funct7)
    begin
        d_alu_control <= (others => '0');
        d_is_load <= '0'; d_is_store <= '0'; d_is_branch <= '0';
        d_is_jal <= '0'; d_is_jalr <= '0'; d_reg_write <= '0';
        d_wb_sel <= "00"; d_imm_type <= "000";
        d_alu_src_a <= "00"; d_alu_src_b <= '0';

        case opcode is
            -- R-type (e.g., ADD, SUB, AND, OR, etc.)
            when "0110011" =>
                d_alu_src_a <= "00"; -- reg
                d_alu_src_b <= '0'; -- reg
                d_reg_write <= '1';

                case funct3 is
                    when "000" =>
                        if funct7 = "0000000" then
                            d_alu_control <= "0000"; -- ADD
                        elsif funct7 = "0100000" then
                            d_alu_control <= "0001"; -- SUB
                        end if;
                    when "001" => d_alu_control <= "0101"; -- SLL
                    when "010" => d_alu_control <= "1000"; -- SLT
                    when "011" => d_alu_control <= "1001"; -- SLTU
                    when "100" => d_alu_control <= "0100"; -- XOR
                    when "101" =>
                        if funct7 = "0000000" then
                            d_alu_control <= "0110"; -- SRL
                        elsif funct7 = "0100000" then
                            d_alu_control <= "0111"; -- SRA
                        end if;
                    when "110"  => d_alu_control <= "0011"; -- OR
                    when "111"  => d_alu_control <= "0010"; -- AND
                    when others => d_alu_control <= "0000";
                end case;

            -- I-type (e.g., ADDI, ORI)
            when "0010011" =>  -- ALU imm
                d_alu_src_a <= "00"; -- reg
                d_alu_src_b <= '1'; -- imm
                d_imm_type  <= "000"; -- I-type
                d_reg_write <= '1';

                case funct3 is
                    when "000" => d_alu_control <= "0000"; -- ADDI
                    when "001" => d_alu_control <= "0101"; -- SLLI
                    when "010" => d_alu_control <= "1000"; -- SLTI
                    when "011" => d_alu_control <= "1001"; -- SLTIU
                    when "100" => d_alu_control <= "0100"; -- XORI
                    when "101" =>
                        if funct7 = "0000000" then
                            d_alu_control <= "0110"; -- SRLI
                        elsif funct7 = "0100000" then
                            d_alu_control <= "0111"; -- SRAI
                        end if;
                    when "110" => d_alu_control <= "0011"; -- ORI
                    when "111" => d_alu_control <= "0010"; -- ANDI
                    when others => d_alu_control <= "0000";
                end case;


            when "0000011" => -- LW
                d_is_load     <= '1';
                d_reg_write   <= '1';
                d_wb_sel      <= "01";
                d_alu_control <= "0000";
                d_imm_type    <= "000";
                d_alu_src_a   <= "00";
                d_alu_src_b   <= '1';

            when "0100011" => -- SW
                d_is_store    <= '1';
                d_alu_control <= "0000";
                d_imm_type    <= "001";
                d_alu_src_a   <= "00";
                d_alu_src_b   <= '1';

            when "1100011" => -- Branch
                d_is_branch   <= '1';
                d_imm_type    <= "010";
                d_alu_src_a   <= "00";
                d_alu_src_b   <= '0';
                d_alu_control <= 
                    "0001" when funct3 = "000" or funct3 = "001" else -- SUB for BEQ/BNE
                    "1000" when funct3 = "100" or funct3 = "101" else -- SLT  for BLT/BGE
                    "1001";                                           -- SLTU for BLTU/BGEU

            when "1101111" => -- JAL
                d_is_jal      <= '1';
                d_reg_write   <= '1';
                d_wb_sel      <= "10";
                d_imm_type    <= "100";
                d_alu_src_a   <= "01"; -- PC
                d_alu_src_b   <= '1';
                d_alu_control <= "0000";

            when "1100111" => -- JALR
                d_is_jalr     <= '1';
                d_reg_write   <= '1';
                d_wb_sel      <= "10";
                d_imm_type    <= "000";
                d_alu_src_a   <= "00";
                d_alu_src_b   <= '1';
                d_alu_control <= "0000";

            when "0110111" => -- LUI
                d_reg_write   <= '1';
                d_imm_type    <= "011";
                d_alu_src_a   <= "10"; -- zero
                d_alu_src_b   <= '1';
                d_alu_control <= "0000";

            when "0010111" => -- AUIPC
                d_reg_write   <= '1';
                d_imm_type    <= "011";
                d_alu_src_a   <= "01"; -- PC
                d_alu_src_b   <= '1';
                d_alu_control <= "0000";

            when others => null;
        end case;
    end process;

    -----------------------------------------------------------------
    -- State register
    -----------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= S_IF1;
            else
                state <= next_state;
            end if;
        end if;
    end process;

    -----------------------------------------------------------------
    -- FSM
    -----------------------------------------------------------------
    process(all)
    begin
        -- defaults
        ir_write <= '0'; pc_write <= '0'; reg_write <= '0';
        mem_read <= '0'; mem_write <= '0'; alu_start <= '0';
        alu_src_a <= d_alu_src_a; alu_src_b <= d_alu_src_b;
        alu_control <= d_alu_control;
        pc_src <= "00"; wb_sel <= d_wb_sel; imm_type <= d_imm_type;
        next_state <= state;

        case state is
            when S_IF1 =>
                mem_read <= '1';
                next_state <= S_IF2;

            when S_IF2 =>
                ir_write <= '1';
                next_state <= S_ID;

            when S_ID =>
                -- Present rs1_addr / rs2_addr to regfile
                -- But rs1_data / rs2_data not valid until next cycle
                next_state <= S_ID_WAIT;

            when S_ID_WAIT =>
                -- Now regfile outputs are valid
                next_state <= S_EX;
                alu_start <= '1';

            when S_EX =>
                if alu_done = '1' then
                    if d_is_branch = '1' then
                        pc_write <= '1'; pc_src <= "01";
                        next_state <= S_IF1;

                    elsif d_is_jal = '1' then
                        pc_write <= '1'; pc_src <= "10";
                        if d_reg_write = '1' then reg_write <= '1'; end if;
                        next_state <= S_IF1;

                    elsif d_is_jalr = '1' then
                        pc_write <= '1'; pc_src <= "11";
                        if d_reg_write = '1' then reg_write <= '1'; end if;
                        next_state <= S_IF1;

                    elsif d_is_load = '1' or d_is_store = '1' then
                        next_state <= S_MEM;

                    else
                        next_state <= S_WB;
                    end if;
                end if;

            when S_MEM =>
                if d_is_load = '1' then
                    mem_read <= '1';
                    next_state <= S_WB;
                else
                    mem_write <= '1';
                    pc_write <= '1';
                    next_state <= S_IF1;
                end if;

            when S_WB =>
                if d_reg_write = '1' then reg_write <= '1'; end if;
                pc_write <= '1';
                next_state <= S_IF1;
        end case;
    end process;
end architecture;

