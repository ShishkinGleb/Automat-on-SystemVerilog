module operating_verilog
#(
    parameter n = 5
    //parameter CNT = n
)
(
    input  logic clk,
    input  logic rst,
    input  logic [3:0] A_in[n], 
    input  logic [3:0] B_in[n],
    input  logic state_load,
    input  logic state_sum,
    input  logic state_inc_c,
    input  logic state_plus_6_c,
    input  logic state_inc_s,
    output logic [4:0] C[n], 
    output logic [3:0] s
);

//два входных 8-ми битных операнда
logic[3:0] A[n];
logic[3:0] B[n];
//Выходы для арифметических операций имеют дополнительный 9-й бит переполнения

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        for (integer i = 0; i < n; i++)
            C[i] <= 5'b0;
    end
    else
    begin
        if(state_load==1)
        begin
            for (integer i = 0; i < n; i++)
                C[i] <= 5'b0;
        end
        else
        begin
            if(state_sum==1)
            begin
                C[n-s-1] <= A[n-s-1] + B[n-s-1] + C[n-s-1];
            end
            if(state_inc_c==1)
            begin
                C[n-s-2] <= C[n-s-2] + 4'b0001;
            end
            if(state_plus_6_c==1)
            begin
                C[n-s-1] <= C[n-s-1] + 4'b0110;
            end
        end    
    end

end

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        s <= '0;
    end
    else
    begin
        if(state_load==1)
        begin
            s <= 4'b0000;
        end
        else
        begin
            if(state_inc_s==1)
            begin
                s <= s + 'b1;
            end    
        end
    end
end

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        for (integer i = 0; i < n; i++)
            A[i] <= 4'b0;
    end
    else
    begin
        if(state_load==1)
        begin
            A <= A_in;
        end
    end

end

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        for (integer i = 0; i < n; i++)
            B[i] <= 4'b0;
    end
    else
    begin
        if(state_load==1)
        begin
            B <= B_in;
        end
    end

end

endmodule