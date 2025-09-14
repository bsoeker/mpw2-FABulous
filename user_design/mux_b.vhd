library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_b is
    Port (
        clk    : in  std_logic;
        sel    : in  std_logic;  -- 0 = rs2_data, 1 = imm_out
        rs2    : in  std_logic_vector(31 downto 0);
        imm    : in  std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0)
    );
end mux_b;

architecture Behavioral of mux_b is
    signal result_next : std_logic_vector(31 downto 0);
    signal result_reg  : std_logic_vector(31 downto 0);
begin
    -- Combinational select
    result_next <= rs2 when sel = '0' else imm;

    -- Registered output
    process(clk)
    begin
        if rising_edge(clk) then
            result_reg <= result_next;
        end if;
    end process;

    result <= result_reg;
end Behavioral;

