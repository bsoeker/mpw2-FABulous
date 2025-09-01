library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk    : in  std_logic;
        io_in  : in std_logic_vector(23 downto 0);
        io_out : out std_logic_vector(23 downto 0);
        io_oeb : out std_logic_vector(23 downto 0);
        bram0_rd_addr : out std_logic_vector(7 downto 0);
        bram0_rd_data : in std_logic_vector(31 downto 0);
        bram0_wr_addr : out std_logic_vector(7 downto 0);
        bram0_wr_data : out std_logic_vector(31 downto 0);
        bram0_config  : out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavioral of top is
    signal rs2_latched : std_logic_vector(31 downto 0);

    constant RESET_PIN : integer := 23;
    constant OUTPUT_ENABLE  : std_logic := '1';
    constant OUTPUT_DISABLE : std_logic := '0';
    -- === Signals ===
    signal reset    : std_logic;
    signal test_sent    : std_logic := '0';
    signal test_wr_en   : std_logic := '0';
    signal test_wdata   : std_logic_vector(31 downto 0) := (others => '0');
    signal test_uart_rd : std_logic_vector(31 downto 0);

    -- PC
    signal pc            : std_logic_vector(31 downto 0);
    signal pc_plus_four  : std_logic_vector(31 downto 0);
    signal next_pc       : std_logic_vector(31 downto 0);
    signal jalr_target   : std_logic_vector(31 downto 0);
    signal branch_target : std_logic_vector(31 downto 0);
    signal branch_taken  : std_logic;


    -- Instruction
    signal instr    : std_logic_vector(31 downto 0);
    signal opcode   : std_logic_vector(6 downto 0);
    signal funct3   : std_logic_vector(2 downto 0);
    signal funct7   : std_logic_vector(6 downto 0);
    signal rs1_addr : std_logic_vector(4 downto 0);
    signal rs2_addr : std_logic_vector(4 downto 0);
    signal rd_addr  : std_logic_vector(4 downto 0);

    -- RegFile
    signal rs1_data, rs2_data : std_logic_vector(31 downto 0);
    signal reg_write_data     : std_logic_vector(31 downto 0);

    -- Immediate
    signal imm : std_logic_vector(31 downto 0);

    -- ALU
    signal alu_in_a, alu_in_b : std_logic_vector(31 downto 0);
    signal alu_result         : std_logic_vector(31 downto 0);
    signal zero_flag          : std_logic;

    -- Memory
    signal mem_data         : std_logic_vector(31 downto 0);
    signal ram_read_data    : std_logic_vector(31 downto 0);
    signal ram_write_en     : std_logic;
    signal byte_offset      : std_logic_vector(1 downto 0);
    signal store_misaligned : std_logic;
    signal loaded_value     : std_logic_vector(31 downto 0);
    signal ram_en           : std_logic;
    signal ram_addr         : std_logic_vector(7 downto 0);
    signal store_write_data : std_logic_vector(31 downto 0);
    signal wr_cfg           : std_logic_vector(1 downto 0);
    signal rom_en           : std_logic;
    signal rom_addr         : std_logic_vector(9 downto 0);
    signal rom_read_data    : std_logic_vector(31 downto 0);

    -- GPIO
    signal io_en         : std_logic;
    signal gpio_register : std_logic_vector(31 downto 0) := (others => '0');

    -- UART
    signal uart_addr      : std_logic_vector(1 downto 0);
    signal uart_en        : std_logic;
    signal uart_read_data : std_logic_vector(31 downto 0);
    signal uart_write_en  : std_logic;

    -- SPI
    signal spi_addr      : std_logic_vector(1 downto 0);
    signal spi_en        : std_logic;

    -- Control signals
    signal alu_control : std_logic_vector(3 downto 0);
    signal alu_src_a   : std_logic_vector(1 downto 0);
    signal alu_src_b   : std_logic;
    signal reg_write   : std_logic;
    signal mem_op      : std_logic;
    signal wb_sel      : std_logic_vector(1 downto 0);
    signal imm_type    : std_logic_vector(2 downto 0);
    signal jump        : std_logic;
    signal branch      : std_logic;
    signal read_mask   : std_logic_vector(3 downto 0);
    signal stall       : std_logic; -- from control unit

    signal stall_active : std_logic;  -- Whether we're currently in a stall
    signal stall_delay  : std_logic;  -- Whether we just started the stall

    -- Clock Divider
    -- signal clk : std_logic;
    -- Sync external reset into clk domain
    signal internal_reset : std_logic;
    signal reset_sync_0 : std_logic := '1';
    signal reset_sync_1 : std_logic := '1';

-- holds the base address during a multi‑cycle load
signal load_addr_latch : std_logic_vector(31 downto 0) := (others=>'0');
-- high during the *first* cycle of a 2‑cycle load
signal load_phase1     : std_logic := '0';
signal effective_addr  : std_logic_vector(31 downto 0) := (others => '0');
signal load_latched : std_logic_vector(31 downto 0);


begin
    process(clk)
begin
  if mem_op = '1' and ram_en = '1' then
    rs2_latched <= rs2_data;
  else
    rs2_latched <= (others => 'Z'); -- or hold last value if you want
  end if;
end process;

process(clk)
begin
  if rising_edge(clk) then
    if internal_reset = '1' then
      load_latched <= (others => '0');
    elsif mem_op = '1' and ram_en = '1' then
      load_latched <= ram_read_data;
    end if;
  end if;
