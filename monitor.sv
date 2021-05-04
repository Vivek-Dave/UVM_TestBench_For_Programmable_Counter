class monitor extends uvm_monitor;

	`uvm_component_utils(monitor)
	
	function new(string name="",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual interface dut_if vif;
	
	uvm_analysis_port #(sequence_item) aport;
	
	//------------------- build phase --------------------------------------------
    function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db#(virtual dut_if)::get(this,"","vif",vif)))
		begin
		  `uvm_fatal("monitor","unable to get interface")
		end
		aport=new("sequence_item",this);
    endfunction
  //----------------------------------------------------------------------------
	
	task run_phase(uvm_phase phase);
		sequence_item tr;
		tr=sequence_item::type_id::create("tr");
		//----------------------------------------
		forever begin
			sampke_dut(tr);
			aport.write(tr);
		end
	endtask
	//-----------------------------------------------
	// sample_dut assumed to be synced to posedge clk
	// except for first sample at time-0
	//-----------------------------------------------
	task sampke_dut(output sequence_item tr);
		sequence_item t=sequence_item::type_id::create("t");
		//---------------------------------------------
		// Sample DUT synchronous inputs on posedge clk.
		// DUT inputs should have been valid for most
		// of the previous clock cycle
		//---------------------------------------------
		t.din  = vif.din;
		t.ld   = vif.ld;
		t.inc  = vif.inc;
		t.rst_n= vif.rst_n;
		//---------------------------------------------
		// Wait for posdege clk and sample outputs #1step before.
		// Also re-sample and check async control input signals
		//---------------------------------------------
		@vif.cb;
        if(!vif.rst_n) t.rst_n=0;
		t.dout = vif.cb.dout;
		//---------------------------------------------
		tr=t;
	endtask

endclass