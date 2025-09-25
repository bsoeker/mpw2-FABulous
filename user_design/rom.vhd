library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
    generic (
        addr_width  : integer := 6  -- 64 words = 256B
    );
    port (
        clk        : in  std_logic;
        instr_addr : in  std_logic_vector(addr_width + 1 downto 0); -- Byte address (PC)
        instr_data : out std_logic_vector(31 downto 0);             -- Full 32-bit instruction
        data_addr  : in  std_logic_vector(addr_width + 1 downto 0); -- Byte address (ALU)
        data_data  : out std_logic_vector(31 downto 0)              -- Full 32-bit data
    );
end rom;

architecture rom_arch of rom is
    signal instr_word_addr : integer range 0 to 2**addr_width - 1;
    signal data_word_addr  : integer range 0 to 2**addr_width - 1;

    type rom_type is array (0 to 2**addr_width - 1) of std_logic_vector(31 downto 0);
    signal rom_array : rom_type := (
        0 => x"200000b7",   -- lui  x1, 0x20000   ; UART base = 0x20000000
        1 => x"06c00113",   -- addi x2, x0, 0x48
        2 => x"0020a023",   -- sw   x2, 0(x1)
        3 => x"0000006f",
        others => x"00000000"
    );

    -- registered outputs
    signal instr_reg : std_logic_vector(31 downto 0);
    signal data_reg  : std_logic_vector(31 downto 0);

begin
    instr_word_addr <= to_integer(shift_right(unsigned(instr_addr), 2));
    data_word_addr  <= to_integer(shift_right(unsigned(data_addr), 2));

    -- synchronous read
    process(clk)
    begin
        if rising_edge(clk) then
            instr_reg <= rom_array(instr_word_addr);
            data_reg  <= rom_array(data_word_addr);
        end if;
    end process;

    instr_data <= instr_reg;
    data_data  <= data_reg;

end rom_arch;

