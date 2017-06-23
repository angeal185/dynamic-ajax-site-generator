###pagination###

(($, window) ->

  $.fn.pagin = (options) ->
    $owner = this
    settings = $.extend({
      total: 0
      page: 1
      maxVisible: null
      leaps: true
      href: '#page-${number}'
      hrefVariable: '${number}'
      next: '&raquo;'
      prev: '&laquo;'
      firstLastUse: false
      first: '<span aria-hidden="true">&larr;</span>'
      last: '<span aria-hidden="true">&rarr;</span>'
      wrapClass: 'pagination'
      activeClass: 'active'
      disabledClass: 'disabled'
      nextClass: 'next'
      prevClass: 'prev'
      lastClass: 'last'
      firstClass: 'first'
    }, $owner.data('settings') or {}, options or {})

    renderPage = ($pagin, page) ->
      `var step`
      page = parseInt(page, 10)
      lp = undefined
      maxV = if settings.maxVisible == 0 then 1 else settings.maxVisible
      step = if settings.maxVisible == 1 then 0 else 1
      vis = Math.floor((page - 1) / maxV) * maxV
      $page = $pagin.find('li')
      settings.page = page = if page < 0 then 0 else if page > settings.total then settings.total else page
      $page.removeClass settings.activeClass
      lp = if page - 1 < 1 then 1 else if settings.leaps and page - 1 >= settings.maxVisible then Math.floor((page - 1) / maxV) * maxV else page - 1
      if settings.firstLastUse
        $page.first().toggleClass settings.disabledClass, page == 1
      lfirst = $page.first()
      if settings.firstLastUse
        lfirst = lfirst.next()
      lfirst.toggleClass(settings.disabledClass, page == 1).attr('data-lp', lp).find('a').attr 'href', href(lp)
      step = if settings.maxVisible == 1 then 0 else 1
      lp = if page + 1 > settings.total then settings.total else if settings.leaps and page + 1 < settings.total - (settings.maxVisible) then vis + settings.maxVisible + step else page + 1
      llast = $page.last()
      if settings.firstLastUse
        llast = llast.prev()
      llast.toggleClass(settings.disabledClass, page == settings.total).attr('data-lp', lp).find('a').attr 'href', href(lp)
      $page.last().toggleClass settings.disabledClass, page == settings.total
      $currPage = $page.filter('[data-lp=' + page + ']')
      clist = '.' + [
        settings.nextClass
        settings.prevClass
        settings.firstClass
        settings.lastClass
      ].join(',.')
      if !$currPage.not(clist).length
        d = if page <= vis then -settings.maxVisible else 0
        $page.not(clist).each (index) ->
          lp = index + 1 + vis + d
          $(this).attr('data-lp', lp).toggle(lp <= settings.total).find('a').html(lp).attr 'href', href(lp)
          return
        $currPage = $page.filter('[data-lp=' + page + ']')
      $currPage.not(clist).addClass settings.activeClass
      $owner.data 'settings', settings
      return

    href = (c) ->
      settings.href.replace settings.hrefVariable, c

    if settings.total <= 0
      return this
    if !$.isNumeric(settings.maxVisible) and !settings.maxVisible
      settings.maxVisible = parseInt(settings.total, 10)
    $owner.data 'settings', settings
    @each ->
      $pagin = undefined
      lp = undefined
      me = $(this)
      p = [
        '<ul class="'
        settings.wrapClass
        ' pagin">'
      ]
      if settings.firstLastUse
        p = p.concat([
          '<li data-lp="1" class="'
          settings.firstClass
          '"><a href="'
          href(1)
          '">'
          settings.first
          '</a></li>'
        ])
      if settings.prev
        p = p.concat([
          '<li data-lp="1" class="'
          settings.prevClass
          '"><a href="'
          href(1)
          '">'
          settings.prev
          '</a></li>'
        ])
      c = 1
      while c <= Math.min(settings.total, settings.maxVisible)
        p = p.concat([
          '<li data-lp="'
          c
          '"><a href="'
          href(c)
          '">'
          c
          '</a></li>'
        ])
        c++
      if settings.next
        lp = if settings.leaps and settings.total > settings.maxVisible then Math.min(settings.maxVisible + 1, settings.total) else 2
        p = p.concat([
          '<li data-lp="'
          lp
          '" class="'
          settings.nextClass
          '"><a href="'
          href(lp)
          '">'
          settings.next
          '</a></li>'
        ])
      if settings.firstLastUse
        p = p.concat([
          '<li data-lp="'
          settings.total
          '" class="last"><a href="'
          href(settings.total)
          '">'
          settings.last
          '</a></li>'
        ])
      p.push '</ul>'
      me.find('ul.pagin').remove()
      me.append p.join('')
      $pagin = me.find('ul.pagin')
      me.find('li').click ->
        `var me`
        me = $(this)
        if me.hasClass(settings.disabledClass) or me.hasClass(settings.activeClass)
          return
        page = parseInt(me.attr('data-lp'), 10)
        $owner.find('ul.pagin').each ->
          renderPage $(this), page
          return
        $owner.trigger 'page', page
        return
      renderPage $pagin, settings.page
      return

  return
) jQuery, window