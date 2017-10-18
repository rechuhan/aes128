`ifndef __AES128_SEQUENCER_SV__
`define __AES128_SEQUENCER_SV__

class aes128_sequencer extends uvm_sequencer#(aes128_transaction);
   `uvm_component_utils(aes128_sequencer)

   function new(string name = "aes128_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction

endclass

`endif

