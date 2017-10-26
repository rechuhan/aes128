
module word_mixcolum(in,outx,outy);

   input [31:0] in;
   output [31:0] outx;
   output [31:0] outy;
   
   reg [31:0] outx;
   reg [31:0] outy;
   
   reg [7:0] a;
   reg [7:0] b;
   reg [7:0] c;
   reg [7:0] d;
   wire [7:0] x1;
   wire [7:0] x2;
   wire [7:0] x3;
   wire [7:0] x4;
   wire [7:0] y1;
   wire [7:0] y2;
   wire [7:0] y3;
   wire [7:0] y4;

   byte_mixcolum bm1 (.a(a), .b(b), .c(c), .d(d), .outx(x1), .outy(y1));
   byte_mixcolum bm2 (.a(b), .b(c), .c(d), .d(a), .outx(x2), .outy(y2));
   byte_mixcolum bm3 (.a(c), .b(d), .c(a), .d(b), .outx(x3), .outy(y3));
   byte_mixcolum bm4 (.a(d), .b(a), .c(b), .d(c), .outx(x4), .outy(y4));


   reg[31:0] in_var;
   reg[31:0] outx_var,outy_var;

   //split:
   always @(in) begin
      in_var=in;
      a = (in_var[31:24]);
      b = (in_var[23:16]);
      c = (in_var[15:8]);
      d = (in_var[7:0]);
   end

   //mix:
   always @(x1 or x2 or x3 or x4 or y1 or y2 or y3 or y4) begin
		outx_var[31:24]=x1;
		outx_var[23:16]=x2;
		outx_var[15:8]=x3;
		outx_var[7:0]=x4;
		outy_var[31:24]=y1;
		outy_var[23:16]=y2;
		outy_var[15:8]=y3;
		outy_var[7:0]=y4;
		
		outx = (outx_var);
		outy = (outy_var);
   end

endmodule

