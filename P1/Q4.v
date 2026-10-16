module gray(
    input Clk,
    input Reset,
    input En,
    output  [2:0] Output,
    output reg Overflow,
    reg [2:0] count
);
initial begin
    count = 3'b0;
    Overflow = 1'b0;
end
always @(posedge Clk) begin
    if (Reset) begin
        count <=3'b0;
        Overflow <=1'b0;
    end
    else begin
        if (En) begin
            if(count == 3'b111)Overflow <=1;
            count <= count + 3'b001;
        end
    end

end
assign Output[2] = count[2];
assign Output[1] = count[2]^count[1];
assign Output[0] = count[1]^count[0];

endmodule