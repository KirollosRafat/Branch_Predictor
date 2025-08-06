import bp_pkg::*;  // Import the package to use state_t

interface bp_ifc(input bit clk);

    logic        reset_n;
    logic        taken;
    state_t      prediction;

    modport DUT (
 	input clk,
        input  reset_n,
        input  taken,
        output prediction
    );

    modport driver (
	input clk,
        output reset_n,
        output taken,
        input  prediction
    );

endinterface : bp_ifc

