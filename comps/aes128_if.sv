`ifndef __AES128_IF_SV__
`define __AES128_IF_SV__

interface aes128_if(input clk, input rst_n);

logic load_i;
logic decrypt_i;
logic [127:0] data_i;
logic [127:0] key_i;
logic ready_o;
logic [127:0] data_o;

endinterface

`endif

