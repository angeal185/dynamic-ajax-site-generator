###codepen###

document.getElementsByClassName or
(document.getElementsByClassName = (e) ->
  n = undefined
  t = undefined
  r = undefined
  a = document
  o = []
  if a.querySelectorAll
    return a.querySelectorAll('.' + e)
  if a.evaluate
    t = './/*[contains(concat(\' \', @class, \' \'), \' ' + e + ' \')]'
    n = a.evaluate(t, a, null, 0, null)
    while r = n.iterateNext()
      o.push r
  else
    n = a.getElementsByTagName('*')
    t = new RegExp('(^|\\s)' + e + '(\\s|$)')
    r = 0
    while r < n.length
      t.test(n[r].className) and o.push(n[r])
      r++
  o
)

do ->
  t = 1

  e = ->
    `var e`
    h = '100%'

    e = ->
      `var e`
      `var t`
      e = document.getElementsByClassName('codepen')
      t = e.length - 1
      while t > -1
        u = a(e[t])
        if 0 != Object.keys(u).length and u = o(u)
          u.user = n(u, e[t])
          r(u)

          c = i(u)
          l = s(u, c)
          f e[t], l
        t--
      m()
      return

    n = (e, n) ->
      `var t`
      if 'string' == typeof e.user
        return e.user
      t = 0
      r = n.children.length
      while t < r
        a = n.children[t]
        o = a.href or ''
        i = o.match(/codepen\.(io|dev)\/(\w+)\/pen\//i)
        if i
          return i[2]
        t++
      'anon'

    r = (e) ->
      e['slug-hash']

    a = (e) ->
      `var n`
      `var t`
      `var r`
      `var a`
      n = {}
      t = e.attributes
      r = 0
      a = t.length
      while r < a
        o = t[r].name
        0 == o.indexOf('data-') and (n[o.replace('data-', '')] = t[r].value)
        r++
      n

    o = (e) ->
      e.href and (e['slug-hash'] = e.href)
      e.type and (e['default-tab'] = e.type)
      e.safe and (if 'true' == e.safe then (e.animations = 'run') else (e.animations = 'stop-after-5'))
      e

    i = (e) ->
      `var n`
      `var t`
      `var r`
      `var a`
      `var o`
      n = u(e)
      t = if e.user then e.user else 'anon'
      r = '?' + l(e)
      a = if e.preview and 'true' == e.preview then 'embed/preview' else 'embed'
      o = [
        n
        t
        a
        e['slug-hash'] + r
      ].join('/')
      o.replace /\/\//g, '//'

    u = (e) ->
      if e.host then c(e.host) else if 'file:' == document.location.protocol then 'https://codepen.io' else '//codepen.io'

    c = (e) ->
      if e.match(/^\/\//) or !e.match(/https?:/) then document.location.protocol + '//' + e else e

    l = (e) ->
      `var n`
      `var t`
      n = ''
      for t of e
        '' != n and (n += '&')
        n += t + '=' + encodeURIComponent(e[t])
      n

    s = (e, n) ->
      `var r`
      `var a`
      `var o`
      `var i`
      r = undefined
      if e['pen-title'] then (r = e['pen-title']) else r = 'CodePen Embed ' + t
      t++
      a = 
        id: 'cp_embed_' + e['slug-hash'].replace('/', '_')
        src: n
        scrolling: 'no'
        frameborder: '0'
        height: d(e)
        allowTransparency: 'true'
        allowfullscreen: 'true'
        name: 'CodePen Embed'
        title: r
        'class': 'cp_embed_iframe ' + (if e['class'] then e['class'] else '')
        style: 'width: ' + h + '; overflow: hidden;'
      o = '<iframe '
      for i of a
        o += i + '="' + a[i] + '" '
      o += '></iframe>'

    d = (e) ->
      if e.height then e.height else 300

    f = (e, n) ->
      `var t`
      if e.parentNode
        t = document.createElement('div')
        t.className = 'cp_embed_wrapper'
        t.innerHTML = n
        e.parentNode.replaceChild(t, e)
      else
        e.innerHTML = n
      return

    m = ->
      'function' == typeof __CodePenIFrameAddedToPage and __CodePenIFrameAddedToPage()
      return

    p = ->
      `var e`
      `var n`
      `var t`
      return 0
      e = undefined
      n = undefined
      t = undefined
      return

    e()
    p()
    return

  n = (e) ->
    if /in/.test(document.readyState) then setTimeout('window.__cp_domReady(' + e + ')', 9) else e()
    return

  window.__cp_domReady = n
  window.__CPEmbed = e
  n(->
    new __CPEmbed
    return
  )
  return