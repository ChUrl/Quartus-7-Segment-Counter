`default_nettype none

module Counter
  #(parameter integer DIGITS = 4,
    parameter integer WIDTH = 14)(
  input var logic clock,
  input var logic reset,
  input var logic decrement,
  output var logic[WIDTH-1:0] binout
);

  var logic[WIDTH-1:0] countervalue;

  always @(posedge clock or posedge reset)
    if (reset) begin
	   // Reset the counter to 0
      countervalue <= '0;
    end else if (~decrement) begin
	   // Increment the counter
      if (countervalue == 10**DIGITS-1) begin
		  // Overflow
		  countervalue <= '0;
		end else begin
		  countervalue <= countervalue + 1;
		end
    end else if (decrement) begin
	   // Decrement the Counter
		if (countervalue == 0) begin
		  // Underflow
		  countervalue <= '{10**DIGITS-1};
		end else begin
		  countervalue <= countervalue - 1;
		end
	 end

  assign binout = countervalue;
endmodule