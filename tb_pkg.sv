
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "sequence_item.sv"        // transaction class
 `include "sequence.sv"             // sequence class
 `include "sequencer.sv"            // sequencer class
 `include "driver.sv"               // driver class
 `include "monitor.sv"
 `include "agent.sv"                // agent class  
 `include "coverage.sv"             // coverage class
 `include "scoreboard.sv"
 `include "env.sv"                  // environment class

 `include "test.sv"                         // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


