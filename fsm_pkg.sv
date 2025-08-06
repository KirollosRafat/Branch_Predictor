package bp_pkg;

    typedef enum logic [1:0] {
        SNT = 2'b00, // Strongly Not Taken
        WNT = 2'b01, // Weakly Not Taken
        WT  = 2'b10, // Weakly Taken
        ST  = 2'b11  // Strongly Taken
    } state_t;

endpackage : bp_pkg

