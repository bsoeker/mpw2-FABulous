library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_a is
    Port (
        clk    : in  std_logic;
        sel    : in  std_logic_vector(1 downto 0);  -- "00"=rs1, "01"=PC, "10"=zero
        rs1    : in  std_logic_vector(31 downto 0);
        pc     : in  std_logic_vector(31 downto 0);
        result : out std_logic_vector(31 downto 0)
    );
end mux_a;

architecture Behavioral of mux_a is
    signal result_next : std_logic_vector(31 downto 0);
    signal result_reg  : std_logic_vector(31 downto 0);
begin
    -- Combinational select
    process(sel, rs1, pc)
    begin
        case sel is
            when "00" => result_next <= rs1;
            when "01" => result_next <= pc;
            when "10" => result_next <= (others => '0');  -- zero
            when others => result_next <= rs1;
        end case;
    end process;

    -- Registered output
    process(clk)
    begin
        if rising_edge(clk) then
            result_reg <= result_next;
        end if;
    end process;

    result <= result_reg;
end Behavioral;

