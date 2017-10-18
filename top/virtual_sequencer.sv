`ifndef __VIRTUAL_SEQUENCER_SV__
`define __VIRTUAL_SEQUENCER_SV__

class virtual_sequencer extends uvm_virtual_sequencer;
   `uvm_component_utils(virtual_sequencer)

   aes128_sequencer aes128_sqr;

   function new(string name = "virtual_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction

endclass

`endif

