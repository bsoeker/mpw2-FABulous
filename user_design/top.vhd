library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk    : in  std_logic;
        -- reset  : in  std_logic
        io_in  : in std_logic_vector(23 downto 0) := (others => '0');
        io_out : out std_logic_vector(23 downto 0) := (others => '0');
        io_oeb : out std_logic_vector(23 downto 0) := (others => '1')
    );
end top;

architecture Behavioral of top is
    constant RESET_PIN       : integer := 23;
    constant OUTPUT_ENABLE   : std_logic := '1';
    constant OUTPUT_DISABLE  : std_logic := '0';

    -- Reset sync
    signal reset : std_logic;
    signal internal_reset : std_logic;
    signal reset_sync_0, reset_sync_1 : std_logic := '1';

    -- PC
    signal pc, pc_plus_four, next_pc, jalr_target, branch_target : std_logic_vector(31 downto 0) := (others => '0');

    -- Instruction
    signal instr_reg : std_logic_vector(31 downto 0);
    signal opcode    : std_logic_vector(6 downto 0);
    signal funct3    : std_logic_vector(2 downto 0);
    signal funct7    : std_logic_vector(6 downto 0);
    signal rs1_addr, rs2_addr, rd_addr : std_logic_vector(4 downto 0);

    -- RegFile
    signal rs1_data, rs2_data, reg_write_data : std_logic_vector(31 downto 0);

    -- Immediate
    signal imm : std_logic_vector(31 downto 0);

    -- ALU
    signal alu_input_a, alu_input_b, alu_result : std_logic_vector(31 downto 0);
    signal alu_control : std_logic_vector(3 downto 0);
    signal zero_flag, alu_start, alu_done : std_logic;

    -- Memory / UART
    signal mem_data, rom_instr_data, rom_read_data, uart_read_data : std_logic_vector(31 downto 0);
    signal ram_addr, rom_addr : std_logic_vector(7 downto 0);
    signal uart_addr          : std_logic_vector(1 downto 0);
    signal ram_en, rom_en, uart_en, io_en : std_logic;
    signal mem_read, mem_write, uart_write_en : std_logic;

    -- Control signals
    signal ir_write, pc_write, reg_write : std_logic;
    signal alu_src_a : std_logic_vector(1 downto 0);
    signal alu_src_b : std_logic;
    signal pc_src    : std_logic_vector(1 downto 0);
    signal wb_sel    : std_logic_vector(1 downto 0);
    signal imm_type  : std_logic_vector(2 downto 0);
    signal branch_taken : std_logic;
    signal is_branch : std_logic;
    signal is_jalr : std_logic;
    signal is_jal : std_logic;

    -- GPIO
    signal gpio_reg : std_logic_vector(7 downto 0) := (others => '0');
    -- UART simulation
    signal RsTx : std_logic;
