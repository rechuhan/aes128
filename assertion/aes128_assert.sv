`ifndef __AES128_ASSERT_SV__
`define __AES128_ASSERT_SV__

interface aes128_assert();

   logic clk;
   logic rst_n;

   wire assert_load = top.dut.load_i;
   wire assert_ready = top.dut.ready_o;

   property cycle_check;
      @(posedge clk) disable iff(!rst_n)
      (assert_load == 1) |-> ##505 (assert_ready == 1);
   endproperty

   assert_cycle_check : assert property(cycle_check);

endinterface

`endif

