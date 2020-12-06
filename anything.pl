#!/usr/bin/perl
use strict;
use warnings;
 #-----Doc file
open(ASMF, "<ex11.asm");
open(BINF, ">ex11.bin"); 

my %TypeR = ("add", "addu", "and", "jr");
my %TypeI = ("addi", "addiu", "andi", "beq", "bne", "lbu", "lhu", "lui", "lw", "sw");
my %TypeJ = ("j", "jal");

#$line =~ s/,/ /g; tim dau , thay bang  spacce

my $line;
my @temp;
my @InstField;
my $instBin;

my %InstType =
(
	 "add"	=>	"R",
	 "addu"	=>	"R",
	 "and"	=>	"R",
	 "jr"	=>	"RJ",
	 "addi"	=>	"I",
	 "addiu"=>	"I",
	 "andi"	=>	"I",
	 "beq"	=>	"I",
	 "bne"	=>	"I",
	 "j"	=>	"J",
	 "jal"	=>	"J",
	 "lbu"	=>	"I",
	 "lhu"	=>	"I",
	 "lui"	=>	"I",
	 "lw"	=>	"I",
	 "sw"	=>	"I",
);
my %InstReg =
(
	 "\$0"	=>	"00000",
	 "\$1"	=>	"00001",
	 "\$2"	=>	"00010",
	 "\$3"	=>	"00011",
	 "\$4"	=>	"00100",
	 "\$5"	=>	"00101",
	 "\$6"	=>	"00110",
	 "\$7"	=>	"00111",
	 "\$8"	=>	"01000",
	 "\$9"	=>	"01001",
	 "\$10"	=>	"01010",
	 "\$11"	=>	"01011",
	 "\$12"	=>	"01100",
	 "\$13"	=>	"01101",
	 "\$14"	=>	"01110",
	 "\$15"	=>	"01111",
	 "\$16"	=>	"10000",
	 "\$17"	=>	"10001",
	 "\$18"	=>	"10010",
	 "\$19"	=>	"10011",
	 "\$20"	=>	"10100",
	 "\$21"	=>	"10101",
	 "\$22"	=>	"10110",
	 "\$23"	=>	"10111",
	 "\$24"	=>	"11000",
	 "\$25"	=>	"11001",
	 "\$26"	=>	"11010",
	 "\$27"	=>	"11011",
	 "\$28"	=>	"11100",
	 "\$29"	=>	"11101",
	 "\$30"	=>	"11110",
	 "\$31"	=>	"11111",

	 "\$zero"	=>	"00000",
	 "\$at"	=>	"00001",
	 "\$v0"	=>	"00010",
	 "\$v1"	=>	"00011",
	 "\$a0"	=>	"00100",
	 "\$a1"	=>	"00101",
	 "\$a2"	=>	"00110",
	 "\$a3"	=>	"00111",
	 "\$t0"	=>	"01000",
	 "\$t1"	=>	"01001",
	 "\$t2"	=>	"01010",
	 "\$t3"	=>	"01011",
	 "\$t4"	=>	"01100",
	 "\$t5"	=>	"01101",
	 "\$t6"	=>	"01110",
	 "\$t7"	=>	"01111",
	 "\$s0"	=>	"10000",
	 "\$s1"	=>	"10001",
	 "\$s2"	=>	"10010",
	 "\$s3"	=>	"10011",
	 "\$s4"	=>	"10100",
	 "\$s5"	=>	"10101",
	 "\$s6"	=>	"10110",
	 "\$s7"	=>	"10111",
	 "\$t8"	=>	"11000",
	 "\$t9"	=>	"11001",
	 "\$k0"	=>	"11010",
	 "\$k1"	=>	"11011",
	 "\$gp"	=>	"11100",
	 "\$sp"	=>	"11101",
	 "\$fp"	=>	"11110",
	 "\$ra"	=>	"11111",
);
my %InstFunct =
(
	 "add"	=>	"100000",
	 "addu"	=>	"100001",
	 "and"	=>	"100100",
	 "jr"	=>	"001000",
	 "addi"	=>	"",
	 "addiu"=>	"",
	"andi"	=>	"",
	 "beq"	=>	"",
	 "bne"	=>	"",
	 "j"	=>	"",
	 "jal"	=>	"",
	 "lbu"	=>	"",
	 "lhu"	=>	"",
	 "lui"	=>	"",
	 "lw"	=>	"",
	 "sw"	=>	"",
);
my %InstOpcode = 
(
	 "add"	=>	"000000",
	 "addu"	=>	"000000",
	 "and"	=>	"000000",
	 "jr"	=>	"000000",
	 "addi"	=>	"001000",
	 "addiu"=>	"001001",
	 "andi"	=>	"001100",
	 "beq"	=>	"000100",
	 "bne"	=>	"000101",
	 "j"	=>	"000010",
	 "jal"	=>	"000100",
	 "lbu"	=>	"100100",
	 "lhu"	=>	"100101",
	 "lui"	=>	"001111",
	 "lw"	=>	"100011",
	 "sw"	=>	"101011",
);
my %InstLabel =
(

	);

