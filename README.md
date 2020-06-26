# Bulmatown
## A Bulma CSS starter theme for Bridgetown.

[Bulma](https://bulma.io) is a clean, modern CSS framework for rapid prototyping of content-focused websites. Use this theme to start using Bulma in your new [Bridgetown](https://www.bridgetownrb.com) site quickly, while preserving _all_ of the advanced customization possibilities as if you configured Bulma manually.

**[LIVE DEMO](https://bulmatown.vercel.app)**

![Bulmatown Example](https://res.cloudinary.com/mariposta/image/upload/c_thumb,w_900/v1593195961/bulmatown/bulmatown-example.jpg)

## Installation

Bulmatown requires Bridgetown v0.15 or later

To install Bulmatown while creating a new Bridgetown site:

```sh
bridgetown new mysite -a https://github.com/whitefusionhq/bulmatown
```

Or to add it to your existing Bridgetown site:

```sh
bundle exec bridgetown apply https://github.com/whitefusionhq/bulmatown
```

## Usage

The installation process will prompt you to configure your site to use Bulmatown automatically. However, if you decline those changes, you can inspect the [example site](https://github.com/whitefusionhq/bulmatown/tree/master/example) in this repository.

Bulmatown comes with a few color variations out of the box. You can use the `theme_variation` Sass variable to switch the variation. For example:

```scss
// frontend/styles/index.scss

$theme_variation: rust;

@import "~bulmatown/frontend/styles"
```

The available options are:

* `default`
* `rust`
* `fuchsia`
* `fineart`

Speaking of Sass variables, you can put all your custom Bulma variables right before the `@import` statement and Bulma will pick up all the changes. You can even override any of the variables defined by Bulmatown out-of-the-box. [Read the Bulma documentation for more information.](https://bulma.io/documentation/)

### Hero Banners and Images

Bulmatown will automatically look for `image` and `image_hero` front matter variables in your pages and documents and display those in the hero banners (and in the card component for post previews). Check out the [bridgetown-cloudinary](https://github.com/bridgetownrb/bridgetown-cloudinary) plugin for an easy way to add advanced image asset handling to your site.

In addition, for a fun way to add some sparkle to a hero banner with an image background, you can put `rainbow_hero: true` in your front matter to display a nice colorful gradient.

## Authors

To show author information at the top of a blog post, add `authors.yml` to your data folder. For example:

```yaml
# src/_data/authors.yml
jared:
  name: Jared White
  avatar: /images/jared-white-avatar.jpg
  twitter: jaredcwhite
  website: https://jaredwhite.com
```

Then simply add `author: jared` to your post's front matter.

This will link to an `/authors/<authorname>` URL. You can create a page at that URL manually, or you can auto-generate author archives using a Prototype Page. ([See this example file.](https://github.com/whitefusionhq/bulmatown/blob/master/example/src/authors/author.html))

## Overriding Layout Templates and Components

If you ever find yourself needing to override one or more of the layout templates or Liquid components provided by Bulmatown, you can use the `bridgetown plugins cd` command to drill down into the gem and copy files out to your own site. For example:

```sh
# copy the layouts folder:

bundle exec bridgetown plugins cd Bulmatown/layouts

cp -r bulmatown $BRIDGETOWN_SITE/src/_layouts
exit

# copy the components folder:

bundle exec bridgetown plugins cd Bulmatown/components

cp -r bulmatown $BRIDGETOWN_SITE/src/_components
exit
```

Then you can go to the `bulmatown` folder in your layouts or components folders and make the changes from there. Or instead of wholesale copying over `bulmatown` entirely, you can pick and choose which files you want to copy.

## Contributing

1. Fork it (https://github.com/whitefusionhq/bulmatown/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request