
export PRJ_HOME = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: clean comp run

clean:
	rm -rf simv* csrc *.log vc_hdrs.h ucli.key

comp:
	vcs -full64 -sverilog -timescale=1ns/10ps -ntb_opts uvm-1.1 -notice -l comp.log -debug_all -f ${PRJ_HOME}/etc/rtl.f -f ${PRJ_HOME}/etc/tb.f -top top -cm line+cond+tgl+fsm+branch+assert -cm_tgl mda

run:
	./simv +ntb_random_seed=1 +UVM_TESTNAME=aes128_simple_test -sv_lib ${PRJ_HOME}/ref_model/c/lib/libssldpi -l run.log -cm line+cond+tgl+fsm+branch+assert

wave:
	dve -full64 &

cov:
	dve -full64 -cov &

echo:
	echo ${PRJ_HOME}

