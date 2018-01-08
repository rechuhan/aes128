`ifndef __AES128_BASE_TEST_SV__
`define __AES128_BASE_TEST_SV__

class aes128_base_test_sequence extends uvm_sequence;
   `uvm_object_utils(aes128_base_test_sequence)
   `uvm_declare_p_sequencer(virtual_sequencer);

   function new(string name = "aes128_base_test");
      super.new(name);
   endfunction
endclass

class aes128_base_test extends uvm_test;
   `uvm_component_utils(aes128_base_test)
   
   tb aes128_tb;
   aes128_config aes128_cfg;

   function new(string name = "aes128_base_test", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      aes128_tb = tb::type_id::create("aes128_tb", this);
      aes128_cfg = aes128_config::type_id::create("aes128_cfg", this);
      if(!uvm_config_db#(virtual aes128_if)::get(this, "", "aes128_if", aes128_cfg.aes128_vif))
         `uvm_fatal("aes128_base_test", "aes128_if must be set!!!")
      uvm_config_db#(aes128_config)::set(this, "aes128_tb.env.*", "aes128_cfg", aes128_cfg);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction

   virtual function void final_phase(uvm_phase phase);
      uvm_report_server svr;
      super.final_phase(phase);

      svr = uvm_report_server::get_server();
      if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)+svr.get_severity_count(UVM_WARNING) > 0) begin
         `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
      end
      else begin
         `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)
      end
   endfunction
endclass

`endif

