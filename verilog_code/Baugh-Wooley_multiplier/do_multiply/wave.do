onerror {resume}
quietly WaveActivateNextPane {} 0
#add wave -noupdate -divider {}

#add wave -noupdate -format Literal -radix binary /sqr/a
#add wave -noupdate -format Literal -radix hex /sqr/S


add wave -noupdate -format Literal -radix decimal /A
add wave -noupdate -format Literal -radix decimal /B
add wave -noupdate -format Literal -radix decimal /P



#add wave -noupdate -format Literal -radix unsigned  /test_FileName/test_Signal
# -radix後接型態 十進位 decimal, 1bit logic, 十六進位 hex, 二進位 binary, 正整數 unsigned

