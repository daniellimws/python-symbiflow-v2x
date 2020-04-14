/*
 * Copyright (C) 2020  The SymbiFlow Authors.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

`include "../dsp_combinational/dsp_combinational.sim.v"
`include "../dsp_inout_registered/dsp_inout_registered.sim.v"
`include "../dsp_in_registered/dsp_in_registered.sim.v"
`include "../dsp_out_registered/dsp_out_registered.sim.v"
`include "../dsp_partial_registered/dsp_partial_registered.sim.v"

/* DSP Block with register on both the inputs and the output */
(* MODES="REGISTERED_NONE; REGISTERED_IN; REGISTERED_OUT; REGISTERED_INOUT; REGISTERED_PARTIAL" *)
module DSP_MODES (clk, a, b, m, out);
	localparam DATA_WIDTH = 4;

	parameter MODE = "REGISTERED_INOUT";

	input wire clk;
	input wire [DATA_WIDTH/2-1:0] a;
	input wire [DATA_WIDTH/2-1:0] b;
	input wire m;
	output wire [DATA_WIDTH-1:0] out;

	/* Register modes */
	generate
		if (MODE == "REGISTERED_NONE") begin
			DSP_COMBINATIONAL dsp_int_comb (.a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_INOUT") begin
			DSP_INOUT_REGISTERED dsp_int_regio (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_IN") begin
			DSP_IN_REGISTERED dsp_int_regi (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_OUT") begin
			DSP_OUT_REGISTERED dsp_int_rego (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end if (MODE == "REGISTERED_PARTIAL") begin
			DSP_PARTIAL_REGISTERED dsp_int_part (.clk(clk), .a(a), .b(b), .m(m), .out(out));
		end
	endgenerate
endmodule
