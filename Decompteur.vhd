library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decompteur is 
    port(
        arst_n : in std_logic;
        clk : in std_logic;
        sclr : in std_logic;
        clr_value : in std_logic_vector(3 downto 0);
        en : in std_logic;
        cntr_out : out std_logic_vector(3 downto 0)
    );
end entity Decompteur;

architecture structure of Decompteur is
    
    --signal intern :
    signal counter : integer := 0;

begin
    
    process(arst_n, clk)
    begin
        if arst_n = '0' then
            counter <= 0;
            
        elsif rising_edge(clk) then
            
            if en = '1' then
                counter <= counter - 1;
            end if;

            if sclr = '1' then
                counter <= to_integer(unsigned(clr_value));
            end if;

        end if;
    end process;

    cntr_out <= std_logic_vector(to_unsigned(counter,4));

end architecture structure;