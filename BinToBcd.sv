`default_nettype none

// https://en.wikipedia.org/wiki/Double_dabble
module BinToBcd
  #(parameter integer DIGITS = 4,
    parameter integer WIDTH = 14)(
  input var logic[WIDTH-1:0] binin,
  output var logic[3:0] bcdout[DIGITS-1:0]
);

  // Easier to operate on a packed array
  var logic[DIGITS*4-1:0] bcdscratch;

  integer ii, jj;
  always @(binin) begin
    bcdscratch = '0;
	 
	 // Iterate over each bit
	 for (ii = 0; ii < WIDTH; ii = ii + 1) begin
		
		// Iterate over each digit
		for (jj = 0; jj < DIGITS; jj = jj + 1) begin
		  // Add three, if digit >= 5
		  if (bcdscratch[(jj+1)*4-1 -: 4] >= 5) begin
		    // Select the digit: 1st digit [7:4], 2nd digit [11:8], etc.
			 // The -: or +: syntax specify the length of the slice
		    bcdscratch[(jj+1)*4-1 -: 4] = bcdscratch[(jj+1)*4-1 -: 4] + 3;
		  end
		end
		
		// Shift to left and fill with lsb with corresponding binin bit
	   bcdscratch = {bcdscratch[DIGITS*4-2:0], binin[WIDTH-1-ii]};
    end
	 
	 // Iterate over each digit
	 for (jj = 0; jj < DIGITS; jj = jj + 1) begin
	   // Assign scratch buffer to bcdout
		bcdout[jj] = bcdscratch[(jj+1)*4-1 -: 4];
	 end
  end
endmodule