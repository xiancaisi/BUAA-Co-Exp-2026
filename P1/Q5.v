module expr (
    input clk,
    input clr,
    input [7:0] in,
    output out
);
    localparam expect_num = 2'b00;
    localparam valid = 2'b01;
    localparam error = 2'b10;

    wire is_num = (in <= "9")&&(in >= "0");
    wire is_op = (in == "+")||(in == "*");

    reg [1:0] state;
    always @(posedge clk,posedge clr) begin
        if(clr) begin
            state <= expect_num;
        end
        else begin
            case (state)
                expect_num: state <=(is_num == 1) ? valid : error;
                valid:   state <= (is_op==1) ? expect_num : error;
                error: state <= error;
                default: state <=error;
            endcase
        end
    end

    assign out = (state == valid);
endmodule