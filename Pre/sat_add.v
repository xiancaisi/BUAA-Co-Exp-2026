module sat_add (
    input  wire [31:0] a,
    input  wire [31:0] b,
    output wire [31:0] out
);

    // Each byte has an independent 9-bit sum.
    wire [8:0] sum0;
    wire [8:0] sum1;
    wire [8:0] sum2;
    wire [8:0] sum3;

    assign sum0 = {1'b0, a[7:0]}   + {1'b0, b[7:0]};
    assign sum1 = {1'b0, a[15:8]}  + {1'b0, b[15:8]};
    assign sum2 = {1'b0, a[23:16]} + {1'b0, b[23:16]};
    assign sum3 = {1'b0, a[31:24]} + {1'b0, b[31:24]};

    // Saturate each byte to 255 when its sum exceeds 255.
    assign out[7:0]   = sum0[8] ? 8'hFF : sum0[7:0];
    assign out[15:8]  = sum1[8] ? 8'hFF : sum1[7:0];
    assign out[23:16] = sum2[8] ? 8'hFF : sum2[7:0];
    assign out[31:24] = sum3[8] ? 8'hFF : sum3[7:0];

endmodule
