class driver extends uvm_driver #(sequence_item);
	`uvm_component_utils(driver)
	
	function new(string name="",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual dut_if vif;
	
	uvm_analysis_port #(sequence_item) drv2sb;
	
	
	  //-------------------------  get interface handel from top -------------------
	  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db#(virtual dut_if)::get(this,"","vif",vif))) begin
		  `uvm_fatal("driver","unable to get interface");
		end
		drv2sb=new("drv2sb",this);
	  endfunction
	  //----------------------------------------------------------------------------
	  
	
	task run_phase(uvm_phase phase);
		sequence_item tr;
		initilize();
		forever begin
			seq_item_port.get_next_item(tr);
			drive_tr(tr);
			drv2sb.write(tr);
			seq_item_port.item_done();
		end
	endtask
	
	task initilize();
		vif.rst_n <=0;
		vif.ld    <=1;
		vif.inc   <=1;
		vif.din   <=1;
	endtask
	
	task drive_tr(sequence_item tr);
		@vif.cb;
		vif.cb.din   <= tr.din;
		vif.cb.ld    <= tr.ld;
		vif.cb.inc   <= tr.inc;
		vif.cb.rst_n <= tr.rst_n;
	endtask
	
endclass