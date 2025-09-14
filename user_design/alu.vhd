library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        start      : in  std_logic;  -- signal from control unit
        op_a       : in  std_logic_vector(31 downto 0);
        op_b       : in  std_logic_vector(31 downto 0);
        alu_control: in  std_logic_vector(3 downto 0);
        result     : out std_logic_vector(31 downto 0);
        zero       : out std_logic;
        done       : out std_logic   -- goes high when result is ready
    );
end alu;

architecture Behavioral of alu is
    type state_type is (IDLE, CALC, FINISH);
    signal state : state_type := IDLE;

    signal acc       : unsigned(31 downto 0) := (others => '0');
    signal carry     : std_logic := '0';
    signal bit_index : integer range 0 to 31 := 0;

    signal a, b : unsigned(31 downto 0);
    signal r    : unsigned(31 downto 0);
begin
    a <= unsigned(op_a);
    b <= unsigned(op_b);

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state     <= IDLE;
                acc       <= (others => '0');
                carry     <= '0';
                bit_index <= 0;
                done      <= '0';
                r         <= (others => '0');
            else
                case state is
                    when IDLE =>
                        done <= '0';
                        if start = '1' then
                            acc       <= (others => '0');
                            carry     <= '0';
                            bit_index <= 0;
                            state     <= CALC;
                        end if;

                    when CALC =>
                        if alu_control = "0000" then  -- ADD
                            acc(bit_index) <= a(bit_index) xor b(bit_index) xor carry;
                            carry          <= (a(bit_index) and b(bit_index)) or
                                               (a(bit_index) and carry) or
                                               (b(bit_index) and carry);
                        elsif alu_control = "0001" then -- SUB = A + (~B + 1)
                            acc(bit_index) <= a(bit_index) xor (not b(bit_index)) xor carry;
                            carry          <= (a(bit_index) and (not b(bit_index))) or
                                               (a(bit_index) and carry) or
                                               ((not b(bit_index)) and carry);
                        else
                            -- for simple ops, compute in one shot
                            case alu_control is
                                when "0010" => r <= a and b;
                                when "0011" => r <= a or b;
                                when "0100" => r <= a xor b;
                                when "1000" =>
                                    if signed(op_a) < signed(op_b) then
                                        r <= (others => '0');
                                        r(0) <= '1';
                                    else
                                        r <= (others => '0');
                                    end if;
                                when "1001" =>
                                    if unsigned(op_a) < unsigned(op_b) then
                                        r <= (others => '0');
                                        r(0) <= '1';
                                    else
                                        r <= (others => '0');
                                    end if;
                                when others =>
                                    r <= (others => '0');
                            end case;
                            state <= FINISH;
                        end if;

                        if alu_control = "0000" or alu_control = "0001" then
                            if bit_index = 31 then
                                r     <= acc;
                                state <= FINISH;
                            else
                                bit_index <= bit_index + 1;
                            end if;
                        end if;

                    when FINISH =>
                        done  <= '1';
                        state <= IDLE;
                end case;
            end if;
        end if;
    end process;

    result <= std_logic_vector(r);
    zero   <= '1' when r = 0 else '0';
end Behavioral;

