library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity address_decoder is
    Port (
        clk         : in  std_logic;
        addr        : in  std_logic_vector(31 downto 0);  -- alu_result

        ram_en      : out std_logic;
        ram_addr    : out std_logic_vector(7 downto 0); 
        uart_en     : out std_logic;
        uart_addr   : out std_logic_vector(1 downto 0);   -- select data/status
        rom_en      : out std_logic;
        rom_addr    : out std_logic_vector(7 downto 0);
        io_en       : out std_logic
    );
end address_decoder;

architecture Behavioral of address_decoder is
    -- registered signals
    signal ram_en_r, uart_en_r, rom_en_r, io_en_r : std_logic;
    signal ram_addr_r, rom_addr_r : std_logic_vector(7 downto 0);
    signal uart_addr_r            : std_logic_vector(1 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- ROM: 0x00000000 - 0x00000FFF
            rom_en_r   <= '1' when addr(31 downto 12) = x"00000" else '0';
            rom_addr_r <= addr(7 downto 0);

            -- RAM: 0x10000000 – 0x10000FFF
            ram_en_r   <= '1' when addr(31 downto 12) = x"10000" else '0';
            ram_addr_r <= addr(7 downto 0);

            -- UART: 0x20000000 and 0x20000004 
            uart_en_r   <= '1' when addr(31 downto 12) = x"20000" else '0';
            uart_addr_r <= addr(3 downto 2);

            -- IO: 0x70000000
            io_en_r     <= '1' when addr = x"70000000" else '0';
        end if;
    end process;

    -- Drive outputs from registered versions
    ram_en   <= ram_en_r;
    ram_addr <= ram_addr_r;
    uart_en  <= uart_en_r;
    uart_addr<= uart_addr_r;
    rom_en   <= rom_en_r;
    rom_addr <= rom_addr_r;
    io_en    <= io_en_r;
end Behavioral;

