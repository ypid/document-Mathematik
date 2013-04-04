include $(HOME)/Skripten/makefiles/latex/Makefile.rules

TEXORGFILE	= Mathematik
TEXFILE		= $(TEXORGFILE)
FILE		= $(TEXORGFILE)

#TEXBTFILE	= $(TEXORGFILE)-ly
## Muss in "main" liegen mit ln -s main/doc.tex doc.tex

UPLOADFILE	= "$(TEXFILE).pdf"
## Dateien werden vor einem Upload nach /tmp Kopiert
UPLOADDIR	= Klasse/11
UPLOAD		?= $(UPLOADCOM) /httpdocs/$(UPLOADDIR) /tmp/$(UPLOADFILE)
##UPLOAD		?= $(UPLOADCOM) /httpdocs/$(UPLOADDIR)/$(UPLOADFILE).tmp /tmp/$(UPLOADFILE)
## Geht nur bei einer Datei

include $(HOME)/Skripten/makefiles/latex/Makefile.if

all: gitstats main upload
#	make FILE="$(TEXBTFILE)"

main: $(TEXFILE).pdf log

files/git/version.tex: .git/COMMIT_EDITMSG
	LaTeX-git-commit-count.sh > files/git/version.tex	## \readgitstat{7}
	LaTeX-git-log.sh |sed 's/rlllrrr/rllp{14cm}rrr/g'|sed 's/bux/bug/g' > files/git/versions-log.tex
	## Falls die Tabele über den rechten Rand geht: |sed 's/rlllrrr/rllp{12cm}rrr/g'
	LaTeX-gitstats.sh >/dev/null
	## LaTeX-gitstats.sh "Name_für_website" >/dev/null
	$(TPUTDONE)
	$(ECHO) "gitstats done"
	$(TPUTRESET)

include $(HOME)/Skripten/makefiles/latex/Makefile.targets

