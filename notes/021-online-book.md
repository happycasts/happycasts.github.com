__Resources:__

- [episode-21-demo](https://github.com/happycasts/episode-21-demo)
- [The demo online](http://happycasts.github.com/episode-21-demo)
- [pandoc's
  markdown](http://johnmacfarlane.net/pandoc/demo/example9/pandocs-markdown.html)
- [Github's Markdown](http://github.github.com/github-flavored-markdown/)
- [Github pages](http://help.github.com/pages/)

~~~
git clone git@github.com:happycasts/episode-21-demo.git
./1_split_file.sh ;./2_md_to_html.sh ;./3_get_toc.sh ;./4_jekyll_header.sh
~~~

~~~
#!/bin/bash
#################################
#
#    Step1: Split file
#
#################################
cd book-content/
for file in `ls ch*.md`
do
    i=0
    IFS=
    # Set IFS, otherwise the leading spaces for code block is ignored
    shortname=${file%.*}
    while  read line
    do
        if echo $line | grep "^#"|grep -v "^###"; then # this will match "##" and "#"
            currentname=$shortname-$i.md #can be section or chapter synopsis
            echo '$currentname:'"$currentname"
            i=$((i+1))
        fi
        echo $line >> $currentname
    done < $file
    unset IFS #IFS will casue trouble in some cases, so must unset
done

cd ..
rm -rf md_tmp &>/dev/null
mkdir md_tmp
mv book-content/ch*-*.md md_tmp
cp -rf book-content/figures/ md_tmp &>/dev/null
~~~

~~~
#!/bin/bash
#################################
#
#    Step2: md -> html
#
#################################

cd md_tmp
for file in `ls *.md`
do
    shortname=${file%.*}
    pandoc $file >$shortname.html
done

cd ..
rm -rf html_tmp
mkdir html_tmp
mv md_tmp/*.html html_tmp
mv md_tmp/figures html_tmp &>/dev/null
rm -rf md_tmp
~~~

~~~
#!/bin/bash
#################################
#
#    Step3: get toc
#
#################################

echo "<ul id="toc">">index.html
chapter_no=1
for file in `ls book-content/ch*.md`
do
    i=0
    while read line
    do
        basefilename=`basename $file`
        shortname=${basefilename%.*}
        if echo $line | grep "^#"|grep -v "^###"; then
            if echo $line | grep "##"; then
                i=$((i+1))
                stringA=$line
                section=${stringA#'##'}
                echo "<li><h2><a href=\"${shortname}-$i.html\">$chapter_no.$i $section</a></h2></li>" >>index.html
            else
                stringB=$line
                chapter=${stringB#'#'}
                echo "<li><h1><a href=\"${shortname}-$i.html\">$chapter_no. $chapter</a></h1></li>" >>index.html
            fi
        fi
    done< $file
    chapter_no=$((chapter_no+1))
done
echo "</ul>">>index.html

mv index.html html_tmp
~~~

~~~
#!/bin/bash
#################################
#
#   Step4: add jekyll header
#
#################################

for file in `ls html_tmp/*.html`
do
   cp $file $file.tmp
   echo "---" >$file
   echo "layout: master" >>$file
   echo "---" >> $file
   cat $file.tmp >> $file
   rm $file.tmp
done
~~~