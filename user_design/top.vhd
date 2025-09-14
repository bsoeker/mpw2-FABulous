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
        -- bram0_rd_addr : out std_logic_vector(7 downto 0);
        -- bram0_rd_data : in std_logic_vector(31 downto 0);
        -- bram0_wr_addr : out std_logic_vector(7 downto 0);
        -- bram0_wr_data : out std_logic_vector(31 downto 0);
        -- bram0_config  : out std_logic_vector(5 downto 0)
    );
end top;

architecture Behavioral of top is

    constant RESET_PIN : integer := 23;
    constant OUTPUT_ENABLE  : std_logic := '1';
    constant OUTPUT_DISABLE : std_logic := '0';
    -- === Signals ===
    signal reset    : std_logic;

    -- PC
    signal pc            : std_logic_vector(31 downto 0);
    signal pc_plus_four  : std_logic_vector(31 downto 0);
    signal next_pc       : std_logic_vector(31 downto 0);
    signal jalr_target   : std_logic_vector(31 downto 0);
    signal branch_target : std_logic_vector(31 downto 0);
    signal branch_taken  : std_logic;

    -- Instruction
    signal instr_reg : std_logic_vector(31 downto 0);
    signal opcode    : std_logic_vector(6 downto 0);
    signal funct3    : std_logic_vector(2 downto 0);
    signal funct7    : std_logic_vector(6 downto 0);
    signal rs1_addr  : std_logic_vector(4 downto 0);
    signal rs2_addr  : std_logic_vector(4 downto 0);
    signal rd_addr   : std_logic_vector(4 downto 0);

    -- RegFile
    signal rs1_data, rs2_data : std_logic_vector(31 downto 0);
    signal reg_write_data     : std_logic_vector(31 downto 0);

    -- Immediate
    signal imm : std_logic_vector(31 downto 0);

    -- ALU
    signal alu_input_a, alu_input_b : std_logic_vector(31 downto 0);
    signal alu_result         : std_logic_vector(31 downto 0);
    signal zero_flag          : std_logic;
    -- ALU handshake
    signal alu_start : std_logic;
    signal alu_done  : std_logic;


    -- Memory
    signal mem_data         : std_logic_vector(31 downto 0);
    signal ram_read_data    : std_logic_vector(31 downto 0);
    signal ram_write_en     : std_logic;
    signal byte_offset      : std_logic_vector(1 downto 0);
    signal ram_en           : std_logic;
    signal ram_addr         : std_logic_vector(7 downto 0);
    signal rom_en           : std_logic;
    signal rom_addr         : std_logic_vector(7 downto 0);
    signal rom_instr_data   : std_logic_vector(31 downto 0);
    signal rom_read_data    : std_logic_vector(31 downto 0);

    -- GPIO
    signal io_en         : std_logic;

    -- UART
    signal uart_addr      : std_logic_vector(1 downto 0);
    signal uart_en        : std_logic;
    signal uart_read_data : std_logic_vector(31 downto 0);
    signal uart_write_en  : std_logic;
    signal RsTx           : std_logic;

    -- Control signals
    signal alu_control : std_logic_vector(3 downto 0);
    signal alu_src_a   : std_logic_vector(1 downto 0);
    signal alu_src_b   : std_logic;
    signal reg_write   : std_logic;
    signal mem_read    : std_logic;
    signal mem_write   : std_logic;
    signal wb_sel      : std_logic_vector(1 downto 0);
    signal imm_type    : std_logic_vector(2 downto 0);
    signal is_branch   : std_logic;
    signal is_jal      : std_logic;
    signal is_jalr     : std_logic;
    signal ir_write    : std_logic;
    signal pc_write    : std_logic;
    signal pc_src      : std_logic_vector(1 downto 0);
    -- Stage enables from control unit
    signal id_enable  : std_logic;
    signal ex_enable  : std_logic;
    signal mem_enable : std_logic;
    signal wb_enable  : std_logic;
    -- ID/EX pipeline
    signal id_rs1_data, id_rs2_data : std_logic_vector(31 downto 0);
    signal id_imm                   : std_logic_vector(31 downto 0);
    signal id_rd_addr               : std_logic_vector(4 downto 0);
    signal id_alu_src_a             : std_logic_vector(1 downto 0);
    signal id_alu_src_b             : std_logic;
    signal id_alu_control           : std_logic_vector(3 downto 0);
    signal id_wb_sel                : std_logic_vector(1 downto 0);
    signal id_reg_write             : std_logic;
    -- EX/MEM pipeline
    signal ex_alu_result  : std_logic_vector(31 downto 0);
    signal ex_rd_addr     : std_logic_vector(4 downto 0);
    signal ex_wb_sel      : std_logic_vector(1 downto 0);
    signal ex_reg_write   : std_logic;
    signal ex_mem_write   : std_logic;
    signal ex_mem_read    : std_logic;
    signal ex_rs2_data    : std_logic_vector(31 downto 0); -- needed for stores
    -- MEM/WB pipeline
    signal mem_wb_data   : std_logic_vector(31 downto 0);
    signal mem_alu_result: std_logic_vector(31 downto 0);
    signal mem_rd_addr   : std_logic_vector(4 downto 0);
    signal mem_wb_sel    : std_logic_vector(1 downto 0);
    signal mem_reg_write : std_logic;


    -- Sync external reset into clk domain
    signal internal_reset : std_logic;
    signal reset_sync_0 : std_logic := '1';
    signal reset_sync_1 : std_logic := '1';

