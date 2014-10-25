---
layout: default
title: Happycasts
---

<section class="container content">
  <ul class="listing">
    {% for post in site.posts %}
      <li>
        <span>{{ post.date | date_to_string }}</span> <a href="{{ post.url }}">{{ post.title }}</a>
      </li>
    {% endfor %}
  </ul>
</section>
