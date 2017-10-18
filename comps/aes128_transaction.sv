`ifndef __AES128_TRANSACTION_SV__
`define __AES128_TRANSACTION_SV__

class aes128_transaction extends uvm_sequence_item;

   typedef enum bit {ENCRYPT = 0, DECRYPT = 1} encrypt_decrypt_e;

   //input
   rand bit [127:0] plaintext;
   rand bit [127:0] aes_key;
   rand bit encrypt_decrypt;//0:encrypt 1:decrypt
   //output
   rand bit [127:0] ciphertext;
   
   int unsigned src[];
   int unsigned key[];
   int unsigned dst[];

   encrypt_decrypt_e encrypt_decrypt_type;

   `uvm_object_utils_begin(aes128_transaction)
      `uvm_field_int(plaintext, UVM_ALL_ON | UVM_NOCOMPARE)
      `uvm_field_int(aes_key, UVM_ALL_ON | UVM_NOCOMPARE)
      `uvm_field_enum(encrypt_decrypt_e, encrypt_decrypt_type, UVM_ALL_ON | UVM_NOCOMPARE)
      `uvm_field_int(encrypt_decrypt, UVM_ALL_ON | UVM_NOCOMPARE)
      `uvm_field_int(ciphertext, UVM_ALL_ON)
      //`uvm_field_array_int(src, UVM_ALL_ON | UVM_NOCOMPARE)
      //`uvm_field_array_int(key, UVM_ALL_ON | UVM_NOCOMPARE)
      //`uvm_field_array_int(dst, UVM_ALL_ON | UVM_NOCOMPARE)
   `uvm_object_utils_end

   function new(string name = "aes128_transaction");
      super.new(name);
      src = new[4](src);
      key = new[4](key);
      dst = new[4](dst);
   endfunction

   function void get_encrypt_decrypt_type();
      if(encrypt_decrypt == 0) begin
         encrypt_decrypt_type = ENCRYPT;
      end
      else begin
         encrypt_decrypt_type = DECRYPT;
      end
   endfunction

   function void convert_128to32(ref int unsigned out[], input bit [127:0] in);
      bit [31:0] temp = 0;
      for(int i = 0; i <= 3; i++) begin
         for(int j = 0; j <= 3; j++) begin
            temp = temp >> 8;
            temp[31:24] = in[127:120];
            in = in << 8;
         end
         out[i] = temp;
      end
   endfunction

   function void convert_128to32_all();
      convert_128to32(src, plaintext);
      convert_128to32(key, aes_key);
      //convert_128to32(dst, ciphertext);
   endfunction

   function void convert_32to128(output bit [127:0] out, ref int unsigned in[]);
      bit [31:0] temp = 0;
      for(int i = 0; i <= 3; i++) begin
         for(int j = 0; j <= 3; j++) begin
            temp = temp << 8;
            temp[7:0] = in[i][7:0];
            in[i] = in[i] >> 8;
         end
         out = out << 32;
         out[31:0] = temp;
      end
   endfunction

   function void convert_32to128_all();
      //convert_32to128(plaintext, src);
      //convert_32to128(aes_key, key);
      convert_32to128(ciphertext, dst);
   endfunction

endclass

`endif

