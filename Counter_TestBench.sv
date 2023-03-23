`default_nettype none

module Counter_TestBench;

  var logic clock, reset, decrement;
  tri[13:0] value;

  Counter cnt(
    .clock(clock),
    .reset(reset),
    .decrement(decrement),
    .binout(value)
  );

// synthesis translate_off
  integer ii;
  initial begin
    $timeformat(-9, 2, " ns", 20);
	 
	 $display("%0t Initial Reset", $time);
    #20 reset = 1;
	 #20 reset = 0;
	 assert (value == 0);
	 
	 $display("%0t Increment 1024x", $time);
	 decrement = 0;
	 for (ii = 0; ii < 1024; ii = ii + 1) begin
		#20 clock = 1;
		#20 clock = 0;
	   assert (value == ii + 1);
	 end
	 
	 $display("%0t Decrement 1024x", $time);
	 decrement = 1;
	 for (ii = 1024; ii > 0; ii = ii - 1) begin
		#20 clock = 1;
		#20 clock = 0;
	   assert (value == ii - 1);
	 end
	 
	 $display("%0t Increment 1024x", $time);
	 decrement = 0;
	 for (ii = 0; ii < 1024; ii = ii + 1) begin
		#20 clock = 1;
		#20 clock = 0;
	   assert (value == ii + 1);
	 end
	 
	 $display("%0t Reset", $time);
	 #20 reset = 1;
	 #20 reset = 0;
	 assert (value == 0);
	 
	 $display("%0t Increment 9999x", $time);
	 decrement = 0;
	 for (ii = 0; ii < 9999; ii = ii + 1) begin
		#20 clock = 1;
		#20 clock = 0;
	   assert (value == ii + 1);
	 end
	 
	 $display("%0t Overflow", $time);
	 #20 clock = 1;
	 #20 clock = 0;
	 assert (value == 0);
	 
	 $display("%0t Underflow", $time);
	 decrement = 1;
	 #20 clock = 1;
	 #20 clock = 0;
	 assert (value == 9999);
	 
	 $display("Success!");
  end
  
// synthesis translate_on
endmodule