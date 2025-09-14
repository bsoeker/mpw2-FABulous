library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bdu is -- Branch Decision Unit
    port (
        funct3       : in  std_logic_vector(2 downto 0);
        zero_flag    : in  std_logic;                 -- from ALU (rs1 - rs2)
        alu_result   : in  std_logic_vector(31 downto 0); -- for SLT/SLTU
        is_branch    : in  std_logic;                 -- from decoder
        branch_taken : out std_logic
    );
end entity;

architecture behavioral of bdu is
begin
    process(funct3, zero_flag, alu_result, is_branch)
    begin
        branch_taken <= '0';

        if is_branch = '1' then
            case funct3 is
                when "000" => -- BEQ
                    if zero_flag = '1' then
                        branch_taken <= '1';
                    end if;

                when "001" => -- BNE
                    if zero_flag = '0' then
                        branch_taken <= '1';
                    end if;

                when "100" => -- BLT (signed)
                    if alu_result = x"00000001" then
                        branch_taken <= '1';
                    end if;

                when "101" => -- BGE (signed)
                    if alu_result = x"00000000" then
                        branch_taken <= '1';
                    end if;

                when "110" => -- BLTU (unsigned)
                    if alu_result = x"00000001" then
                        branch_taken <= '1';
                    end if;

                when "111" => -- BGEU (unsigned)
                    if alu_result = x"00000000" then
                        branch_taken <= '1';
                    end if;

                when others =>
                    branch_taken <= '0';
            end case;
        end if;
    end process;
end architecture;

