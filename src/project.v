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

  reg [2047:0] ugh;
  assign uo_out = ugh[2047:2040];
  assign ui_in = ugh[7:0];

  integer i;
  always @(posedge clk) begin
    for (i = 0; i < 2046; i = i + 1) begin
      ugh[i+1] <= ugh[i];
    end
    ugh[0] <= rst_n;
  end

  /*
  localparam e    = 2'b01;
  localparam ee   = 2'b10;
  localparam eee  = 2'b11;
  localparam eeee = 2'b11;

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        doh <= sorry;

    end else begin
      case (doh)
        sorry: begin
            doh <= e;
        end
        e: begin
            doh <= ee;
        end
        ee: begin
            doh <= eee;
        end
        eee: begin
            doh <= eeee;
        end default:;
      endcase
    end
  end
  */


  /*
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
  */

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 8'hff;
  assign uio_in  = 8'haa;
  assign uio_oe  = 8'hf;

  wire _unused = &{ena, 1'b0};

endmodule
