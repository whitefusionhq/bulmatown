---
layout: home
---

Welcome to my site!

I write about topics that I care about and believe are important. I try to bring my authentic voice every time I set out to type, and I strive to share a viewpoint that gets you thinking and inspired to dig deeper.

----
{: .my-6}

# Latest Articles
{: .mb-5 .title .has-text-centered}

{% assign posts = site.posts | slice: 0, 6 %}
{% render "bulmatown/collection", collection: posts, metadata: site.metadata %}

{% if site.posts.size > 6 %}

{: .mt-6 .has-text-centered}
<a href="/posts/" class="button is-primary is-outlined is-small"><span>Previous Articles</span> <span class="icon"><i class="fa fa-arrow-right"></i></span></a>

{% endif %}
