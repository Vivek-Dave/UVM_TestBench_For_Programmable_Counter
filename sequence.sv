
/***************************************************
** class name  : inc_sequence
** description : increment count value of counter
***************************************************/
class inc_sequence extends uvm_sequence#(sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils( inc_sequence)            
  //----------------------------------------------------------------------------

   sequence_item txn;

  //----------------------------------------------------------------------------
  function new(string name=" inc_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    txn= sequence_item::type_id::create("txn");
    start_item(txn);
    txn.randomize()with{txn.inc==1; txn.ld==0; };
	txn.rst_n=1;
    finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
endclass: inc_sequence

/***************************************************
** class name  : load_inc_sequence
** description : first load and then increment counter 
***************************************************/
class load_inc_sequence extends  inc_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(load_inc_sequence)      
  //----------------------------------------------------------------------------
  
   sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="load_inc_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
	for(int i=0;i<2;i++) begin 
		if(i==0) begin
			txn=sequence_item::type_id::create("txn");
			start_item(txn);
			txn.randomize()with{txn.ld==1; txn.inc==0; txn.din==7;};
			txn.rst_n=1;
			finish_item(txn);
		end
		else begin
			txn=sequence_item::type_id::create("txn");
			start_item(txn);
			txn.randomize()with{txn.ld==0; txn.inc==1;};
			txn.rst_n=1;
			finish_item(txn);
		end
	end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : reset_sequence
** description : reset the sequence
***************************************************/
class reset_sequence extends  inc_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(reset_sequence)      
  //----------------------------------------------------------------------------
  
   sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="reset_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=sequence_item::type_id::create("txn");
    start_item(txn);
    txn.din=0;
	txn.ld=0;
	txn.inc=0;
	txn.rst_n=0;
    finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/*
class sequence_name_3 extends  _sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils()      
  //----------------------------------------------------------------------------
  
   _sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn= _sequence_item::type_id::create("txn");
    start_item(txn);
    txn.randomize();
    finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
  
endclass
*/
