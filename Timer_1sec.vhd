library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer_1sec is 
    port(
        arst_n : in std_logic;
        clk : in std_logic;
        S : out std_logic
    );
end entity timer_1sec;

architecture structure of timer_1sec is
    --signal intern :
    signal counter : integer := 0;

begin

    process(arst_n, clk)
    begin
        if arst_n = '1' then
            counter <= 0;
        elsif rising_edge(clk) then
            counter <= counter + 1;
            if counter = 50000000 then --clk at 50MHz => 50000000 = 1sec
                counter <= 0;
                S <= '1';
            else 
                S <= '0';
            end if;
        end if;
    end process;

            end architecture structure;
