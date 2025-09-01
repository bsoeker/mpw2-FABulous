library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_file is
    Port (
        clk        : in  std_logic;
        rs1_addr   : in  std_logic_vector(4 downto 0);
        rs2_addr   : in  std_logic_vector(4 downto 0);
        rd_addr    : in  std_logic_vector(4 downto 0);
        rd_data    : in  std_logic_vector(31 downto 0);
        reg_write  : in  std_logic;
        rs1_data   : out std_logic_vector(31 downto 0);
        rs2_data   : out std_logic_vector(31 downto 0)
    );
end reg_file;

architecture Wrapper of reg_file is

  -------------------------------------------------------------------
  -- Verilog primitive (4-bit wide regfile)
  -------------------------------------------------------------------
  component RegFile_32x4
    generic (
      AD_reg : std_logic := '0';
      BD_reg : std_logic := '0'
    );
    port (
      -- Write port
      D0, D1, D2, D3     : in  std_logic;
      W_ADR0, W_ADR1, W_ADR2, W_ADR3, W_ADR4 : in  std_logic;
      W_en               : in  std_logic;

      -- Read port A
      AD0, AD1, AD2, AD3 : out std_logic;
      A_ADR0, A_ADR1, A_ADR2, A_ADR3, A_ADR4 : in  std_logic;

      -- Read port B
      BD0, BD1, BD2, BD3 : out std_logic;
      B_ADR0, B_ADR1, B_ADR2, B_ADR3, B_ADR4 : in  std_logic;

      -- Clock
      CLK                : in  std_logic
    );
  end component;

  -------------------------------------------------------------------
  -- internal buses
  -------------------------------------------------------------------
  signal rs1_slices : std_logic_vector(31 downto 0);
  signal rs2_slices : std_logic_vector(31 downto 0);

  -- gated write enable (x0 must never be written)
  signal we_int : std_logic;

begin

  -------------------------------------------------------------------
  -- Prevent writes to x0
  -------------------------------------------------------------------
  we_int <= reg_write when rd_addr /= "00000" else '0';

  -------------------------------------------------------------------
  -- replicate 8 instances of the 4-bit regfile
  -------------------------------------------------------------------
  gen_regfiles : for i in 0 to 7 generate
    regfile_inst : RegFile_32x4
      generic map (
        AD_reg => '0',
        BD_reg => '0'
      )
      port map (
        -- Write port (select 4 bits of rd_data)
        D0 => rd_data(i*4 + 0),
        D1 => rd_data(i*4 + 1),
        D2 => rd_data(i*4 + 2),
        D3 => rd_data(i*4 + 3),
        W_ADR0 => rd_addr(0),
        W_ADR1 => rd_addr(1),
        W_ADR2 => rd_addr(2),
        W_ADR3 => rd_addr(3),
        W_ADR4 => rd_addr(4),
        W_en   => we_int,

        -- Read port A (4 bits into slice)
        AD0 => rs1_slices(i*4 + 0),
        AD1 => rs1_slices(i*4 + 1),
        AD2 => rs1_slices(i*4 + 2),
        AD3 => rs1_slices(i*4 + 3),
        A_ADR0 => rs1_addr(0),
        A_ADR1 => rs1_addr(1),
        A_ADR2 => rs1_addr(2),
        A_ADR3 => rs1_addr(3),
        A_ADR4 => rs1_addr(4),

        -- Read port B (4 bits into slice)
        BD0 => rs2_slices(i*4 + 0),
        BD1 => rs2_slices(i*4 + 1),
        BD2 => rs2_slices(i*4 + 2),
        BD3 => rs2_slices(i*4 + 3),
        B_ADR0 => rs2_addr(0),
        B_ADR1 => rs2_addr(1),
        B_ADR2 => rs2_addr(2),
        B_ADR3 => rs2_addr(3),
        B_ADR4 => rs2_addr(4),

        -- Clock
        CLK => clk
      );
  end generate;

  -------------------------------------------------------------------
  -- force reads of x0 to return 0
  -------------------------------------------------------------------
  rs1_data <= (others => '0') when rs1_addr = "00000" else rs1_slices;
  rs2_data <= (others => '0') when rs2_addr = "00000" else rs2_slices;

end Wrapper;

