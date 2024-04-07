library ieee;
use ieee.std_logic_1164.all;

entity Minuterie_1 is
    port (
        arst_n : in std_logic;
        clk : in std_logic;
        BP_in : in std_logic;
        SW : in std_logic_vector(3 downto 0);
        SW_MEM : in std_logic_vector(3 downto 0);
        choice : in std_logic;
        LEDR0 : out std_logic;
        HEX0 : out std_logic_vector(6 downto 0);
        HEX1 : out std_logic_vector(6 downto 0);
        HEX4 : out std_logic_vector(6 downto 0);
        HEX5 : out std_logic_vector(6 downto 0)
    );
end entity Minuterie_1;

architecture structure of Minuterie_1 is
    
    --Components :
    component detection_PB is
        port(
            clk : in std_logic;
            BP_in : in std_logic := '1';
            S : out std_logic
        );
    end component detection_PB;

    component timer_1sec is 
        port(
            arst_n : in std_logic;
            clk : in std_logic;
            S : out std_logic
        );
    end component timer_1sec;

    component Decompteur is 
        port(
            arst_n : in std_logic;
            clk : in std_logic;
            sclr : in std_logic;
            clr_value : in std_logic_vector(3 downto 0);
            en : in std_logic;
            cntr_out : out std_logic_vector(3 downto 0)
        );
    end component Decompteur;

    component Output_Logic is
        port(
            input : in std_logic_vector(3 downto 0);
            output : out std_logic
        );
    end component Output_logic;

    component Transcodeur_7Seg is
        port(
            SW : in std_logic_vector(3 downto 0);
            HEX0 : out std_logic_vector(6 downto 0)
        );
    end component Transcodeur_7Seg;

    component HEX_or_DEC is 
        port(
            choice : in std_logic;
            value : in std_logic_vector(3 downto 0);
            dig1 : out std_logic_vector(3 downto 0);
            dig2 : out std_logic_vector(6 downto 0)
        );
    end component HEX_or_DEC;

    component memoire is
        port (
            arst_n : in std_logic;
            clk : in std_logic;
            value : in std_logic_vector(3 downto 0);
            en : in std_logic;
            SW : in std_logic_vector(3 downto 0);
            mem_value : out std_logic_vector(3 downto 0)        
        );
    end component memoire;

    --Internal signals :
    signal set_timer : std_logic;
    signal timer_out : std_logic;
    signal cntr_null : std_logic;
    signal enable : std_logic;
    signal cntr_out : std_logic_vector(3 downto 0);
    signal led : std_logic;
    signal hex_value : std_logic_vector(3 downto 0);
    signal mem_out : std_logic_vector(3 downto 0);
    signal mem_value : std_logic_vector(3 downto 0);
    
begin
    BP : detection_PB port map(
        clk => clk,
        BP_in => BP_in,
        S => set_timer);

    TIMER : timer_1sec port map(
        arst_n => set_timer,
        clk => clk,
        S => timer_out);

    enable <= cntr_null AND timer_out;

    CNPT : Decompteur port map(
        arst_n => arst_n,
        clk => clk,
        sclr => set_timer,
        clr_value => SW,
        en => enable,
        cntr_out => cntr_out);

    OUTPUT : Output_Logic port map(
        input => cntr_out,
        output => cntr_null);

    LEDR0 <= cntr_null;
    
    SEG : Transcodeur_7Seg port map(
        SW => hex_value,
        HEX0 => HEX0);

    HEX_DEC : HEX_or_DEC port map(
        choice => choice,
        value =>cntr_out,
        dig1 => hex_value,
        dig2 => HEX1);

    MEM : memoire port map(
        arst_n => arst_n,
        clk => clk,
        value => SW,
        en => set_timer,
        SW => SW_mem,
        mem_value => mem_out);

    SEG_2 : Transcodeur_7Seg port map(
        SW => mem_value,
        HEX0 => HEX4);

    HEX_DEC_2 : HEX_or_DEC port map(
        choice => choice,
        value =>mem_out,
        dig1 => mem_value,
        dig2 => HEX5);
    
end architecture structure;