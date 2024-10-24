/*
 * Copyright (c) 2024 Steven Kneiser
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_xxd_theshteves (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [7:0] fib;
  reg [7:0] next_fib;

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out = fib;
  assign uio_out = 0;
  assign uio_oe  = 0;

  always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
          fib <= 1;
          next_fib <= 1;
      end else begin
          fib <= next_fib;
          next_fib <= fib + next_fib;
      end
  end

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
