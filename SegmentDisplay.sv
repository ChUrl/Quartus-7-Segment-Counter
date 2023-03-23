`default_nettype none

module SegmentDisplay
  #(parameter integer DIGITS = 4,
    parameter integer WIDTH = 14)(
  input var logic reset,
  input var logic clock,
  input var logic decrement,
  output var logic[6:0] segments[DIGITS-1:0]
);

  tri[WIDTH-1:0] cntout;
  tri[3:0] bcdout[DIGITS-1:0];

  Counter cnt(
    // The KEY's provide a high logic level when not pressed
    .clock(~clock),
	 .reset(~reset),
	 .decrement(decrement),
	 .binout(cntout)
  );
  
  BinToBcd bcd(
    .binin(cntout),
	 .bcdout(bcdout)
  );
  
  SegDriver seg(
    .bcdin(bcdout),
	 .segments(segments)
  );

endmodule