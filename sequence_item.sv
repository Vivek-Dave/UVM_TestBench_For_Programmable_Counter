
class sequence_item extends uvm_sequence_item;
    logic    [15:0] dout;
    rand bit  [15:0] din;
    rand bit     ld, inc;
	logic          rst_n;

    `uvm_object_utils_begin(sequence_item)
        `uvm_field_int(dout, UVM_ALL_ON)
        `uvm_field_int(din,  UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_int(ld,   UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_int(inc,  UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_int(rst_n,UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_object_utils_end

    function new (string name="sequence_item");
        super.new(name);
    endfunction

    function string output2string();
        return($sformatf("dout=%4h", dout));
    endfunction

	function string input2string();
		return($sformatf("din=%4h ld=%b inc=%b rst_n=%b",din, ld, inc, rst_n));
    endfunction
  
	function string convert2string();
		return($sformatf({input2string(), "  ", output2string()}));
	endfunction
	
endclass
