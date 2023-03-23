`default_nettype none

module SingleSegDriver(
  input var logic[3:0] bcdin,
  output var logic[6:0] segments
);

  // The segments are enabled on a low logic level
  always_comb case (bcdin)
    //   +----a----+
    //   |         |
    //   f         b
    //   |         |
    //   +----g----+
    //   |         |
    //   e         c
    //   |         |
    //   +----d----+        gfedcba
    4'b0000: segments = ~7'b0111111;
    4'b0001: segments = ~7'b0000110;
    4'b0010: segments = ~7'b1011011;
    4'b0011: segments = ~7'b1001111;
    4'b0100: segments = ~7'b1100110;
    4'b0101: segments = ~7'b1101101;
    4'b0110: segments = ~7'b1111101;
    4'b0111: segments = ~7'b0000111;
    4'b1000: segments = ~7'b1111111;
    4'b1001: segments = ~7'b1100111;
    default: segments = ~7'b0;
  endcase
endmodule

module SegDriver
  #(parameter integer DIGITS = 4)(
  input var logic[3:0] bcdin[DIGITS-1:0],
  output var logic[6:0] segments[DIGITS-1:0]
);

  genvar ii;
  generate
	 for (ii = 0; ii < DIGITS; ii = ii + 1) begin : generate_seg_drivers
      SingleSegDriver ssd(
        .bcdin(bcdin[ii]),
        .segments(segments[ii])
      );
    end
  endgenerate
endmodule