set terminal epslatex
set output "croquignole-expe.tex"

set style line 1 lt 2 lc rgb "blue" lw 4

set grid

set xrange [0:68]
set xlabel 'Time (minutes)'

set yrange [0:50]
set ytics 5 nomirror
set ylabel 'Events fired'

set y2range [0:220]
set y2tics 20 nomirror
set y2label 'Actions started'


set style fill transparent solid 1.0

plot "data/actions-ranger0.dat" using 1:3 with boxes lc rgb "gold" axes x1y2 title "Actions started",\
     "data/actions-ranger0.dat" using 1:2 ls 1 axes x1y1 with lines title "Events fired"
