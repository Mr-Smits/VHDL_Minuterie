library ieee;
use ieee.std_logic_1164.all;

entity Output_Logic is

    port(
        input : in std_logic_vector(3 downto 0);
        output : out std_logic
    );
end entity Output_logic;

architecture structure of Output_Logic is
    begin
        output <= input(0) or input(1) or input(2) or input(3);
end architecture structure;