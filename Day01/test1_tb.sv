`timescale 1ns / 1ps

module test1_tb ();

  logic clk, resetn, valid;
  logic [ 7:0] addr_in;
  logic [15:0] data_in;
  logic [7:0] addr_out_a, addr_out_b;
  logic [15:0] data_out_a, data_out_b;

  test1 dut (.*);

  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  task static run(input logic [7:0] add, input logic [15:0] data);
    addr_in = add;
    data_in = data;
  endtask : run

  task static valid_run();
    valid = 1'b1;
    @(posedge clk);
    valid = 1'b0;
  endtask : valid_run

  initial begin

    resetn = 1'b0;
    valid  = 1'b0;
    repeat (2) @(posedge clk);
    resetn = 1'b1;

    run(8'd20, 16'd100);
    valid_run;

    repeat (2) @(posedge clk);

    run(8'd100, 16'd200);
    valid_run;

    #100 $finish;

  end


endmodule
