// testbench is a module which only task is to test another module
// testbench is for simulation only, not for synthesis
module operation_testbench;

    // input and output test signals
    //localparam n = 5;
    localparam n = 6;
    localparam CNT = n-1;
    logic [3:0] C_out[n];
    logic clk;
    logic rst;
    logic [3:0] A[n];
    logic [3:0] B[n];
    logic [4:0] C[n];
    logic [3:0] s;
    logic state_wait;
    logic state_load;
    logic state_sum;
    logic state_inc_c;
    logic state_plus_6_c;
    logic state_inc_s;
    //logic start;
    //logic final_avt;
    logic x1;
    logic x2;
    logic x3;

 
    // creating the instance of the module we want to test
    //  lab1 - module name
    //  dut  - instance name ('dut' means 'device under test')
    operating_verilog #(n) dut 
    ( 
        .clk(clk),
        .rst(rst),
        .A_in(A), 
        .B_in(B),
        .state_load(state_load),
        .state_sum(state_sum),
        .state_inc_c(state_inc_c),
        .state_plus_6_c(state_plus_6_c),
        .state_inc_s(state_inc_s),
        .state_wait(state_wait),  
        .C(C), 
        .s(s)
        
    );

    control_verilog dut_1
    (
        .clk(clk),
        .rst(rst),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .state_load(state_load),
        .state_sum(state_sum),
        .state_inc_c(state_inc_c),
        .state_plus_6_c(state_plus_6_c),
        .state_inc_s(state_inc_s),
        .state_wait(state_wait)
        //.final_avt(final_avt)

    );

    assign x1 = s < n;
    assign x2 = C[CNT-s]>='b10000;
    assign x3 = (C[CNT-s]>='b1010)&&(C[CNT-s]<='b1111);


    always
    #1 clk <= !clk;

    genvar i; 
    generate
        for (i = 0; i < n;i++)
            if (i==0) 
            begin
                assign C_out[i][0] = C[i][0];
                assign C_out[i][1] = C[i][1];
                assign C_out[i][2] = 0;
                assign C_out[i][3] = 0;
            end
            else
            begin
                assign C_out[i] = C[i];
            end
            
    endgenerate
    



    // do at the beginning of the simulation
    initial 
        begin
            clk = 0;
            rst = 0;
            
            //s = 6;
            /*state_load = 0;
            state_sum = 0;
            state_inc_c = 0;
            state_plus_6_c = 0;
            state_inc_s = 0;*/
            

            #2;
            
            rst = 1;
            //A[0] = 4'b0000;
            //A[1] = 4'b0110;
            //A[2] = 4'b0111;
            //A[3] = 4'b1000;
            //B[0] = 4'b0000;
            //B[1] = 4'b0101;
            //B[2] = 4'b0011;
            //B[3] = 4'b0101;
            A[1] = 4'b0110;
            A[2] = 4'b0001;
            A[3] = 4'b1000;
            A[0] = 4'b0011;
            A[4] = 4'b1001;    // set test signals value                        // pause
            B[0] = 4'b0000;
            B[1] = 4'b0111;
            B[2] = 4'b0000;
            B[3] = 4'b1000;
            B[4] = 4'b0011;    // set test signals value
            

            #2;
            
            /*state_load = 1;
            @(posedge clk);
            state_load = 0;
            @(posedge clk);

            while (s < n)
            begin               
                state_sum = 1;
                @(posedge clk);
                state_sum = 0;
                @(posedge clk);
                if(C[CNT-s]>='b10000)
                begin
                    @(posedge clk);
                    state_inc_c = 1;
                    @(posedge clk);
                    state_inc_c = 0;
                    @(posedge clk);

                    state_plus_6_c = 1;
                    @(posedge clk);
                    state_plus_6_c = 0;
                end
                else
                begin
                    @(posedge clk);
                    if((C[CNT-s]>='b1010)&&(C[CNT-s]<='b1111))
                    begin
                        @(posedge clk);
                        state_inc_c = 1;
                        @(posedge clk);
                        state_inc_c = 0;

                        @(posedge clk);
                        state_plus_6_c = 1;
                        @(posedge clk);
                        state_plus_6_c = 0;
                    end
                end
                @(posedge clk);
                state_inc_s = 1;
                @(posedge clk);
                state_inc_s = 0;
                @(posedge clk);
            end*/
            //if (C_out[0]=='b0011)
            //begin
            //    
            //end               
        end


endmodule