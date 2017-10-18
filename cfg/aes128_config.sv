`ifndef __AES128_CONFIG_SV__
`define __AES128_CONFIG_SV__

class aes128_config extends uvm_object;
   `uvm_object_utils(aes128_config)

   virtual aes128_if aes128_vif;

   function new(string name = "aes128_config");
      super.new(name);
   endfunction

endclass

`endif

