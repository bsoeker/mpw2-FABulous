library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_mux is
    port (
        sel          : in  std_logic_vector(1 downto 0);
        pc_plus_four : in  std_logic_vector(31 downto 0);
        jalr_target  : in  std_logic_vector(31 downto 0);
        branch_target: in  std_logic_vector(31 downto 0);
        alu_result   : in  std_logic_vector(31 downto 0); -- JAL target
        next_pc      : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavioral of pc_mux is
begin
    process(sel, pc_plus_four, jalr_target, branch_target, alu_result)
    begin
        case sel is
            when "00" => next_pc <= pc_plus_four;   -- default / sequential
            when "01" => next_pc <= branch_target;  -- taken branch
            when "10" => next_pc <= alu_result;     -- JAL (PC+imm from ALU)
            when "11" => next_pc <= jalr_target;    -- JALR (rs1+imm masked)
            when others => next_pc <= pc_plus_four;
        end case;
    end process;
end architecture;

