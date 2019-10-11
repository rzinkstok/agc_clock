onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+prop_clock_divisor -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.prop_clock_divisor xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {prop_clock_divisor.udo}

run -all

endsim

quit -force