sub tobin
{
	my ($decvalue) = @_; 
	my $binvalue = sprintf( "%016b", $decvalue  );
	return $binvalue;
}

	
for $line (<ASMF>)
{
    $line =~ s/,//g;
    $line =~ s/\(/ /g;
    $line =~ s/\)/ /g;
    @temp = split(/#/, $line);
    next if($line =~ /^$/);
    next if($line =~ /^#/);
    next if($line =~ /.:/);
    @InstField = split(/ /, $temp[0]);
    if($InstType{$InstField[0]} eq "R" )
    {
        $instBin = "$InstOpcode{$InstField[0]}". 
                   "$InstReg{$InstField[2]}".
                   "$InstReg{$InstField[3]}".
                   "$InstReg{$InstField[1]}".
                   "00000".
                   "$InstFunct{$InstField[0]}";
    }   
  if ($InstType{$InstField[0]} eq "RJ" )
   	{
   		$InstField[1] = tobin(find_address($InstField[1]));
    	$instBin = "$InstOpcode{$InstField[0]}".
   					"$InstField[1]".
                  	"$InstFunct{$InstField[0]}";
    }
  	if($InstType{$InstField[0]} eq "I" )
    {
    	if ( $InstOpcode{$InstField[0]} eq "001000" 
    		or $InstOpcode{$InstField[0]} eq "001001"
    		or $InstOpcode{$InstField[0]} eq "001100")
    	{
    		$InstField[3] = tobin($InstField[3]);
        	$instBin = "$InstOpcode{$InstField[0]}". 
                   		"$InstReg{$InstField[2]}".
                   		"$InstReg{$InstField[1]}".
                   		"$InstField[3]";
        }
        elsif ($InstOpcode{$InstField[0]} eq "100011"
        	or $InstOpcode{$InstField[0]} eq "101011")
       {
       	$InstField[2] = tobin($InstField[2]);
       	$instBin = "$InstOpcode{$InstField[0]}". 
                  		"$InstReg{$InstField[3]}".
                  		"$InstReg{$InstField[1]}".
                  		"$InstField[2]";
       }
       elsif ($InstOpcode{$InstField[0]} eq "000100"
       	or $InstOpcode{$InstField[0]} eq "000101")
       {
       	$InstField[3] = tobin(find_address($InstField[3]));
       	$instBin = "$InstOpcode{$InstField[0]}". 
                  		"$InstReg{$InstField[2]}".
                  		"$InstReg{$InstField[1]}".
                  		"$InstField[3]";
       }

    } 
    if($InstType{$InstField[0]} eq "J" )
    {
    	$InstField[1] = tobin(find_address($InstField[1]));
    	$instBin = "$InstOpcode{$InstField[0]}". 
                  	"$InstField[1]";
                  		
    }


 
    #print($line);
    print BINF ("$instBin\n");
    #print BINF "$line";
}
# I


sub find_address
{
	my ($bella) = @_;
	my $count = 0;
	for $line (<ASMF>)
	{
		if($line =~ /$bella/)
		{
			$count ++;
		};

	}
	return $count * 4;
}


close(ASMF);
close(BINF);