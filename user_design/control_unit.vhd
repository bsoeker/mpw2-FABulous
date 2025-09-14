library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        -- From Instruction Register (IR)
        opcode   : in  std_logic_vector(6 downto 0);
        funct3   : in  std_logic_vector(2 downto 0);
        funct7   : in  std_logic_vector(6 downto 0);
        -- From ALU (for branches)
        zero_flag    : in  std_logic;
        alu_done     : in  std_logic;  -- NEW: from alu_mc
        -- From BDU
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
        alu_start   : out std_logic;   -- NEW: to alu_mc
        pc_src      : out std_logic_vector(1 downto 0);
        wb_sel      : out std_logic_vector(1 downto 0);
        imm_type    : out std_logic_vector(2 downto 0);
        id_enable   : out std_logic;
        ex_enable   : out std_logic;
        mem_enable  : out std_logic;
        wb_enable   : out std_logic
    );
end entity;

architecture behavioral of control_unit is

    -----------------------------------------------------------------
    -- State encoding
    -----------------------------------------------------------------
    type state_type is (S_IF1, S_IF2, S_ID, S_EX_START, S_EX_WAIT, S_MEM, S_WB);
    signal state, next_state : state_type;

    -----------------------------------------------------------------
    -- Decoder signals (internal, not driving outputs directly!)
    -----------------------------------------------------------------
    signal dec_alu_control : std_logic_vector(3 downto 0);
    signal dec_is_load     : std_logic;
    signal dec_is_store    : std_logic;
    signal dec_is_branch   : std_logic;
    signal dec_is_jal      : std_logic;
    signal dec_is_jalr     : std_logic;
    signal dec_reg_write   : std_logic;
    signal dec_wb_sel      : std_logic_vector(1 downto 0);
    signal dec_imm_type    : std_logic_vector(2 downto 0);
    signal dec_alu_src_a   : std_logic_vector(1 downto 0);
    signal dec_alu_src_b   : std_logic;

    -----------------------------------------------------------------
    -- Registered decoder outputs (latched in ID)
    -----------------------------------------------------------------
    signal op_is_load     : std_logic;
    signal op_is_store    : std_logic;
    signal op_is_branch   : std_logic;
    signal op_is_jal      : std_logic;
    signal op_is_jalr     : std_logic;
    signal op_reg_write   : std_logic;
    signal op_wb_sel      : std_logic_vector(1 downto 0);
    signal op_imm_type    : std_logic_vector(2 downto 0);
    signal op_alu_src_a   : std_logic_vector(1 downto 0);
    signal op_alu_src_b   : std_logic;
    signal op_alu_control : std_logic_vector(3 downto 0);
