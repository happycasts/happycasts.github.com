---
layout: default
title: Happycasts
---

I am a screencastr at <http://happycasts.net>.


<p><br /><b>My Epsodes:</b></p>
  <ul class="posts">
    {% for post in site.posts %}
      <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>

<p><br /><b>Contact Information:</b></p>

<blockquote>
happypeter1983@gmail.com
</blockquote>

[oss]:http://en.wikipedia.org/wiki/Open_source
