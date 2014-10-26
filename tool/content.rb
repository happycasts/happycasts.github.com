# encoding: utf-8
# rebuild the index.md file

def html(num, sname, fname, token)
  str = <<-EOF
        <tr class="episode-wrap#{token}">
          <td class="episode-index">#{num}</td>
          <td class="episode-title">
            <a href="#{fname}">#{sname}</a>
          </td>
        </tr>
      EOF
end

def layout(rows)
  str = <<-EOF.gsub(/^ {4}/, '')
    ---
    layout: default
    title: Happycasts
    ---
    <section class="container content">
      <table class="index-table">
        <tbody>
        #{rows}
        </tbody>
      </table>
    </section>
  EOF
end

list = ""
count = 0
Dir["../[01]*.md"].each do |f|
  count += 1
  a = f.gsub('.md', '').gsub('../', '').split('-')
  sname = a[1..-1].join(' ')
  fname = a.join('-') << '.html'
  token = count.even? ? ' even' : ''
  list = html(a[0], sname, fname, token) << list
end

File.open("../index.md", 'w+') do |f|
  f.write(layout(list))
end

