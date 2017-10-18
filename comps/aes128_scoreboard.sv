`ifndef __AES128_SCOREBOARD_SV__
`define __AES128_SCOREBOARD_SV__

class aes128_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(aes128_scoreboard)

   uvm_blocking_get_port #(aes128_transaction) mdl_2_scb_fifo_out;
   uvm_blocking_get_port #(aes128_transaction) mon_out_2_scb_fifo_out;

   aes128_transaction tr_in_q[$], tr_out_q[$];

   event compare_time;

   function new(string name = "aes128_scoreboard", uvm_component parent);
      super.new(name, parent);
      mdl_2_scb_fifo_out = new("mdl_2_scb_fifo_out", this);
      mon_out_2_scb_fifo_out = new("mon_out_2_scb_fifo_out", this);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction

   task run_phase(uvm_phase phase);
      aes128_transaction tr_in, tr_out;
      aes128_transaction compare_in, compare_out;
      fork
         while(1) begin
            tr_in = new("tr_in");
            mdl_2_scb_fifo_out.get(tr_in);
            tr_in_q.push_back(tr_in);
         end

         while(1) begin
            tr_out = new("tr_out");
            mon_out_2_scb_fifo_out.get(tr_out);
            tr_out_q.push_back(tr_out);

            -> compare_time;
         end

         while(1) begin
            @compare_time;
            compare_in = new("compare_in");
            compare_out = new("compare_out");
            compare_in = tr_in_q.pop_front();
            compare_out = tr_out_q.pop_front();
            if(compare_in.compare(compare_out)) begin
               `uvm_info("aes128_scoreboard", "ciphertext compare successfully!", UVM_LOW)
               `uvm_info("aes128_scoreboard", $psprintf("tr_in:\n%s", compare_in.sprint()), UVM_LOW)
            end
            else begin
               `uvm_error("aes128_scoreboard", "ciphertext compare unsuccessfully!")
               `uvm_info("aes128_scoreboard", $psprintf("tr_in:\n%s", compare_in.sprint()), UVM_LOW)
               `uvm_info("aes128_scoreboard", $psprintf("tr_out:\n%s", compare_out.sprint()), UVM_LOW)
            end
         end
      join
   endtask

   function void check_phase(uvm_phase phase);
      super.check_phase(phase);
      check_q();
   endfunction

   function void check_q();
      if(tr_in_q.size() > 0) begin
         `uvm_error("aes128_scoreboard", "in queue is not empty.")
      end
      if(tr_out_q.size() > 0) begin
         `uvm_error("aes128_scoreboard", "out queue is not empty.")
      end   
   endfunction
endclass

`endif

