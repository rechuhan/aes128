`ifndef __AES128_AGENT_I_SV__
`define __AES128_AGENT_I_SV__

class aes128_agent_i extends uvm_agent;
   `uvm_component_utils(aes128_agent_i)

   aes128_config        aes128_cfg;
   aes128_sequencer     aes128_sqr;
   aes128_driver        aes128_drv;
   aes128_monitor_in    aes128_mon_in;

   function new(string name = "aes128_agent_i", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(aes128_config)::get(this, "", "aes128_cfg", aes128_cfg))
         `uvm_fatal("aes128_agent", "aes128_cfg must be set!!!")
      aes128_sqr = aes128_sequencer::type_id::create("aes128_sqr", this);
      aes128_drv = aes128_driver::type_id::create("aes128_drv", this);
      aes128_mon_in = aes128_monitor_in::type_id::create("aes128_mon_in", this);
      uvm_config_db#(virtual aes128_if)::set(this, "aes128_drv", "vif", aes128_cfg.aes128_vif);
      uvm_config_db#(virtual aes128_if)::set(this, "aes128_mon_in", "vif", aes128_cfg.aes128_vif);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      aes128_drv.seq_item_port.connect(aes128_sqr.seq_item_export);
   endfunction

endclass

`endif

