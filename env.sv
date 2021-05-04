
class env extends uvm_env;

   //---------------------------------------------------------------------------
   `uvm_component_utils(env)
   //---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="env",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- class handles -----------------------------------------
   agent           agent_h;
   coverage     coverage_h;
   scoreboard scoreboard_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_h      =  agent::type_id::create("agent_h",this);
    coverage_h   =  coverage::type_id::create("coverage_h",this);
    scoreboard_h =  scoreboard::type_id::create("scoreboard_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------------- connect phase -----------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_h.monitor_h.aport.connect(coverage_h.analysis_export);
    // make scoreboard connection here
    agent_h.driver_h.drv2sb.connect(scoreboard_h.aport_drv);
    agent_h.monitor_h.aport.connect(scoreboard_h.aport_mon);
  endfunction
  //----------------------------------------------------------------------------
endclass:env

