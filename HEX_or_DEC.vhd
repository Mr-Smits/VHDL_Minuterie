library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HEX_or_DEC is 
    port(
        choice : in std_logic;
        value : in std_logic_vector(3 downto 0);
        dig1 : out std_logic_vector(3 downto 0);
        dig2 : out std_logic_vector(6 downto 0)
    );
end entity HEX_or_DEC;

architecture dataflow of HEX_or_DEC is
    
    --internal signals :
    signal value_int: integer;

begin

    process(value, choice)
    begin
        if choice ='1' then
            value_int <= to_integer(unsigned(value));
            --dizaine :
            if value_int >= 10 then
                
                dig2 <= "1111001";
            else 
                dig2 <= "1111111";
            end if;
            --unité :
            dig1 <=std_logic_vector(to_unsigned((value_int mod 10),4));
        else
            dig2 <= "1111111";
            dig1 <= value;
        end if;
    end process;
    
end architecture dataflow;