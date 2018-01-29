`ifndef __AES128_CONFIG_SV__
`define __AES128_CONFIG_SV__

class aes128_config extends uvm_object;

   virtual aes128_if aes128_vif;

   bit has_coverage;
   uvm_active_passive_enum is_active;

   `uvm_object_utils_begin(aes128_config)
      `uvm_field_int(has_coverage, UVM_ALL_ON);
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON);
   `uvm_object_utils_end

   function new(string name = "aes128_config");
      super.new(name);
      has_coverage = 0;
      is_active = UVM_ACTIVE;
   endfunction

endclass

`endif

