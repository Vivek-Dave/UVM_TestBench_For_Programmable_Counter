
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp_drv #( sequence_item,  scoreboard) aport_drv;
  uvm_analysis_imp_mon #( sequence_item,  scoreboard) aport_mon;
  
  uvm_tlm_fifo #( sequence_item) expfifo;
  uvm_tlm_fifo #( sequence_item) outfifo;
  
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  int count;

  function new(string name="scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
    
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
  endfunction

  function void write_drv(sequence_item tr);
        static logic [15:0] next_dout;
        logic [15:0] dout;
        //---------------------------------------------------
    	`uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
        dout = next_dout;
        if (!tr.rst_n) {next_dout,dout,count} = '0;
    	else if ( tr.ld) begin next_dout = tr.din; count++; end
    	else if ( tr.inc)begin next_dout++; count++; end
        tr.dout = dout;
        void'(expfifo.try_put(tr));
  endfunction


  function void write_mon(sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  
  task run_phase(uvm_phase phase);
	sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
      if (out_tr.dout===exp_tr.dout) begin
            PASS();
           `uvm_info ("PASS ",out_tr.convert2string() , UVM_MEDIUM)
		end
      
      else if(out_tr.dout!==exp_tr.dout && count>2) begin
		   ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	    end
    end
  endtask

  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)
        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction

  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

endclass

