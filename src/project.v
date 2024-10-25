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

  reg [7:0] ui_buf;
  always @(posedge clk) begin
    if (!rst_n) begin
      ui_buf <= 8'b0;
    end else begin
      ui_buf <= ui_in;
    end
  end

  reg [63:0] snake;
  always @(posedge clk) begin
    if (!rst_n) begin
      snake <= 64'b0;
    end else begin
      snake <= {snake[55:0], ui_buf};
    end
  end

  reg [63:0] snaake;
  always @(posedge clk) begin
    if (!rst_n) begin
      snaake <= 64'b0;
    end else begin
      snaake <= {snaake[55:0], snake[63:56]};
    end
  end

  reg [63:0] snaaake;
  always @(posedge clk) begin
    if (!rst_n) begin
      snaaake <= 64'b0;
    end else begin
      snaaake <= {snaaake[55:0], snaake[63:56]};
    end
  end

  reg [63:0] snaaaake;
  always @(posedge clk) begin
    if (!rst_n) begin
      snaaaake <= 64'b0;
    end else begin
      snaaaake <= {snaaaake[55:0], snaaake[63:56]};
    end
  end

  assign uo_out = snaaaake[63:56];

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  wire _unused = &{ena, uio_in, 1'b0};

endmodule
