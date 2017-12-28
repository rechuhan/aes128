`ifndef __CRYPTO_DPI_PKG_SV__
`define __CRYPTO_DPI_PKG_SV__
package crypto_dpi_pkg;

typedef int unsigned uint_t;
`define in_uint_t input uint_t
`define out_uint_t output uint_t

import "DPI-C" function void aes_ecb_crypto_buf(`in_uint_t in_buf[], `out_uint_t out_buf[], input int bits,
                                                `in_uint_t key_buf[], input int mode);

import "DPI-C" function void ref_evp_cipher(`out_uint_t out[], `in_uint_t in[], `in_uint_t key[], input int enc);

function void crypto_dpi_aes_ecb_crypto_func(`in_uint_t in_buf[], `out_uint_t out_buf[], input int bits,
                                                `in_uint_t key_buf[], input int mode);
   out_buf = new[in_buf.size()];
   aes_ecb_crypto_buf(in_buf, out_buf, bits, key_buf, mode);
endfunction

function void crypto_dpi_ref_evp_cipher_func(`out_uint_t out[], `in_uint_t in[], `in_uint_t key[], input int enc);
   out = new[in.size()];
   ref_evp_cipher(out, in, key, enc);
endfunction

endpackage
`endif
