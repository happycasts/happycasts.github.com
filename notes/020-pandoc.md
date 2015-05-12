__Resources:__

- [为什么我们要学习 Markdown 的三个理由](http://news.cnblogs.com/n/139649/)
- [light weight markup language](http://www.worldhello.net/gotgithub/appendix/markups.html)
- <http://haoduoshipin.com/episodes/19>
- [demo code](https://github.com/happycasts/episode-20-demo)
- <http://johnmacfarlane.net/pandoc/>

~~~
sudo apt-get install pandoc
~~~

~~~
\documentclass[11pt, a4paper]{book}
\usepackage[
    urlcolor = blue,
    colorlinks = true,
    linkcolor = black
    ]{hyperref}
\usepackage{graphicx}
\usepackage[
    font=small,
    format=plain,
    labelfont=bf,up,
    textfont=it,up]{caption}
\usepackage{fullpage}
\usepackage{xeCJK}
\setCJKmainfont{AR PL UMing CN}

\begin{document}
\title{Linux Guide for Chinese Beginners}
\author{Peter Wang}
\date{2001.1.1}
\maketitle
\tableofcontents\newpage\thispagestyle{empty}
\end{document}
~~~

### Step1

~~~
#!/bin/bash
cd book-content/
pandoc ch01.md -o ch01.tex
sed -e '/tableofcontents/r  ch01.tex' ../latex/template.tex >book.tex
xelatex book.tex

mv book.pdf ..
rm book.* *.tex &>/dev/null
~~~

### Step2: change title level
~~~
...
sed -i 's/^\\section{/\\chapter{/g'  book.tex
sed -i 's/^\\subsection{/\\section{/g'  book.tex
sed -i 's/^\\subsubsection{/\\subsection{/g'  book.tex
...
~~~

### Step3: code block
~~~
...
sed -i 's/\\begin{verbatim}/{\\footnotesize \\begin{quote}\\begin{verbatim}/g' book.tex
sed -i 's/\\end{verbatim}/\\end{verbatim}\\end{quote}}/g' book.tex
...
~~~

### Step4: handle more than one chapters in book-content

~~~
#!bin/bash
cd book-content/

>all.tex
for file in `ls *.md`
do
    echo $file
    shortname=${file%.*}
    pandoc $file -o $shortname.tex
    cat $shortname.tex >> all.tex
    rm $shortname.tex
    rm *.log 2>/dev/null
done

sed -e '/tableofcontents/r  all.tex' ../latex/template.tex >book.tex

sed -i 's/^\\section{/\\chapter{/g'  book.tex
sed -i 's/^\\subsection{/\\section{/g'  book.tex
sed -i 's/^\\subsubsection{/\\subsection{/g'  book.tex

sed -i 's/\\begin{verbatim}/{\\footnotesize \\begin{quote}\\begin{verbatim}/g' book.tex
sed -i 's/\\end{verbatim}/\\end{verbatim}\\end{quote}}/g' book.tex

xelatex book.tex
xelatex book.tex

mv book.pdf ..
rm book.* *.tex &>/dev/null

~~~