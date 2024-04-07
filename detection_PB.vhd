library ieee;
use ieee.std_logic_1164.all;

entity detection_PB is

port(
    clk : in std_logic;
    BP_in : in std_logic := '1';
    S : out std_logic);

end entity detection_PB;

architecture dataflow of detection_PB is
signal Q0, Q1 : std_logic;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            Q0 <= BP_in;
            Q1 <= Q0;
        end if;
    end process;

    S <= (not Q0) and Q1;

end architecture dataflow;