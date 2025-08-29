library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity store_unit is
    port (
        funct3      : in  std_logic_vector(2 downto 0); -- from instruction
        addr_offset : in  std_logic_vector(1 downto 0); -- addr(1 downto 0)
        store_data  : in  std_logic_vector(31 downto 0); -- value to store

        wr_cfg      : out std_logic_vector(1 downto 0); -- goes to C0,C1
        wr_ctrl     : out std_logic_vector(31 downto 0) -- goes into wr_data
    );
end entity;

architecture Behavioral of store_unit is
begin
    process(funct3, addr_offset, store_data)
    begin
        wr_cfg  <= "11"; -- default idle
        wr_ctrl <= (others => '0');

        case funct3 is
            when "000" => -- SB
                wr_cfg <= "10"; -- byte mode
                wr_ctrl(17 downto 16) <= addr_offset;
                wr_ctrl(7 downto 0)   <= store_data(7 downto 0);

            when "001" => -- SH
                wr_cfg <= "01"; -- half mode
                wr_ctrl(17)     <= addr_offset(1);
                wr_ctrl(15 downto 0) <= store_data(15 downto 0);

            when "010" => -- SW
                wr_cfg <= "00"; -- word mode
                wr_ctrl(31 downto 0) <= store_data;

            when others =>
                wr_cfg <= "11"; -- no store
        end case;
    end process;
end Behavioral;

