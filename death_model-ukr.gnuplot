#!/usr/bin/gnuplot

#######################################
###
###   @author Vitalii Chernookyi
###                             
###   @copyright GPLv3
###
#######################################

#Set the output to a png file
set terminal png size 2048,1024
# The file we'll write to
set output 'death_model-ukr.png'
# The graphic title
set title 'Covid19 Death Model --- Ukr. F(x) = a + b*x + c*exp(d*x + e). Approximated using Levenberg–Marquardt algorithm. © Vitalii Chernookyi'
set key left box
set xtics 62,7
set grid back

#set timefmt '%d.%m.%Y'
#set xdata time
#set format x '%d.%m.%Y'

f(x) = a + b*x + c*exp(d*x + e)

### Let's use Levenberg–Marquardt algorithm
###
fit [62:211][0:3000] f(x) 'data.dat' u 1:3 via 'start.par'

#plot the graphic
set logscale y 10
set bmargin 3 # leave room for 2 lines of x labels
label(i1,i2) = sprintf("%d\n%s",column(i1),stringcolumn(i2))

plot [62:275] \
	'data.dat' u 1:3:xtic(int($0)%14==0 ? label(1,2) : "") t "COVID-19: Померли всього : Данные", \
	f(x)
