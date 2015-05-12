__Resources:__

- <http://en.wikipedia.org/wiki/Shebang_(Unix)>
- <http://www.gnu.org/software/bash/manual/bash.html#Command-Substitution>
- <http://linuxcommand.org/tlcl.php>

~~~
#!/usr/bin/env bash
for i in `ls`
do
    echo $i
done
~~~

~~~
#!/usr/bin/env bash
echo "
Number of arguments: $#
The program name is: $0
The first argument is: $1
"
~~~

~~~
#!/usr/bin/env bash

if [ $# != 1 ]
then
    echo """
Error: missing operand
Usage: ./delete_or_not.sh PATHNAME
         """ >&2
    exit 1
fi

cd $1
for file in `ls`
do
    echo -n "Want to delete:$file ? (Y/n): "
    read AAA
    if [ "${AAA:-y}" = "y" ];then
        echo delete $file
        rm $file
        echo ...done
    else
        echo pass
    fi
done
~~~