`ifndef __AES128_SIMPLE_TEST_SV__
`define __AES128_SIMPLE_TEST_SV__

class aes128_simple_test_sequence extends aes128_base_test_sequence;
   `uvm_object_utils(aes128_simple_test_sequence)

   aes128_transaction aes128_tr;

   function new(string name = "aes128_simple_test_sequence");
      super.new(name);
   endfunction

   virtual task body();
   /*
      `uvm_do_on_with(aes128_tr, p_sequencer.aes128_sqr, 
      {
         aes128_tr.encrypt_decrypty == 1;
         aes128_tr.plaintext == 128'h00112233445566778899aabbccddeeff;
         aes128_tr.aes_key == 128'h000102030405060708090a0b0c0d0e0f;
      })
   */
   ///*
      repeat(10) begin
         `uvm_do_on(aes128_tr, p_sequencer.aes128_sqr);
      end
   //*/
   endtask
endclass

class aes128_simple_test extends aes128_base_test;
   `uvm_component_utils(aes128_simple_test)

   aes128_simple_test_sequence aes128_simple_test_seq;

   function new(string name = "aes128_simple_test", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      aes128_simple_test_seq = aes128_simple_test_sequence::type_id::create("aes128_simple_test_seq", this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      aes128_simple_test_seq.start(aes128_tb.v_sqr);
      phase.drop_objection(this);
   endtask
endclass

`endif

