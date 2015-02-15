# Stock Images API [![Build Status](https://travis-ci.org/geekjuice/StahkPhotos.svg?branch=master)](https://travis-ci.org/geekjuice/StahkPhotos)

API created from scraping:
 -  [Little Visuals][littlevisuals]
 -  [Unsplash][unsplash]
 -  [New Old Stock][newoldstock]
 -  [Picjumbo][picjumbo]
 -  [Gratisography][gratis]
 -  [Getrefe][getrefe]
 -  [Jay Mantri][jaymantri]
 -  [Picography][picography]

Inspired by this [Medium][medium] article

Recreated using [Mort][mort]

![img][img]
_Images provided by this API_

[mort]: http://github.com/geekjuice/mort
[cheerio]: http://github.com/cheeriojs/cheerio
[medium]: https://medium.com/p/62ae4bcbe01b
[img]: http://stahkphotos.herokuapp.com/random
[littlevisuals]: http://littlevisuals.co
[unsplash]: http://unsplash.com
[newoldstock]: http://nos.twnsnd.co/
[picjumbo]: http://picjumbo.com
[gratis]: http://gratisography.com
[getrefe]: http://getrefe.tumblr.com
[jaymantri]: http://jaymantri.com
[picography]: http://picography.co

## Endpoints

__Home page:__ `http://stahk.photos`

__API Root:__ `http://api.stahk.photos`

__Endpoints:__ `/endpoints` - Returns available endpoints

__Random:__ `/random` - Returns random image from random endpoint

__Debug:__ `/{{ endpoint }}(/(random|\d+)?/debug` - Returns a JSON response of
image info _i.e. image source, image url, width, height, etc._


__Little Visuals:__ `/littlevisuals/(random|\d+)?`

__Unsplash:__ `/unsplash/(random|\d+)?`

__New Old Stock:__ `/newoldstock/(random|\d+)?`

__Picjumbo:__ `/picjumbo/(random|\d+)?`

__Gratisography:__ `/gratisography/(random|\d+)?`

__Getrefe:__ `/getrefe/(random|\d+)?`

__Jay Mantri:__ `/jaymantri/(random|\d+)?`

__Picography:__ `/picography/(random|\d+)?`


## Example response (From Unsplash root)
```javascript
{
  images: [
    "http://37.media.tumblr.com/1ecfc1ee5d12ecfe0b48c069980609bf/tumblr_n8zm3lrclm1st5lhmo1_1280.jpg",
    "http://37.media.tumblr.com/bddaeb8fe12eda6bb40cf6a0a18d9efa/tumblr_n8zm8ndGiY1st5lhmo1_1280.jpg",
    "http://33.media.tumblr.com/0de1b93512d7b2b6287c1e4b630212b6/tumblr_n8zlzedP0b1st5lhmo1_1280.jpg",
    "http://38.media.tumblr.com/e6c1c887ba8e24a855351940bcd3c343/tumblr_n8zm44LBpl1st5lhmo1_1280.jpg",
    "http://38.media.tumblr.com/e77ef190ff20487acedb1d664a535c1b/tumblr_n8zlzxbFUT1st5lhmo1_1280.jpg",
    "http://31.media.tumblr.com/53b1b2ec56944c977cdd7ee10a9b4ba4/tumblr_n8zm0yzydj1st5lhmo1_1280.jpg",
    "http://31.media.tumblr.com/8dd94ea5b1ff565d0f64ac1e7c610ce9/tumblr_n8zm2tFWMf1st5lhmo1_1280.jpg",
    "http://38.media.tumblr.com/2aec5b8337c3f2677080ea93f88a59aa/tumblr_n8zm1wVHz11st5lhmo1_1280.jpg",
    "http://31.media.tumblr.com/17b062d8170b0cd6e1b4a63db7e20df1/tumblr_n8zm9idM4J1st5lhmo1_1280.jpg",
    "http://38.media.tumblr.com/48b91f8ac34b6c31d817f65ad9402015/tumblr_n8zm0d48Jx1st5lhmo1_1280.jpg"
  ],
  source: "Unsplash",
  sourceUrl: "http://unsplash.com",
  fetchedAt: 1406513046093,
  status: 200
}
```

## Example response (From Unsplash debug)
```javascript
{
  source: "Unsplash",
  sourceURL: "http://unsplash.com",
  image: "http://38.media.tumblr.com/9cca3d64c075b55c0a96303174d66b19/tumblr_na0l33ez3W1st5lhmo1_1280.jpg",
  width: 1280,
  height: 720,
  fetchedAt: 1408115765952,
  status: 200
}
```

## TODO
- [ ] Handle pagination
- [ ] Return redirect response without url change
- [ ] Rename API routes (really? `debug`?...)


### Copyright

Copyright &copy; 2015 Nicholas Hwang
