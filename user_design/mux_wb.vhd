library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_wb is
    Port (
        clk : in  std_logic;
        sel : in  std_logic_vector(1 downto 0);
        a   : in  std_logic_vector(31 downto 0); -- ALU result
        b   : in  std_logic_vector(31 downto 0); -- Memory data
        c   : in  std_logic_vector(31 downto 0); -- PC + 4
        y   : out std_logic_vector(31 downto 0)  -- Registered output
    );
end mux_wb;

architecture Behavioral of mux_wb is
    signal y_next : std_logic_vector(31 downto 0);
    signal y_reg  : std_logic_vector(31 downto 0);
begin
    -- Combinational select
    process(sel, a, b, c)
    begin
        case sel is
            when "00" => y_next <= a;
            when "01" => y_next <= b;
            when "10" => y_next <= c;
            when others => y_next <= a;
        end case;
    end process;

    -- Registered output
    process(clk)
    begin
        if rising_edge(clk) then
            y_reg <= y_next;
        end if;
    end process;

    y <= y_reg;
end Behavioral;

