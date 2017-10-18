`timescale 1ns/10ps
`include "aes128_assert.sv"
module top;

   import uvm_pkg::*;
   `include "uvm_macros.svh"

   import crypto_dpi_pkg::*;
   import aes128_pkg::*;
   import tb_pkg::*;

   `include "test_lib.sv"

   bit clk, rst_n;

   //assert
   aes128_assert aes128_assert_check();
   assign aes128_assert_check.clk = clk;
   assign aes128_assert_check.rst_n = rst_n;

   aes128_if aes128_if(clk, rst_n);

   aes dut(
      .clk(clk),
      .reset(rst_n),
      .load_i(aes128_if.load_i),
      .decrypt_i(aes128_if.decrypt_i),
      .data_i(aes128_if.data_i),
      .key_i(aes128_if.key_i),
      .ready_o(aes128_if.ready_o),
      .data_o(aes128_if.data_o));

   initial begin
      uvm_config_db#(virtual aes128_if)::set(null, "*", "aes128_if", aes128_if);
      run_test();
   end

   initial begin
      clk = 0;
      forever #5ns clk = ~ clk;
   end

   initial begin
      rst_n = 0;
      #100ns;
      rst_n = 1;
   end

   initial begin
      $vcdplusfile("top.vpd");
      $vcdpluson(0, top);
   end

endmodule

