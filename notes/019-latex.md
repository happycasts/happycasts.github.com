---
layout: shownote
title: Latex
---
### install

~~~
lsb_release -a
sudo apt-get install texlive
~~~

### bare bone

~~~
\documentclass[11pt, a4paper]{book}
\begin{document}
This is the content
\end{document}
~~~
- <http://en.wikibooks.org/wiki/LaTeX/Basics>

~~~
xelatex test.tex
evince test.pdf
~~~

### top matter

~~~
\title{Linux Guide for Chinese Beginners}
\author{Peter Wang}
\date{2012.4.1}
\maketitle
~~~

- <http://en.wikibooks.org/wiki/LaTeX/Document_Structure#Top_Matter>

### main content

~~~
\chapter{name of chapter}
\section{name of section}
text go here
\subsection{name of subsection}
text go here
~~~

- <http://en.wikibooks.org/wiki/LaTeX/Document_Structure#Sectioning_Commands>

### packages

~~~
\usepackage[urlcolor = blue, colorlinks = true]{hyperref}
...
\url{http://google.com}
~~~

~~~
texdoc hyperref
~~~
- <http://en.wikibooks.org/wiki/LaTeX/Basics#LaTeX_commands>
- <http://en.wikibooks.org/wiki/LaTeX/Basics#Packages>

### add graphics

~~~
\usepackage{graphicx}
...
\begin{figure}[htb]
\centering
\includegraphics{./figures/1.1.png}
\caption{Local version control diagram}
\end{figure}
~~~

### change page layout

~~~
\usepackage{fullpage}
~~~

- <http://en.wikibooks.org/wiki/LaTeX/Page_Layout>

### code blocks

~~~
{\footnotesize \begin{quote}\begin{verbatim}
#include <stdio.h>

int main()
{
    printf("hello\n");
    return 0;
}
\end{verbatim}\end{quote}}
~~~
### add table of contents

~~~
\tableofcontents\newpage
~~~

NOTE: need to run `xelatex test.tex` twice!!

>so you need to re-run LaTeX one extra time to ensure that all ToC pagenumber
>references are correctly calculated.

- <http://en.wikibooks.org/wiki/LaTeX/Document_Structure#Table_of_contents>

### Chinese support

~~~
fc-list :lang=zh|grep CN
sudo apt-get install ttf-arphic-uming
~~~

~~~
\usepackage{xeCJK}
\setCJKmainfont{AR PL UMing CN}
~~~
- <https://github.com/larrycai/kaiyuanbook/wiki>

### end result with Chinese support

~~~
\documentclass[11pt, a4paper]{book}
\usepackage[urlcolor = blue, colorlinks = true, linkcolor = black ]{hyperref}
\usepackage{graphicx}
\usepackage{fullpage}
\usepackage{xeCJK}
\setCJKmainfont{AR PL UMing CN}
\begin{document}
\title{Linux Guide for Chinese Beginners}
\author{Peter Wang}
\date{2012.4.1}
\maketitle
\tableofcontents\newpage

\chapter{ 中文 name of chapter}
\section{name of section}
text go here 中文 中文 中文
\begin{figure}[htb]
\centering
\includegraphics{./figures/1.1.png}
\caption{Local version control diagram}
\end{figure}
\subsection{name of subsection}
text go here
{\footnotesize \begin{quote}\begin{verbatim}
#include <stdio.h>

int main()
{
    printf("hello\n");
    return 0;
}
\end{verbatim}\end{quote}}

\end{document}
~~~

