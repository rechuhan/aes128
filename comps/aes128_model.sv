`ifndef __AES128_MODEL_SV__
`define __AES128_MODEL_SV__

class aes128_model extends uvm_component;
   `uvm_component_utils(aes128_model)

   uvm_blocking_get_port #(aes128_transaction) mon_in_2_mdl_fifo_out;
   uvm_analysis_port #(aes128_transaction) mdl_2_scb_fifo_in;

   function new(string name = "aes128_model", uvm_component parent);
      super.new(name, parent);
      mon_in_2_mdl_fifo_out = new("mon_in_2_mdl_fifo_out", this);
      mdl_2_scb_fifo_in = new("mdl_2_scb_fifo_in", this);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   task run_phase(uvm_phase phase);
      aes128_transaction aes128_tr_in, aes128_tr_out;
      while(1) begin
         aes128_tr_in = new("aes128_tr_in");
         aes128_tr_out = new("aes128_tr_out");
         mon_in_2_mdl_fifo_out.get(aes128_tr_in);
         aes128_tr_out.copy(aes128_tr_in);
         //`uvm_info("aes128_model", "before convert_128to32_all:\n", UVM_LOW)
         //aes128_tr_in.print();
         aes128_tr_in.convert_128to32_all();
         //`uvm_info("aes128_model", "after convert_128to32_all:\n", UVM_LOW)
         //aes128_tr_in.print();
         crypto_dpi_aes_ecb_crypto_func(aes128_tr_in.src, aes128_tr_out.dst, 128, aes128_tr_in.key, !aes128_tr_in.encrypt_decrypt);
         //`uvm_info("aes128_model", "before convert_32to128_all:\n", UVM_LOW)
         //aes128_tr_out.print();
         aes128_tr_out.convert_32to128_all();
         //`uvm_info("aes128_model", "after convert_32to128_all:\n", UVM_LOW)
         //aes128_tr_out.print();
         mdl_2_scb_fifo_in.write(aes128_tr_out);
      end
   endtask
endclass

`endif

