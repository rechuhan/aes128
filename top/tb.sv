`ifndef __TB_SV__
`define __TB_SV__

class tb extends uvm_env;
   `uvm_component_utils(tb)

   aes128_env env;
   virtual_sequencer v_sqr;

   function new(string name = "tb", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = aes128_env::type_id::create("env", this);
      v_sqr = virtual_sequencer::type_id::create("v_sqr", this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      v_sqr.aes128_sqr = env.aes128_agt_i.aes128_sqr;
   endfunction

endclass

`endif

