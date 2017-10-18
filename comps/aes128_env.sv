`ifndef __AES128_ENV_SV__
`define __AES128_ENV_SV__

class aes128_env extends uvm_env;
   `uvm_component_utils(aes128_env)

   aes128_agent aes128_agt;

   function new(string name = "aes128_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      aes128_agt = aes128_agent::type_id::create("aes128_agt", this);
   endfunction

endclass

`endif

