`ifndef __AES128_DRIVER_SV__
`define __AES128_DRIVER_SV__

class aes128_driver extends uvm_driver#(aes128_transaction);
   `uvm_component_utils(aes128_driver)

   virtual aes128_if vif;

   function new(string name = "aes128_driver", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual aes128_if)::get(this, "", "vif", vif))
         `uvm_fatal("aes128_driver", "vif must be set!!!")
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   task run_phase(uvm_phase phase);
      vif.load_i <= 0;
      vif.decrypt_i <= 0;
      vif.data_i <= 0;
      vif.key_i <= 0;

      while(!vif.rst_n)
         @(posedge vif.clk);

      while(1) begin
         seq_item_port.get_next_item(req);
         drive_one_pkt();
         seq_item_port.item_done();
      end
   endtask

   task drive_one_pkt();
      @(posedge vif.clk);
      vif.decrypt_i <= req.encrypt_decrypt;
      vif.data_i <= req.plaintext;
      vif.key_i <= req.aes_key;
      vif.load_i <= 1'b1;
      @(posedge vif.clk);
      vif.load_i <= 1'b0;
      
      @(posedge vif.ready_o);
      repeat(10) begin
         @(posedge vif.clk);
      end
   endtask
endclass

`endif

