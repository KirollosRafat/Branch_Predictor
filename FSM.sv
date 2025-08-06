import bp_pkg::*;  // Import the package for state_t

module Branch_Predictor(bp_ifc bp);

    state_t present_state, next_state;

    always_ff @(posedge bp.clk or negedge bp.reset_n) begin
        if (!bp.reset_n)
            present_state <= SNT;  // Reset to Strongly Not Taken
        else
            present_state <= next_state;
    end

    always_comb begin
        case (present_state)
            SNT: next_state = bp.taken ? WNT : SNT;
            WNT: next_state = bp.taken ? WT  : SNT;
            WT : next_state = bp.taken ? ST  : WNT;
            ST : next_state = bp.taken ? ST  : WT;
            default: next_state = SNT;
        endcase
    end

    // Prediction output: simply the satuarating counter output
    assign bp.prediction = present_state;

endmodule 

