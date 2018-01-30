
export PRJ_HOME = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
WORK_DIR=`pwd`
TESTNAME=aes128_direct_test
TESTLIST=aes128_direct_test aes128_rand_test

all: clean comp run 

clean:
	rm -rf simv* csrc *.log vc_hdrs.h ucli.key

comp:
	vcs -full64 -sverilog -timescale=1ns/10ps -ntb_opts uvm-1.1 -notice -l comp.log -debug_all -f ${PRJ_HOME}/etc/rtl.f -f ${PRJ_HOME}/etc/tb.f -top top -cm line+cond+tgl+fsm+branch+assert -cm_tgl mda

run:
	./simv +UVM_TESTNAME=${TESTNAME} -sv_lib ${PRJ_HOME}/ref_model/c/lib/libssldpi -l run.log -cm line+cond+tgl+fsm+branch+assert

regression:comp
	for Test in ${TESTLIST}; do \
		./simv +UVM_TESTNAME=$$Test -sv_lib ${PRJ_HOME}/ref_model/c/lib/libssldpi -l $$Test.log -cm line+cond+tgl+fsm+branch+assert -cm_name $$Test; \
	done;

wave:
	dve -full64 &

cov:
	dve -full64 -cov &

echo:
	echo ${PRJ_HOME}
	echo ${WORK_DIR}

