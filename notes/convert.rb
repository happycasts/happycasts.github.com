
Dir["./*.md"].each do |f|
  s = ''
  if f.include?('-')
    File.open(f, 'r') do |file|
      s = file.read.sub(/^layout: shownote/, '').
        sub(/^---\n\n?title: .*?\n---\n/, '').
        gsub(/\{% highlight (.*?) %\}/, '```\1').
        gsub(/\{% endhighlight %\}/, '```').
        gsub(/\n{3,}/, "\n\n")
    end

    File.open(f, 'w') do |file|
      file.write(s.strip)
    end
  end
end
