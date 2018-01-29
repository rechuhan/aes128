`ifndef __AES128_ENV_SV__
`define __AES128_ENV_SV__

class aes128_env extends uvm_env;
   `uvm_component_utils(aes128_env)

   aes128_agent_i       aes128_agt_i;
   aes128_agent_o       aes128_agt_o;
   aes128_model         aes128_mdl;
   aes128_scoreboard    aes128_scb;

   uvm_tlm_analysis_fifo #(aes128_transaction) mon_in_2_mdl_fifo;
   uvm_tlm_analysis_fifo #(aes128_transaction) mdl_2_scb_fifo;
   uvm_tlm_analysis_fifo #(aes128_transaction) mon_out_2_scb_fifo;

   function new(string name = "aes128_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      aes128_agt_i = aes128_agent_i::type_id::create("aes128_agt_i", this);
      aes128_agt_o = aes128_agent_o::type_id::create("aes128_agt_o", this);
      aes128_mdl = aes128_model::type_id::create("aes128_mdl", this);
      aes128_scb = aes128_scoreboard::type_id::create("aes128_scb", this);

      mon_in_2_mdl_fifo = new("mon_in_2_mdl_fifo", this);;
      mdl_2_scb_fifo = new("mdl_2_scb_fifo", this);
      mon_out_2_scb_fifo = new("mon_out_2_scb_fifo", this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      aes128_agt_i.aes128_mon_in.mon_in_2_mdl_fifo_in.connect(mon_in_2_mdl_fifo.analysis_export);
      aes128_mdl.mon_in_2_mdl_fifo_out.connect(mon_in_2_mdl_fifo.blocking_get_export);
      aes128_mdl.mdl_2_scb_fifo_in.connect(mdl_2_scb_fifo.analysis_export);
      aes128_scb.mdl_2_scb_fifo_out.connect(mdl_2_scb_fifo.blocking_get_export);
      aes128_agt_o.aes128_mon_out.mon_out_2_scb_fifo_in.connect(mon_out_2_scb_fifo.analysis_export);
      aes128_scb.mon_out_2_scb_fifo_out.connect(mon_out_2_scb_fifo.blocking_get_export);
   endfunction

endclass

`endif

