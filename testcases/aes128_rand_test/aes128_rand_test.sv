`ifndef __AES128_RAND_TEST_SV__
`define __AES128_RAND_TEST_SV__

class aes128_rand_test_sequence extends aes128_base_test_seq;
   aes128_transaction aes128_tr;

   `uvm_object_utils_begin(aes128_rand_test_sequence)
   `uvm_object_utils_end

   function new(string name = "aes128_rand_test_sequence");
      super.new(name);
   endfunction

   virtual task body();
      repeat(10) begin
         `uvm_do_on(aes128_tr, p_sequencer.aes128_sqr);
      end
   endtask

endclass

class aes128_rand_test extends aes128_base_test;
   aes128_rand_test_sequence aes128_rand_test_seq;
   `uvm_component_utils(aes128_rand_test)

   function new(string name = "aes128_rand_test", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      aes128_rand_test_seq = aes128_rand_test_sequence::type_id::create("aes128_rand_test_seq", this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      aes128_rand_test_seq.start(aes128_tb.v_sqr);
      phase.drop_objection(this);
   endtask
endclass

`endif

