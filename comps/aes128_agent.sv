`ifndef __AES128_AGENT_SV__
`define __AES128_AGENT_SV__

class aes128_agent extends uvm_agent;
   `uvm_component_utils(aes128_agent)

   aes128_config        aes128_cfg;
   aes128_sequencer     aes128_sqr;
   aes128_driver        aes128_drv;
   aes128_monitor_in    aes128_mon_in;
   aes128_monitor_out   aes128_mon_out;
   aes128_model         aes128_mdl;
   aes128_scoreboard    aes128_scb;

   aes128_func_cov      aes128_f_cov;

   uvm_tlm_analysis_fifo #(aes128_transaction) mon_in_2_mdl_fifo;
   uvm_tlm_analysis_fifo #(aes128_transaction) mdl_2_scb_fifo;
   uvm_tlm_analysis_fifo #(aes128_transaction) mon_out_2_scb_fifo;

   function new(string name = "aes128_agent", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(aes128_config)::get(this, "", "aes128_cfg", aes128_cfg))
         `uvm_fatal("aes128_agent", "aes128_cfg must be set!!!")

      aes128_sqr = aes128_sequencer::type_id::create("aes128_sqr", this);
      aes128_drv = aes128_driver::type_id::create("aes128_drv", this);
      aes128_mon_in = aes128_monitor_in::type_id::create("aes128_mon_in", this);
      aes128_mon_out = aes128_monitor_out::type_id::create("aes128_mon_out", this);
      aes128_mdl = aes128_model::type_id::create("aes128_mdl", this);
      aes128_scb = aes128_scoreboard::type_id::create("aes128_scb", this);

      aes128_f_cov = aes128_func_cov::type_id::create("aes128_f_cov", this);

      mon_in_2_mdl_fifo = new("mon_in_2_mdl_fifo", this);;
      mdl_2_scb_fifo = new("mdl_2_scb_fifo", this);
      mon_out_2_scb_fifo = new("mon_out_2_scb_fifo", this);

      uvm_config_db#(virtual aes128_if)::set(this, "aes128_drv", "vif", aes128_cfg.aes128_vif);
      uvm_config_db#(virtual aes128_if)::set(this, "aes128_mon_in", "vif", aes128_cfg.aes128_vif);
      uvm_config_db#(virtual aes128_if)::set(this, "aes128_mon_out", "vif", aes128_cfg.aes128_vif);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      aes128_drv.seq_item_port.connect(aes128_sqr.seq_item_export);
      aes128_mon_in.mon_in_2_mdl_fifo_in.connect(mon_in_2_mdl_fifo.analysis_export);
      aes128_mdl.mon_in_2_mdl_fifo_out.connect(mon_in_2_mdl_fifo.blocking_get_export);
      aes128_mdl.mdl_2_scb_fifo_in.connect(mdl_2_scb_fifo.analysis_export);
      aes128_scb.mdl_2_scb_fifo_out.connect(mdl_2_scb_fifo.blocking_get_export);
      aes128_mon_out.mon_out_2_scb_fifo_in.connect(mon_out_2_scb_fifo.analysis_export);
      aes128_scb.mon_out_2_scb_fifo_out.connect(mon_out_2_scb_fifo.blocking_get_export);

      aes128_mon_in.mon_in_2_mdl_fifo_in.connect(aes128_f_cov.analysis_export);
   endfunction

endclass

`endif
