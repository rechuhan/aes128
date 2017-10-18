`ifndef __AES128_FUNC_COV_SV__
`define __AES128_FUNC_COV_SV__

class aes128_func_cov extends uvm_subscriber#(aes128_transaction);
   `uvm_component_utils(aes128_func_cov)

   covergroup cov_encrypt_decrypt with function sample(aes128_transaction tr);
      option.per_instance = 1;

      encrypt_decrypt : coverpoint tr.encrypt_decrypt {
         bins encrypt = {0};
         bins decrypt = {1};
      }
   endgroup

   function new(string name = "aes128_func_cov", uvm_component parent);
      super.new(name, parent);
      cov_encrypt_decrypt = new();
   endfunction

   function void write(aes128_transaction t);
      cov_encrypt_decrypt.sample(t);
   endfunction

endclass

`endif

