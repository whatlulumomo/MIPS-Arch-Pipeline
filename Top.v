

module Top(clk200P, 
			  clk200N,
           K_COL, 
           RSTN, 
           SW, 
           AN, 
           Buzzer, 
//           CR, 
           K_ROW, 
           LED, 
           LEDCLK, 
//           LEDCLR, 
           LEDDT, 
           LEDEN, 
//           RDY, 
//           readn, 
           SEGCLK, 
//           SEGCLR, 
           SEGDT, 
           SEGEN, 
           SEGMENT);

    wire clk_100mhz;
	 input clk200P;
	 input clk200N;
	 
    input [3:0] K_COL;
    input RSTN;
    input [15:0] SW;
   output [3:0] AN;
   output Buzzer;
   wire CR;
   output [4:0] K_ROW;
   output [7:0] LED;
   output LEDCLK;
   wire LEDCLR;
   output LEDDT;
   output LEDEN;
   wire RDY;
   wire readn;
   output SEGCLK;
   wire SEGCLR;
   output SEGDT;
   output SEGEN;
   output [7:0] SEGMENT;
   
   wire [31:0] Addr_out;
   wire [31:0] Ai;
   wire [31:0] Bi;
   wire [7:0] blink;
   wire [3:0] BTN_OK;
   wire Clk_CPU;
   wire [31:0] Counter_out;
   wire [31:0] CPU2IO;
   wire [31:0] Data_in;
   wire [31:0] Data_out;
   wire [31:0] Disp_num;
   wire [31:0] Div;
   wire GPIOF0;
   wire [31:0] inst;
   wire IO_clk;
   wire [15:0] LED_out;
   wire [7:0] LE_out;
   wire N0;
   wire [31:0] PC;
   wire [7:0] point_out;
   wire [3:0] Pulse;
   wire rst;
   wire [15:0] SW_OK;
   wire V5;
   wire XLXN_4;
   wire [4:0] XLXN_48;
   wire XLXN_71;
   wire XLXN_128;
   wire [1:0] XLXN_130;
   wire XLXN_135;
   wire XLXN_136;
   wire XLXN_137;
   wire [31:0] XLXN_147;
   wire [0:0] XLXN_148;
   wire [9:0] XLXN_149;
   wire [31:0] XLXN_150;
   wire XLXN_151;
   wire RDY_DUMMY;
   wire readn_DUMMY;
   
   assign RDY = RDY_DUMMY;
   assign readn = readn_DUMMY;
	
   SAnti_jitter  XLXI_2 (.clk(clk_100mhz), 
                        .Key_y(K_COL[3:0]), 
                        .readn(readn_DUMMY), 
                        .RSTN(RSTN), 
                        .SW(SW[15:0]), 
                        .BTN_OK(BTN_OK[3:0]), 
                        .CR(CR), 
                        .Key_out(XLXN_48[4:0]), 
                        .Key_ready(RDY_DUMMY), 
                        .Key_x(K_ROW[4:0]), 
                        .pulse_out(Pulse[3:0]), 
                        .rst(rst), 
                        .SW_OK(SW_OK[15:0]));
   SEnter_2_32  XLXI_3 (.BTN(BTN_OK[2:0]), 
                       .clk(clk_100mhz), 
                       .Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}), 
                       .Din(XLXN_48[4:0]), 
                       .D_ready(RDY_DUMMY), 
                       .Ai(Ai[31:0]), 
                       .Bi(Bi[31:0]), 
                       .blink(blink[7:0]), 
                       .readn(readn_DUMMY));
							  
							  
	clkdiv AAA(.clk200P(clk200P),
					.clk200N(clk200N),
				  	.rst(rst),
					.clk100MHz(clk_100mhz)
	);
	
	
   clk_div  XLXI_4 (.clk(clk_100mhz), 
                   .rst(rst), 
                   .SW2(SW_OK[2]), 
                   .clkdiv(Div[31:0]), 
                   .Clk_CPU(Clk_CPU));
   Display  XLXI_5 (.clk(clk_100mhz), 
                   .flash(Div[25]), 
                   .Hexs(Disp_num[31:0]), 
                   .LES(LE_out[7:0]), 
                   .point(point_out[7:0]), 
                   .rst(rst), 
                   .Start(Div[20]), 
                   .Text(SW_OK[0]), 
                   .seg_clk(SEGCLK), 
                   .seg_clrn(SEGCLR), 
                   .SEG_PEN(SEGEN), 
                   .seg_sout(SEGDT));
   Multi_8CH32  XLXI_6 (.clk(IO_clk), 
                       .Data0(CPU2IO[31:0]), 
                       .data1({N0, N0, PC[31:2]}), 
                       .data2(inst[31:0]), 
                       .data3(Counter_out[31:0]), 
                       .data4(Addr_out[31:0]), 
                       .data5(Data_out[31:0]), 
                       .data6(Data_in[31:0]), 
                       .data7(PC[31:0]), 
                       .EN(XLXN_71), 
                       .LES({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
         N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
         N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
         N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
         N0}), 
                       .point_in({Div[31:0], Div[31:0]}), 
                       .rst(rst), 
                       .Test(SW_OK[7:5]), 
                       .Disp_num(Disp_num[31:0]), 
                       .LE_out(LE_out[7:0]), 
                       .point_out(point_out[7:0]));
   GPIO  XLXI_7 (.clk(IO_clk), 
                .EN(GPIOF0), 
                .P_Data(CPU2IO[31:0]), 
                .rst(rst), 
                .Start(Div[20]), 
                .counter_set(XLXN_130[1:0]), 
                .GPIOf0(), 
                .led_clk(LEDCLK), 
                .led_clrn(LEDCLR), 
                .LED_out(LED_out[15:0]), 
                .LED_PEN(LEDEN), 
                .led_sout(LEDDT));
   RAM_B  XLXI_8 (.addra(XLXN_149[9:0]), 
                 .clka(XLXN_4), 
                 .dina(XLXN_147[31:0]), 
                 .wea(XLXN_148[0]), 
                 .douta(XLXN_150[31:0]));
   ROM_D  XLXI_9 (.a(PC[11:2]), 
                 .spo(inst[31:0]));
   INV  XLXI_12 (.I(clk_100mhz), 
                .O(XLXN_4));
   GND  XLXI_14 (.G(N0));
   Seg7_Dev  XLXI_16 (.flash(Div[25]), 
                     .Hexs(Disp_num[31:0]), 
                     .LES(LE_out[7:0]), 
                     .point(point_out[7:0]), 
                     .Scan({SW_OK[1], Div[19:18]}), 
                     .SW0(SW_OK[0]), 
                     .AN(AN[3:0]), 
                     .SEGMENT(SEGMENT[7:0]));
   PIO  XLXI_17 (.clk(IO_clk), 
                .EN(GPIOF0), 
                .PData_in(CPU2IO[31:0]), 
                .rst(rst), 
                .counter_set(), 
                .GPIOf0(), 
                .LED_out(LED[7:0]));
   SCPU  XLXI_21 (.clk(Clk_CPU), 
                           .Data_in(Data_in[31:0]), 
                           .inst_in(inst[31:0]), 
                           .INT(XLXN_137), 
                           .MIO_ready(), 
                           .reset(rst), 
                           .Addr_out(Addr_out[31:0]), 
                           .CPU_MIO(), 
                           .Data_out(Data_out[31:0]), 
                           .mem_w(XLXN_151), 
                           .PC_out(PC[31:0]));
   BUF  XLXI_22 (.I(V5), 
                .O(Buzzer));
   INV  XLXI_23 (.I(Clk_CPU), 
                .O(IO_clk));
   Counter  XLXI_24 (.clk(IO_clk), 
                    .clk0(Div[6]), 
                    .clk1(Div[9]), 
                    .clk2(Div[11]), 
                    .counter_ch(XLXN_130[1:0]), 
                    .counter_val(CPU2IO[31:0]), 
                    .counter_we(XLXN_128), 
                    .rst(rst), 
                    .counter_out(Counter_out[31:0]), 
                    .counter0_OUT(XLXN_137), 
                    .counter1_OUT(XLXN_136), 
                    .counter2_OUT(XLXN_135));
   MIO_BUS  XLXI_25 (.addr_bus(Addr_out[31:0]), 
                    .BTN(BTN_OK[3:0]), 
                    .clk(clk_100mhz), 
                    .counter_out(Counter_out[31:0]), 
                    .counter0_out(XLXN_137), 
                    .counter1_out(XLXN_136), 
                    .counter2_out(XLXN_135), 
                    .Cpu_data2bus(Data_out[31:0]), 
                    .led_out(LED_out[15:0]), 
                    .mem_w(XLXN_151), 
                    .ram_data_out(XLXN_150[31:0]), 
                    .rst(rst), 
                    .SW(SW_OK[15:0]), 
                    .counter_we(XLXN_128), 
                    .Cpu_data4bus(Data_in[31:0]), 
                    .data_ram_we(XLXN_148[0]), 
                    .GPIOe0000000_we(XLXN_71), 
                    .GPIOf0000000_we(GPIOF0), 
                    .Peripheral_in(CPU2IO[31:0]), 
                    .ram_addr(XLXN_149[9:0]), 
                    .ram_data_in(XLXN_147[31:0]));
   VCC  XLXN_37 (.P(V5));
endmodule