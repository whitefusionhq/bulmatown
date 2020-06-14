---
layout: page
title: Articles
pagination:
  enabled: true
---

{% assign posts = paginator.documents %}
{% render "bulmatown/collection", collection: posts, metadata: site.metadata %}

{% render "bulmatown/pagination", paginator: paginator %}