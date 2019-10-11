onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib prop_clock_divisor_opt

do {wave.do}

view wave
view structure
view signals

do {prop_clock_divisor.udo}

run -all

quit -force