begin
    -- === Reset sync ===
    reset <= io_in(RESET_PIN);
    io_oeb(23) <= OUTPUT_DISABLE;
    io_oeb(21) <= OUTPUT_ENABLE;
    io_oeb(7 downto 0) <= (others => OUTPUT_ENABLE);

    process(clk)
    begin
        if rising_edge(clk) then
            reset_sync_0 <= reset;
            reset_sync_1 <= reset_sync_0;
        end if;
    end process;
    internal_reset <= reset_sync_1;


    -- === Program Counter ===
    pc_plus_four <= std_logic_vector(unsigned(pc) + 4);
    jalr_target   <= alu_result and x"FFFFFFFE";  -- Clear LSB for JALR
    branch_target <= std_logic_vector(signed(pc) + signed(imm));
    branch_taken  <= '1' when is_branch = '1' and (
        (funct3 = "000" and zero_flag = '1') or -- BEQ
        (funct3 = "001" and zero_flag = '0') or -- BNE
        (funct3 = "100" and alu_result = x"00000001") or -- BLT (SLT output 1)
        (funct3 = "101" and alu_result = x"00000000") or -- BGE (SLT output 0)
        (funct3 = "110" and alu_result = x"00000001") or -- BLTU
        (funct3 = "111" and alu_result = x"00000000")    -- BGEU
    ) else '0';

    next_pc <=
        jalr_target   when (is_jalr = '1') else
        alu_result    when (is_jal = '1') else
        branch_target when (branch_taken = '1') else
        pc_plus_four;

    pc_unit: entity work.ProgramCounter
        port map (
            clk      => clk,
            reset    => internal_reset,
            pc_write => pc_write,
            pc_in    => next_pc,
            pc_out   => pc
        );

    -- === Instruction ROM ===
    rom_inst: entity work.rom
        port map (
            clk        => clk,
            instr_addr => pc(7 downto 0),
            instr_data => rom_instr_data,
            data_addr  => rom_addr,
            data_data  => rom_read_data
        );

    -- === Instruction Register ===
    process(clk)
    begin
        if rising_edge(clk) then
            if internal_reset = '1' then
                instr_reg <= (others => '0');
            elsif ir_write = '1' then
                instr_reg <= rom_instr_data;
            end if;
        end if;
    end process;

    -- Decode fields
    opcode   <= instr_reg(6 downto 0);
    rd_addr  <= instr_reg(11 downto 7);
    funct3   <= instr_reg(14 downto 12);
    rs1_addr <= instr_reg(19 downto 15);
    rs2_addr <= instr_reg(24 downto 20);
    funct7   <= instr_reg(31 downto 25);

    -- === Control Unit ===
    cu: entity work.control_unit
        port map (
            clk          => clk,
            reset        => internal_reset,
            opcode       => opcode,
            funct3       => funct3,
            funct7       => funct7,
            zero_flag    => zero_flag,
            alu_done     => alu_done,
            branch_taken => branch_taken,
            pc_write     => pc_write,
            ir_write     => ir_write,
            reg_write    => reg_write,
            mem_read     => mem_read,
            mem_write    => mem_write,
            alu_src_a    => alu_src_a,
            alu_src_b    => alu_src_b,
            alu_control  => alu_control,
            alu_start    => alu_start,
            -- pc_src       => pc_src,
            wb_sel       => wb_sel,
            is_branch    => is_branch,
            is_jalr    => is_jalr,
            is_jal    => is_jal,
            imm_type     => imm_type
        );

    -- === Register File ===
    regfile_inst: entity work.reg_file
        port map (
            clk       => clk,
            rs1_addr  => rs1_addr,
            rs2_addr  => rs2_addr,
            rd_addr   => rd_addr,
            rd_data   => reg_write_data,
            reg_write => reg_write,
            rs1_data  => rs1_data,
            rs2_data  => rs2_data
        );

    -- === Immediate Generator ===
    immgen_inst: entity work.imm_gen
        port map (
            instr    => instr_reg,
            imm_type => imm_type,
            imm_out  => imm
        );

    -- === ALU input muxes ===
    mux_a_inst: entity work.mux_a
        port map (
            clk    => clk,
            sel    => alu_src_a,
            rs1    => rs1_data,
            pc     => pc,
            result => alu_input_a
        );

    mux_b_inst: entity work.mux_b
        port map (
            clk    => clk,
            sel    => alu_src_b,
            rs2    => rs2_data,
            imm    => imm,
            result => alu_input_b
        );

    -- === ALU ===
    alu_inst: entity work.alu
         port map (
            clk         => clk,
            reset       => internal_reset,
            start       => alu_start,
            op_a        => alu_input_a,
            op_b        => alu_input_b,
            alu_control => alu_control,
            result      => alu_result,
            zero        => zero_flag,
            done        => alu_done
        );

    -- === Address Decoder ===
    addr_dec_inst: entity work.address_decoder
        port map (
            addr      => alu_result,
            ram_en    => ram_en,
            ram_addr  => ram_addr,
            uart_en   => uart_en,
            uart_addr => uart_addr,
            rom_en    => rom_en,
            rom_addr  => rom_addr,
            io_en     => io_en
        );

    -- === UART ===
    uart_write_en <= '1' when (mem_write = '1' and uart_en = '1') else '0';
    uart_inst: entity work.uart
        port map (
            clk         => clk,
            reset       => internal_reset,
            addr        => uart_addr,
            wr_en       => uart_write_en,
            write_data  => rs2_data,
            read_data   => uart_read_data,
            RsTx        => RsTx
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if internal_reset = '1' then
                gpio_reg <= (others => '0');
            elsif mem_write = '1' and io_en = '1' then
                gpio_reg <= rs2_data(7 downto 0);
            end if;
        end if;
    end process;
    io_out(7 downto 0) <= gpio_reg;

    -- === Memory Mux ===
    mem_data <= uart_read_data when uart_en = '1' else
                rom_read_data  when rom_en = '1' else
                (others => '0');

    -- === Writeback Mux ===
    mux_wb_inst: entity work.mux_wb
        port map (
            clk    => clk,
            sel => wb_sel,
            a   => alu_result,
            b   => mem_data,
            c   => pc_plus_four,
            y   => reg_write_data
        );

end Behavioral;

