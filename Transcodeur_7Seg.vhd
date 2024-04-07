library ieee;
use ieee.std_logic_1164.all;

entity Transcodeur_7Seg is
    port(
        SW : in std_logic_vector(3 downto 0);
        HEX0 : out std_logic_vector(6 downto 0)
    );
end entity Transcodeur_7Seg;

architecture dataflow of Transcodeur_7Seg is 
begin

    process(SW)
    begin

        case SW is
            when "0000" =>  --0
                HEX0 <= "1000000";
            when "0001" =>  --1
                HEX0 <= "1111001";
            when "0010" =>  --2
                HEX0 <= "0100100";
            when "0011" =>  --3
                HEX0 <= "0110000";
            when "0100" =>  --4
                HEX0 <= "0011001";
            when "0101" =>  --5
                HEX0 <= "0010010";
            when "0110" =>  --6
                HEX0 <= "0000010";
            when "0111" =>  --7
                HEX0 <= "1111000";
            when "1000" =>  --8
                HEX0 <= "0000000";
            when "1001" =>  --9
                HEX0 <= "0010000";
            when "1010" =>  --A
                HEX0 <= "0001000";
            when "1011" =>  --B
                HEX0 <= "0000011";
            when "1100" =>  --C
                HEX0 <= "1000110";
            when "1101" =>  --D
                HEX0 <= "0100001";
            when "1110" =>  --E
                HEX0 <= "0000110";
            when others =>   --F
                HEX0 <= "0001110";
        end case;

    end process;

end architecture dataflow;


