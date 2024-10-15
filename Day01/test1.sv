// QUE: clk is 100MHz and resetn is a low active asynchronous reset.
// When addr_in/data_in that is input is valid and active, it is accepted and after 1 clock, it is output as addr_out_a/data_out_a and addr_out_b/data_out_b according to the criteria below.
// If addr_in is less than 0x3F, output addr_in/data_in as addr_out_a/data_out_a.
// If addr_in is 0x40 or higher, output addr_in/data_in to addr_out_b/data_out_b.
// The valid interval of addr/data is 1 clock cycle.   Coding challenge for freshers  based above design spec and diagram write design code & systemverilog verification
// valid is an active high signal with a length of 1 clock period.
//
//

`timescale 1ns / 1ps

module test1 (
    clk,
    resetn,
    valid,
    addr_in,
    addr_out_a,
    addr_out_b,
    data_in,
    data_out_a,
    data_out_b
);

  input logic clk, resetn, valid;
  input logic [7:0] addr_in;
  input logic [15:0] data_in;
  output logic [7:0] addr_out_a, addr_out_b;
  output logic [15:0] data_out_a, data_out_b;

  // logic [15:0] temp;

  always_ff @(posedge clk) begin
    if (~resetn) begin

      data_out_a <= 0;
      data_out_b <= 0;

      addr_out_a <= 0;
      addr_out_b <= 0;

    end else begin
      if (valid) begin

        if (addr_in < 8'h3F) begin  // addr_in < 63
          addr_out_a <= addr_in;
          data_out_a <= data_in;
        end else if (addr_in > 8'h40) begin  // addr_in > 63
          addr_out_b <= addr_in;
          data_out_b <= data_in;
        end

      end else begin
        addr_out_a <= 'b0;
        addr_out_b <= 'b0;
        data_out_a <= 'b0;
        data_out_b <= 'b0;
      end

    end
  end

endmodule
