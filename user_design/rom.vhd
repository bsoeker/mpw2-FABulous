library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
    generic (
        addr_width  : integer := 8  -- 256 words = 1KB
    );
    port (
        instr_addr : in  std_logic_vector(addr_width + 1 downto 0); -- Byte address (PC)
        instr_data : out std_logic_vector(31 downto 0);  -- Full 32-bit instruction
        data_addr  : in  std_logic_vector(addr_width + 1 downto 0); -- Byte address (ALU)
        data_data  : out std_logic_vector(31 downto 0)  -- Full 32-bit data
    );
end rom;

architecture rom_arch of rom is
    signal instr_word_addr : integer range 0 to 2**addr_width - 1;
    signal data_word_addr  : integer range 0 to 2**addr_width - 1;

    type rom_type is array (0 to 2**addr_width - 1) of std_logic_vector(31 downto 0);
    signal rom_array : rom_type := (
    0 =>  x"100002b7",    -- lui   t0,0x10000
    1 =>  x"0ff00313",    -- addi  t1,x0,0xAA
    2 =>  x"0062a023",    -- sw    t1,0(t0)
    3 =>  x"0002a283",    -- lw    t2,0(t0)
    4 =>  x"700003b7",    -- lui   t3,0x70000
    5 =>  x"0053a023",    -- sw    t2,0(t3)
    -- 6 =>  x"0000006f"    -- jal   x0,0
    others => x"00000013"   -- nop filler
);

begin
    instr_word_addr <= to_integer(shift_right(unsigned(instr_addr), 2));
    data_word_addr <= to_integer(shift_right(unsigned(data_addr), 2));

    instr_data <= rom_array(instr_word_addr);
    data_data  <= rom_array(data_word_addr);

end rom_arch;