begin
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

    process(clk)
    begin
        if rising_edge(clk) then
            if internal_reset = '1' then
                id_rs1_data   <= (others => '0');
                id_rs2_data   <= (others => '0');
                id_imm        <= (others => '0');
                id_rd_addr    <= (others => '0');
                id_alu_src_a  <= (others => '0');
                id_alu_src_b  <= '0';
                id_alu_control<= (others => '0');
                id_wb_sel     <= (others => '0');
                id_reg_write  <= '0';
            elsif id_enable = '1' then
                id_rs1_data   <= rs1_data;
                id_rs2_data   <= rs2_data;
                id_imm        <= imm;
                id_rd_addr    <= rd_addr;
                id_alu_src_a  <= alu_src_a;
                id_alu_src_b  <= alu_src_b;
                id_alu_control<= alu_control;
                id_wb_sel     <= wb_sel;
                id_reg_write  <= reg_write;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if internal_reset = '1' then
                ex_alu_result <= (others => '0');
                ex_rd_addr    <= (others => '0');
                ex_wb_sel     <= (others => '0');
                ex_reg_write  <= '0';
                ex_mem_write  <= '0';
                ex_mem_read   <= '0';
                ex_rs2_data   <= (others => '0');
            elsif ex_enable = '1' then
                ex_alu_result <= alu_result;
                ex_rd_addr    <= id_rd_addr;
                ex_wb_sel     <= id_wb_sel;
                ex_reg_write  <= id_reg_write;
                ex_mem_write  <= mem_write; -- straight from CU
                ex_mem_read   <= mem_read;
                ex_rs2_data   <= id_rs2_data;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if internal_reset = '1' then
                mem_wb_data    <= (others => '0');
                mem_alu_result <= (others => '0');
                mem_rd_addr    <= (others => '0');
                mem_wb_sel     <= (others => '0');
                mem_reg_write  <= '0';
            elsif mem_enable = '1' then
                mem_wb_data    <= mem_data;
                mem_alu_result <= ex_alu_result;
                mem_rd_addr    <= ex_rd_addr;
                mem_wb_sel     <= ex_wb_sel;
                mem_reg_write  <= ex_reg_write;
            end if;
        end if;
    end process;




    -- bdu: entity work.bdu
    --     port map (
    --        funct3       => funct3,
    --        zero_flag    => zero_flag,
    --        alu_result   => alu_result,
    --        is_branch    => is_branch,
    --        branch_taken => branch_taken
    -- );

    pc_plus_four  <= std_logic_vector(unsigned(pc) + 4);
    -- jalr_target   <= alu_result and x"FFFFFFFE";  -- Clear LSB for JALR
    -- branch_target <= std_logic_vector(signed(pc) + signed(imm));
    -- pc_mux: entity work.pc_mux
    --     port map (
    --         sel           => pc_src,
    --         pc_plus_four  => pc_plus_four,
    --         jalr_target   => jalr_target,
    --         branch_target => branch_target,
    --         alu_result    => alu_result,
    --         next_pc       => next_pc
    --     );
    --
    -- === Program Counter ===
    pc_unit: entity work.ProgramCounter
        port map (
            clk      => clk,
            reset    => internal_reset,
            pc_write => pc_write,
            pc_in    => pc_plus_four,
            pc_out   => pc
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                io_out(7 downto 0) <= (others => '0');
            elsif io_en = '1' then
                io_out(7 downto 0) <= rs2_data(7 downto 0);
            end if;
        end if;
    end process;


    -- === Instruction ROM ===
    rom_inst: entity work.rom
        port map (
            clk        => clk,
            instr_addr => pc(7 downto 0),
            instr_data => rom_instr_data,
            data_addr  => rom_addr,
            data_data  => rom_read_data
        );

    -- === Instruction Register (IR) ===
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

    -- === Decode Fields ===
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
            alu_done     => alu_done,     -- NEW
            branch_taken => branch_taken,
            pc_write     => pc_write,
            ir_write     => ir_write,
            reg_write    => reg_write,
            mem_read     => mem_read,
            mem_write    => mem_write,
            alu_src_a    => alu_src_a,
            alu_src_b    => alu_src_b,
            alu_control  => alu_control,
            alu_start    => alu_start,    -- NEW
            pc_src       => pc_src,
            wb_sel       => wb_sel,
            imm_type     => imm_type,
            id_enable    => id_enable,
            ex_enable    => ex_enable,
            mem_enable   => mem_enable,
            wb_enable    => wb_enable
        );


    -- === Register File ===
    regfile_inst: entity work.reg_file
        port map (
            clk       => clk,
            rs1_addr  => rs1_addr,
            rs2_addr  => rs2_addr,
            rd_addr   => mem_rd_addr,
            rd_data   => reg_write_data,
            reg_write => mem_reg_write,
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

    -- === ALU Source Muxes ===
    mux_a_inst: entity work.mux_a
        port map (
            clk    => clk,
            sel    => id_alu_src_a,
            rs1    => id_rs1_data,
            pc     => pc,
            result => alu_input_a
        );

    mux_b_inst: entity work.mux_b
        port map (
            clk    => clk,
            sel    => id_alu_src_b,
            rs2    => id_rs2_data,
            imm    => id_imm,
            result => alu_input_b
        );

    -- === ALU ===
    alu_inst: entity work.alu
         port map (
            clk         => clk,
            reset       => internal_reset,
            start       => alu_start,      -- from CU
            op_a        => alu_input_a,
            op_b        => alu_input_b,
            alu_control => id_alu_control,
            result      => alu_result,
            zero        => zero_flag,
            done        => alu_done        -- back to CU
        );


    addr_dec_inst: entity work.address_decoder
        port map (
            clk       => clk,
            addr      => ex_alu_result,
            ram_en    => ram_en,
            ram_addr  => ram_addr,
            uart_en   => uart_en,
            uart_addr => uart_addr,
            rom_en    => rom_en,
            rom_addr  => rom_addr,
            io_en     => io_en
        );

    uart_write_en <= '1' when ex_mem_write = '1' and uart_en = '1' else '0';
    uart_inst: entity work.uart
        port map (
            clk         => clk,
            reset       => internal_reset,
            addr        => uart_addr,
            wr_en       => uart_write_en,
            write_data  => ex_rs2_data,
            read_data   => uart_read_data,
            RsTx        => io_out(21)
        );

    mem_data <= uart_read_data when uart_en = '1' else
                rom_read_data  when rom_en = '1' else
                (others => '0');

    -- === Writeback Mux ===
    mux_wb_inst: entity work.mux_wb
        port map (
            clk => clk,
            sel => mem_wb_sel,
            a   => mem_alu_result,
            b   => mem_wb_data,
            c   => pc_plus_four,
            y   => reg_write_data
        );

end Behavioral;

