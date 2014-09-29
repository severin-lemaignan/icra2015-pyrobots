
TARGET=root.tex

#PLOT=$(wildcard data/*.gnuplot)
DOT=$(wildcard figs/*.dot)
SVG=$(wildcard figs/*.svg)

all: these

%.pdf: %.svg
	inkscape --export-pdf $(@) $(<)

%.aux: these

%.svg: %.dot

	twopi -Tsvg -o$(@) $(<)

%.eps: %.gnuplot

	gnuplot $(<)

bib: $(TARGET:.tex=.aux)

	bibtex $(TARGET:.tex=.aux)

these: $(TARGET) $(SVG:.svg=.pdf) $(DOT:.dot=.pdf) $(PLOT:.gnuplot=.eps)

	TEXFONTS=:./fonts TEXINPUTS=:./fonts:./sty pdflatex -shell-escape $(TARGET)
	#TEXFONTS=:./fonts TEXINPUTS=:./sty pdflatex $(TARGET)

# Check style:
proof:

	echo "weasel words: "
	sh bin/weasel *.tex
	echo
	echo "passive voice: "
	sh bin/passive *.tex
	echo
	echo "duplicates: "
	perl bin/dups *.tex

clean:
	rm -f *.aux *.log *.snm *.out *.toc *.nav *intermediate *~ *.glo *.ist $(SVG:.svg=.pdf) $(DOT:.dot=.svg) $(DOT:.dot=.pdf) $(PLOT:.gnuplot=.eps)

distclean: clean
	rm -f $(TARGET:.tex=.pdf)
