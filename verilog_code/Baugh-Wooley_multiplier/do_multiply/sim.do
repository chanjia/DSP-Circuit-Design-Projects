vsim -voptargs=+acc work.tb_multiply
view structure wave signals

do wave.do

log -r *
run -all

