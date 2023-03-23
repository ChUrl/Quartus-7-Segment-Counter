`default_nettype none

module BinToBcd_TestBench;

  var logic clock, reset, decrement;
  tri[13:0] binout;

  Counter cnt(
    .clock(clock),
    .reset(reset),
    .decrement(decrement),
    .binout(binout)
  );
  
  tri[3:0] value[3:0];
  
  BinToBcd bcd(
    .binin(binout),
	 .bcdout(value)
  );
  
// synthesis translate_off
  integer ii;
  initial begin
    $timeformat(-9, 2, " ns", 20);
	 
    $display("%0t Reset", $time);
	 decrement = 0;
    #20 reset = 1;
	 #20 reset = 0;
	 assert (value[0] == 0);
	 assert (value[1] == 0);
	 assert (value[2] == 0);
	 assert (value[3] == 0);
	 
	 $display("%0t Bin[1] = 0 0 0 1", $time);
	 #20 clock = 1;
	 #20 clock = 0;
	 assert (value[0] == 1);
	 assert (value[1] == 0);
	 assert (value[2] == 0);
	 assert (value[3] == 0);
	 
	 $display("%0t Bin[1024] = 1 0 2 4", $time);
	 for (ii = 0; ii < 1023; ii = ii + 1) begin
	   #20 clock = 1;
		#20 clock = 0;
	 end
	 assert (value[0] == 4);
	 assert (value[1] == 2);
	 assert (value[2] == 0);
	 assert (value[3] == 1);
	 
	 $display("Success!");
  end
  
// synthesis translate_on
endmodule