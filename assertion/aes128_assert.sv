`ifndef __AES128_ASSERT_SV__
`define __AES128_ASSERT_SV__

interface aes128_assert();

   logic clk;
   logic rst_n;

   wire assert_load = top.dut.load_i;
   wire assert_encrypt_decrypt = top.dut.decrypt_i;

   property load_high_encrypt_decrypt_low_at_same_time;
      @(posedge clk) disable iff(!rst_n)
      (assert_load == 1) |-> (assert_encrypt_decrypt == 0);
   endproperty

   property load_high_encrypt_decrypt_high_at_same_time;
      @(posedge clk) disable iff(!rst_n)
      (assert_load == 1) |-> (assert_encrypt_decrypt == 1);
   endproperty

   cover_load_high_encrypt_decrypt_low_at_same_time : cover property (load_high_encrypt_decrypt_low_at_same_time);
   cover_load_high_encrypt_decrypt_high_at_same_time : cover property (load_high_encrypt_decrypt_high_at_same_time);

endinterface

`endif