begin

    -----------------------------------------------------------------
    -- Decoder (combinational)
    -----------------------------------------------------------------
    decode_process : process(opcode, funct3, funct7)
    begin
        -- defaults
        dec_alu_control <= (others => '0');
        dec_is_load     <= '0';
        dec_is_store    <= '0';
        dec_is_branch   <= '0';
        dec_is_jal      <= '0';
        dec_is_jalr     <= '0';
        dec_reg_write   <= '0';
        dec_wb_sel      <= "00";
        dec_imm_type    <= "000";
        dec_alu_src_a   <= "00";
        dec_alu_src_b   <= '0';

        case opcode is
            when "0110011" => -- R-type
                dec_reg_write <= '1';
                dec_alu_src_a <= "00"; -- rs1
                dec_alu_src_b <= '0';  -- rs2
                case funct3 is
                    when "000" =>
                        if funct7 = "0000000" then
                            dec_alu_control <= "0000"; -- ADD
                        else
                            dec_alu_control <= "0001"; -- SUB
                        end if;
                    when "111" => dec_alu_control <= "0010"; -- AND
                    when "110" => dec_alu_control <= "0011"; -- OR
                    when others => null;
                end case;

            when "0000011" => -- LW
                dec_is_load     <= '1';
                dec_reg_write   <= '1';
                dec_wb_sel      <= "01"; -- MEM
                dec_alu_control <= "0000"; -- ADD
                dec_imm_type    <= "000"; -- I-type
                dec_alu_src_a   <= "00";
                dec_alu_src_b   <= '1';

            when "0100011" => -- SW
                dec_is_store    <= '1';
                dec_alu_control <= "0000"; -- ADD
                dec_imm_type    <= "001"; -- S-type
                dec_alu_src_a   <= "00";
                dec_alu_src_b   <= '1';

            when "1100011" => -- Branch
                dec_is_branch   <= '1';
                dec_imm_type    <= "010"; -- SB-type
                dec_alu_src_a   <= "00";
                dec_alu_src_b   <= '0';
                dec_alu_control <= "0001"; -- SUB for BEQ/BNE etc.

            when "1101111" => -- JAL
                dec_is_jal      <= '1';
                dec_reg_write   <= '1';
                dec_wb_sel      <= "10"; -- PC+4
                dec_imm_type    <= "100"; -- UJ-type
                dec_alu_src_a   <= "01"; -- PC
                dec_alu_src_b   <= '1';
                dec_alu_control <= "0000";

            when "1100111" => -- JALR
                dec_is_jalr     <= '1';
                dec_reg_write   <= '1';
                dec_wb_sel      <= "10"; -- PC+4
                dec_imm_type    <= "000"; -- I-type
                dec_alu_src_a   <= "00"; -- rs1
                dec_alu_src_b   <= '1';
                dec_alu_control <= "0000";

            when "0110111" => -- LUI
                dec_reg_write   <= '1';
                dec_imm_type    <= "011"; -- U-type
                dec_alu_src_a   <= "10"; -- zero
                dec_alu_src_b   <= '1';
                dec_alu_control <= "0000";

            when "0010111" => -- AUIPC
                dec_reg_write   <= '1';
                dec_imm_type    <= "011"; -- U-type
                dec_alu_src_a   <= "01"; -- PC
                dec_alu_src_b   <= '1';
                dec_alu_control <= "0000";

            when others =>
                null;
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

            -- Latch decoder outputs in S_ID
            if state = S_ID then
                op_is_load     <= dec_is_load;
                op_is_store    <= dec_is_store;
                op_is_branch   <= dec_is_branch;
                op_is_jal      <= dec_is_jal;
                op_is_jalr     <= dec_is_jalr;
                op_reg_write   <= dec_reg_write;
                op_wb_sel      <= dec_wb_sel;
                op_imm_type    <= dec_imm_type;
                op_alu_src_a   <= dec_alu_src_a;
                op_alu_src_b   <= dec_alu_src_b;
                op_alu_control <= dec_alu_control;
            end if;
        end if;
    end process;

    -----------------------------------------------------------------
    -- FSM with ALU handshake
    -----------------------------------------------------------------
    process(all)
    begin
        -- defaults
        pc_write   <= '0';
        ir_write   <= '0';
        reg_write  <= '0';
        mem_read   <= '0';
        mem_write  <= '0';
        alu_src_a  <= op_alu_src_a;
        alu_src_b  <= op_alu_src_b;
        alu_control<= op_alu_control;
        alu_start  <= '0';       -- NEW
        pc_src     <= "00";
        wb_sel     <= op_wb_sel;
        imm_type   <= op_imm_type;
        next_state <= state;
        id_enable  <= '0';
        ex_enable  <= '0';
        mem_enable <= '0';
        wb_enable  <= '0';

        case state is
            when S_IF1 =>
                mem_read   <= '1';
                next_state <= S_IF2;

            when S_IF2 =>
                ir_write   <= '1';
                next_state <= S_ID;

            when S_ID =>
                id_enable <= '1';
                next_state <= S_EX_START;

            when S_EX_START =>
                alu_start <= '1';  -- kick off ALU
                ex_enable <= '1';
                next_state <= S_EX_WAIT;

            when S_EX_WAIT =>
                ex_enable <= '1';  -- keep operands stable
                if alu_done = '1' then
                    -- same branch/jump/mem logic as before
                    if op_is_branch = '1' then
                        if branch_taken = '1' then
                            pc_write <= '1';
                            pc_src   <= "01";
                        else
                            pc_write <= '1';
                            pc_src   <= "00";
                        end if;
                        next_state <= S_IF1;

                    elsif op_is_jal = '1' then
                        pc_write <= '1';
                        pc_src   <= "10";
                        if op_reg_write = '1' then
                            reg_write <= '1';
                        end if;
                        next_state <= S_IF1;

                    elsif op_is_jalr = '1' then
                        pc_write <= '1';
                        pc_src   <= "11";
                        if op_reg_write = '1' then
                            reg_write <= '1';
                        end if;
                        next_state <= S_IF1;

                    elsif op_is_load = '1' or op_is_store = '1' then
                        next_state <= S_MEM;

                    else
                        next_state <= S_WB;
                    end if;
                end if;

            when S_MEM =>
                mem_enable <= '1';
                if op_is_load = '1' then
                    mem_read   <= '1';
                    next_state <= S_WB;
                else
                    mem_write  <= '1';
                    pc_write   <= '1';
                    next_state <= S_IF1;
                end if;

            when S_WB =>
                wb_enable <= '1';
                if op_reg_write = '1' then
                    reg_write <= '1';
                end if;
                pc_write   <= '1';
                next_state <= S_IF1;
        end case;
    end process;
end architecture;

