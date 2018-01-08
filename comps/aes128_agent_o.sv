`ifndef __AES128_AGENT_O_SV__
`define __AES128_AGENT_O_SV__

class aes128_agent_o extends uvm_agent;
   `uvm_component_utils(aes128_agent_o)

   aes128_config        aes128_cfg;
   aes128_monitor_out   aes128_mon_out;

   function new(string name = "aes128_agent_o", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(aes128_config)::get(this, "", "aes128_cfg", aes128_cfg))
         `uvm_fatal("aes128_agent", "aes128_cfg must be set!!!")
      aes128_mon_out = aes128_monitor_out::type_id::create("aes128_mon_out", this);
      uvm_config_db#(virtual aes128_if)::set(this, "aes128_mon_out", "vif", aes128_cfg.aes128_vif);
   endfunction

endclass

`endif

