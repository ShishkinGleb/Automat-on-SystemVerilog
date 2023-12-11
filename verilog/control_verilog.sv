module control_verilog 
(
    input  logic clk,
    input  logic rst,
    input  logic x1,                // будет ли следующая итерация
    input  logic x2,                // С[s] >= 16
    input  logic x3,                // 10 <= C[s] <= 15
    output  logic state_load,
    output  logic state_sum,
    output  logic state_inc_c,
    output  logic state_plus_6_c,
    output  logic state_inc_s,
    output  logic state_wait
);


typedef enum logic[2:0]
{
     load     = 3'b000,
     sum      = 3'b001,
     inc_c    = 3'b010,
     plus_6   = 3'b011,
     inc_s    = 3'b100,
     wait_sum     = 3'b101
} state_t;
state_t state, next_state;


// Choose next state logic
always_comb
case (state)
    load:
        if (x1)
            next_state = inc_s;
        else
            next_state = load;

    sum:
        next_state = wait_sum;

    wait_sum:
        if ((~x2) && (~x3))
            next_state = inc_s;
        else
            next_state = inc_c;

    inc_c:        
        next_state = plus_6;

    plus_6:
        next_state = inc_s;
   
    inc_s:
        next_state = sum;
       
    default:
        next_state = load;
endcase


// Control signals for memory
always_ff @(posedge clk or negedge rst) 
    if (!rst) begin
        state_load       <= '0;
        state_inc_c      <= '0;
        state_inc_s      <= '0;
        state_plus_6_c   <= '0;
        state_sum        <= '0;
        state_wait       <= '0;
    end
    else 
    case (state)
    wait_sum: begin
        state_load       <= '0;
        state_inc_c      <= '0;
        state_inc_s      <= '0;
        state_plus_6_c   <= '0;
        state_sum        <= '0;
        state_wait       <= '1;
    end
    load: begin
        state_load       <= '1;
        state_inc_c      <= '0;
        state_inc_s      <= '0;
        state_plus_6_c   <= '0;
        state_sum        <= '0;
        state_wait         <= '0;
    end 
    sum: begin
        state_load       <= '0;
        state_inc_c      <= '0;
        state_inc_s      <= '0;
        state_plus_6_c   <= '0;
        state_sum        <= '1;
        state_wait         <= '0;
    end
    inc_c: begin
        state_load       <= '0;
        state_inc_c      <= '1;
        state_inc_s      <= '0;
        state_plus_6_c   <= '0;
        state_sum        <= '0;
        state_wait         <= '0;       
    end        
    plus_6: begin
        state_load       <= '0;
        state_inc_c      <= '0;
        state_inc_s      <= '0;
        state_plus_6_c   <= '1;
        state_sum        <= '0;
        state_wait         <= '0;
    end
    inc_s: begin
        state_load       <= '0;
        state_inc_c      <= '0;
        state_inc_s      <= '1;
        state_plus_6_c   <= '0;
        state_sum        <= '0;
        state_wait         <= '0;
    end
    endcase


// Update currernt state logic
always_ff @(posedge clk or negedge rst) 
    if (!rst)
        state <= load;
    else
        state <= next_state;

endmodule
