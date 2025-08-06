`timescale 1ns/1ps
import bp_pkg::*;

module tb_branch_predictor;

    localparam CLK_PERIOD = 10;



    // Clock and reset
    logic clk;
    logic reset_n;

    // Interface instance
    bp_ifc bp_if(.clk(clk));
    assign bp_if.reset_n = reset_n;

    // Instantiate DUT
    Branch_Predictor dut(.bp(bp_if));

    // Clock generation
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Reset generation
    initial begin
        reset_n = 0;
        #(CLK_PERIOD*5);
        reset_n = 1;
    end

    // Variables for test
    int total = 0;
    int correct = 0;

    // Expected FSM state variable (no initial block)
    state_t expected_state;

    // Update expected FSM state same as DUT FSM
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            expected_state <= SNT;
        else begin
            case (expected_state)
                SNT: expected_state <= (bp_if.taken) ? WNT : SNT;
                WNT: expected_state <= (bp_if.taken) ? WT  : SNT;
                WT : expected_state <= (bp_if.taken) ? ST  : WNT;
                ST : expected_state <= (bp_if.taken) ? ST  : WT;
                default: expected_state <= SNT;
            endcase
        end
    end


    covergroup fsm_cov @(posedge clk);
        // Cover all state-to-state transitions
        coverpoint bp_if.prediction{
            bins t1 = (SNT => SNT);
            bins t2 = (SNT => WNT);
            bins t3 = (WNT => WT);
            bins t4 = (WNT => SNT);
	    bins t5 = (WT => ST);
            bins t6 = (WT => WNT);
	    bins t7 = (ST => ST);
	    bins t8 = (ST => WT);
        }
    endgroup
    fsm_cov coverage = new();

    // Main test stimulus and checking loop
    initial begin
	
        wait (reset_n == 1);
        @(posedge clk);

        for (int i = 0; i < 20; i++) begin
            // Drive random branch outcome
            #1 bp_if.taken = $urandom_range(0,1);

            @(posedge clk);  // wait for prediction update

            // Compare DUT prediction to expected prediction
            if (bp_if.prediction === expected_state)
                correct++;
            else
                $error("Mismatch at cycle %0d: DUT prediction=%b Expected=%b Taken=%b", i, bp_if.prediction, expected_state, bp_if.taken);

            total++;

            @(posedge clk);
        end

        $display("Test finished: Total=%0d Correct=%0d Accuracy=%.2f%%\n",
                 total, correct, 100.0 * correct / total);

        $display("Functional Coverage = %0.02f%%",coverage.get_coverage());
                 
        $finish;
    end

endmodule

