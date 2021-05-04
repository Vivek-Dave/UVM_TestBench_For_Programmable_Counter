
class test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils( test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name=" test",uvm_component parent);
	super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

     env env_h;
    int file_h;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h =  env::type_id::create("env_h",this);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      set_report_verbosity_level_hier(UVM_MEDIUM);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
         inc_sequence seq1;
		 load_inc_sequence seq2;
		 reset_sequence rst;
		 phase.raise_objection(this);
            seq1=  inc_sequence::type_id::create("seq1");
      		seq2=  load_inc_sequence::type_id::create("seq2");
			rst =  reset_sequence::type_id::create("rst");
			rst.start(env_h.agent_h.sequencer_h);
			seq1.start(env_h.agent_h.sequencer_h);
      		#300;
      		rst.start(env_h.agent_h.sequencer_h);
			seq2.start(env_h.agent_h.sequencer_h);
			#300;
		 phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:test


class test2 extends test;

    //--------------------------------------------------------------------------
  	`uvm_component_utils( test2)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
  	function new(string name="test2",uvm_component parent);
		super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    env env_h;
    int file_h;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      //super.build_phase(phase);
      env_h =  env::type_id::create("env_h",this);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      set_report_verbosity_level_hier(UVM_MEDIUM);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
         //inc_sequence seq1;
		 load_inc_sequence seq2;
		 reset_sequence rst;
		 phase.raise_objection(this);
			seq2=  load_inc_sequence::type_id::create("seq2");
			rst =  reset_sequence::type_id::create("rst");
			rst.start(env_h.agent_h.sequencer_h);
			seq2.start(env_h.agent_h.sequencer_h);
			#200;
      		rst.start(env_h.agent_h.sequencer_h);
			seq2.start(env_h.agent_h.sequencer_h);
     		#200;
		 phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:test2