end process;


    reset <= io_in(RESET_PIN);
    io_oeb(23 downto 22) <= (others => OUTPUT_DISABLE);
    io_oeb(11 downto 10) <= (others => OUTPUT_DISABLE);
    io_oeb(21 downto 14) <= (others => OUTPUT_ENABLE);
    io_oeb(9 downto 0)   <= (others => OUTPUT_ENABLE);

    process(clk)
    begin
        if rising_edge(clk) then
            reset_sync_0 <= reset;
            reset_sync_1 <= reset_sync_0;
        end if;
    end process;
    
    internal_reset <= reset_sync_1;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if internal_reset = '1' then
                stall_active <= '0';
                stall_delay  <= '0';
            else
                -- First time we see a stall, activate for one cycle
                if stall = '1' and stall_active = '0' then
                    stall_active <= '1';
                    stall_delay  <= '1';
                -- Stall already active, deactivate
                elsif stall_active = '1' then
                    stall_active <= '0';
                    stall_delay  <= '0';
                -- Normal case
                else
                    stall_delay <= '0';
                end if;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if load_phase1 = '1' then
                load_addr_latch <= rs1_data;
            end if;
        end if;
    end process;

    pc_plus_four  <= std_logic_vector(unsigned(pc) + 4);
    jalr_target   <= alu_result and x"FFFFFFFE";  -- Clear LSB for JALR
    branch_target <= std_logic_vector(signed(pc) + signed(imm));
    branch_taken  <= '1' when branch = '1' and (
        (funct3 = "000" and zero_flag = '1') or -- BEQ
        (funct3 = "001" and zero_flag = '0') or -- BNE
        (funct3 = "100" and alu_result = x"00000001") or -- BLT (SLT output 1)
        (funct3 = "101" and alu_result = x"00000000") or -- BGE (SLT output 0)
        (funct3 = "110" and alu_result = x"00000001") or -- BLTU
        (funct3 = "111" and alu_result = x"00000000")    -- BGEU
    ) else '0';

    next_pc <= pc when stall = '1' and stall_delay = '0' else
        jalr_target   when (jump = '1' and opcode = "1100111") else
        alu_result    when (jump = '1') else
        branch_target when (branch_taken = '1') else
        pc_plus_four;

    -- === Program Counter ===
    pc_unit: entity work.ProgramCounter
        port map (
            clk    => clk,
            reset  => internal_reset,
            pc_in  => next_pc,  -- For jumps and branches
            pc_out => pc
        );

    -- === Instruction ROM ===
    rom_inst: entity work.rom
        port map (
            instr_addr => pc(9 downto 0),
            instr_data => instr,
            data_addr  => rom_addr,
            data_data  => rom_read_data
        );

    -- === Decode Fields ===
    opcode   <= instr(6 downto 0);
    rd_addr  <= instr(11 downto 7);
    funct3   <= instr(14 downto 12);
    rs1_addr <= instr(19 downto 15);
    rs2_addr <= instr(24 downto 20);
    funct7   <= instr(31 downto 25);

    -- === Control Unit ===
    cu: entity work.control_unit
        port map (
            opcode      => opcode,
            funct3      => funct3,
            funct7      => funct7,
            alu_control => alu_control,
            alu_src_a   => alu_src_a,
            alu_src_b   => alu_src_b,
            reg_write   => reg_write,
            mem_op      => mem_op,
            wb_sel      => wb_sel,
            imm_type    => imm_type,
            jump        => jump,
            branch      => branch,
            stall       => stall,
            load_phase1 => load_phase1
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
            instr    => instr,
            imm_type => imm_type,
            imm_out  => imm
        );

    effective_addr <= load_addr_latch when stall_active = '1'   -- 2nd cycle
                  else rs1_data;                            -- 1st cycle or single‑cycle ops
    -- === ALU Source Muxes ===
    mux_a_inst: entity work.mux_a
        port map (
            sel    => alu_src_a,
            rs1    => effective_addr,
            pc     => pc,
            result => alu_in_a
        );

    mux_b_inst: entity work.mux_b
        port map (
            sel    => alu_src_b,
            rs2    => rs2_data,
            imm    => imm,
            result => alu_in_b
        );

    -- === ALU ===
    alu_inst: entity work.alu
        port map (
            op_a        => alu_in_a,
            op_b        => alu_in_b,
            alu_control => alu_control,
            result      => alu_result,
            zero        => zero_flag
        );

    addr_dec_inst: entity work.address_decoder
    port map (
        addr      => alu_result,
        ram_en    => ram_en,
        ram_addr  => ram_addr,
        uart_en   => uart_en,
        uart_addr => uart_addr,
        rom_en    => rom_en,
        rom_addr  => rom_addr,
        spi_en    => spi_en,
        spi_addr  => spi_addr,
        io_en     => io_en
    );

    bram0_rd_addr <= ram_addr; 
    bram0_wr_data <= rs2_latched;
    bram0_wr_addr <= ram_addr; 
    bram0_config  <= "00010000"; 
    ram_read_data <= bram0_rd_data;

     io_out(7 downto 0) <= rs2_latched(7 downto 0);

    uart_write_en <= '1' when mem_op = '1' and uart_en = '1' else '0';
    -- === UART ===
    uart_inst: entity work.uart
  port map (
      clk        => clk,
      reset      => internal_reset,
      addr       => uart_addr,
      wr_en      => uart_write_en,
      write_data => (31 downto 8 => '0') & rs2_latched(7 downto 0),
      read_data  => uart_read_data,
      RsTx       => io_out(21)
  );



    -- === Writeback Mux ===
    mux_wb_inst: entity work.mux_wb
        port map (
            sel => wb_sel,
            a   => alu_result,
            b   => load_latched,
            c   => pc_plus_four,
            y   => reg_write_data
        );

end Behavioral;

