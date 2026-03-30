vsim -voptargs=+acc work.tb_FIR
view structure wave signals

do wave.do

log -r *
run -all

