library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memoire is
    port (
        arst_n : in std_logic;
        clk : in std_logic;
        value : in std_logic_vector(3 downto 0);
        en : in std_logic;
        SW : in std_logic_vector(3 downto 0);
        mem_value : out std_logic_vector(3 downto 0)        
    );
end entity memoire;

architecture structure of memoire is
    type t_memory is array (0 to 15) of std_logic_vector(3 downto 0);
    signal memory : t_memory;

    signal counter : integer := 0;

begin

    process(arst_n, clk)
    begin
        if arst_n = '0' then 
        counter <= 0;
        for ii in 0 to 15 loop
            memory(ii) <= "0000";
        end loop;

        elsif rising_edge(clk) then
            if en = '1' then
                memory(counter) <= value;
                if counter < 15 then
                counter <= counter + 1;
                else 
                counter <= 0;
                end if;
            end if;
        end if;
    end process;

    mem_value <= memory(to_integer(unsigned(SW)));

end architecture structure;