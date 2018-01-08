`ifndef __AES128_PKG_SV__
`define __AES128_PKG_SV__
package aes128_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import crypto_dpi_pkg::*;
`include "aes128_config.sv"
`include "aes128_transaction.sv"
`include "aes128_driver.sv"
`include "aes128_sequencer.sv"
`include "aes128_monitor_in.sv"
`include "aes128_monitor_out.sv"
`include "aes128_model.sv"
`include "aes128_scoreboard.sv"
`include "aes128_func_cov.sv"
`include "aes128_agent_i.sv"
`include "aes128_agent_o.sv"
`include "aes128_env.sv"

endpackage
`endif
