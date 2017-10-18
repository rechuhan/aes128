`ifndef __AES128_MONITOR_IN_SV__
`define __AES128_MONITOR_IN_SV__

class aes128_monitor_in extends uvm_monitor;
   `uvm_component_utils(aes128_monitor_in)

   virtual aes128_if vif;
   uvm_analysis_port #(aes128_transaction) mon_in_2_mdl_fifo_in;

   function new(string name = "aes128_monitor_in", uvm_component parent);
      super.new(name, parent);
      mon_in_2_mdl_fifo_in = new("mon_in_2_mdl_fifo_in", this);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual aes128_if)::get(this, "", "vif", vif))
         `uvm_fatal("aes128_monitor_in", "vif must be set!!!")
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   task run_phase(uvm_phase phase);
      aes128_transaction aes128_tr;
      while(1) begin
         @(negedge vif.clk);
         if(vif.load_i == 1) begin
            aes128_tr = new("aes128_tr");
            aes128_tr.plaintext = vif.data_i;
            aes128_tr.aes_key = vif.key_i;
            aes128_tr.encrypt_decrypt = vif.decrypt_i;
            aes128_tr.get_encrypt_decrypt_type();
            mon_in_2_mdl_fifo_in.write(aes128_tr);
            //`uvm_info("aes128_monitor_in", "tr_in:\n", UVM_LOW)
            //aes128_tr.print();
         end
      end
   endtask
endclass

`endif

