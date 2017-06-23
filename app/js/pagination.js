(function($, window) {

    $.fn.pagin = function(options){

        var $owner = this,
            settings = $.extend({
                total: 0,
                page: 1,
                maxVisible: null,
                leaps: true,
                href: '#page-${number}',
                hrefVariable: '${number}',
                next: '&raquo;',
                prev: '&laquo;',
				firstLastUse: false,
                first: '<span aria-hidden="true">&larr;</span>',
                last: '<span aria-hidden="true">&rarr;</span>',
                wrapClass: 'pagination',
                activeClass: 'active',
                disabledClass: 'disabled',
                nextClass: 'next',
                prevClass: 'prev',
		        lastClass: 'last',
                firstClass: 'first'
            },
            $owner.data('settings') || {},
            options || {});

        if(settings.total <= 0)
            return this;

          if(!$.isNumeric(settings.maxVisible) && !settings.maxVisible){
            settings.maxVisible = parseInt(settings.total, 10);
        }

        $owner.data('settings', settings);

        function renderPage($pagin, page){

            page = parseInt(page, 10);
            var lp,
                maxV = settings.maxVisible == 0 ? 1 : settings.maxVisible,
                step = settings.maxVisible == 1 ? 0 : 1,
                vis = Math.floor((page - 1) / maxV) * maxV,
                $page = $pagin.find('li');
            settings.page = page = page < 0 ? 0 : page > settings.total ? settings.total : page;
            $page.removeClass(settings.activeClass);
            lp = page - 1 < 1 ? 1 :
                    settings.leaps && page - 1 >= settings.maxVisible ?
                        Math.floor((page - 1) / maxV) * maxV : page - 1;

			if(settings.firstLastUse) {
				$page
					.first()
					.toggleClass(settings.disabledClass, page === 1);
			}

			var lfirst = $page.first();
			if(settings.firstLastUse) {
				lfirst = lfirst.next();
			}

			lfirst
                .toggleClass(settings.disabledClass, page === 1)
                .attr('data-lp', lp)
                .find('a').attr('href', href(lp));

            var step = settings.maxVisible == 1 ? 0 : 1;

            lp = page + 1 > settings.total ? settings.total :
                    settings.leaps && page + 1 < settings.total - settings.maxVisible ?
                        vis + settings.maxVisible + step: page + 1;

			var llast = $page.last();
			if(settings.firstLastUse) {
				llast = llast.prev();
			}

			llast
                .toggleClass(settings.disabledClass, page === settings.total)
                .attr('data-lp', lp)
                .find('a').attr('href', href(lp));

			$page
				.last()
				.toggleClass(settings.disabledClass, page === settings.total);


            var $currPage = $page.filter('[data-lp='+page+']');

			var clist = "." + [settings.nextClass,
							   settings.prevClass,
                               settings.firstClass,
                               settings.lastClass].join(",.");
            if(!$currPage.not(clist).length){
                var d = page <= vis ? -settings.maxVisible : 0;
                $page.not(clist).each(function(index){
                    lp = index + 1 + vis + d;
                    $(this)
                        .attr('data-lp', lp)
                        .toggle(lp <= settings.total)
                        .find('a').html(lp).attr('href', href(lp));
                });
                $currPage = $page.filter('[data-lp='+page+']');
            }
            $currPage.not(clist).addClass(settings.activeClass);
            $owner.data('settings', settings);
        }

        function href(c){

            return settings.href.replace(settings.hrefVariable, c);
        }

        return this.each(function(){

            var $pagin, lp, me = $(this),
                p = ['<ul class="', settings.wrapClass, ' pagin">'];

            if(settings.firstLastUse){
                p = p.concat(['<li data-lp="1" class="', settings.firstClass,
                       '"><a id="'href(1)'" href="', href(1), '">', settings.first, '</a></li>']);
            }
            if(settings.prev){
                p = p.concat(['<li data-lp="1" class="', settings.prevClass,
                       '"><a id="'href(1)'" href="', href(1), '">', settings.prev, '</a></li>']);
            }
            for(var c = 1; c <= Math.min(settings.total, settings.maxVisible); c++){
                p = p.concat(['<li data-lp="', c, '"><a id="" href="', href(c), '">', c, '</a></li>']);
            }
            if(settings.next){
                lp = settings.leaps && settings.total > settings.maxVisible
                    ? Math.min(settings.maxVisible + 1, settings.total) : 2;
                p = p.concat(['<li data-lp="', lp, '" class="',
                             settings.nextClass, '"><a id="'href(lp)'" href="', href(lp),
                             '">', settings.next, '</a></li>']);
            }
            if(settings.firstLastUse){
                p = p.concat(['<li data-lp="', settings.total, '" class="last"><a id="'href(settings.total'" href="',
                             href(settings.total),'">', settings.last, '</a></li>']);
            }
            p.push('</ul>');
            me.find('ul.pagin').remove();
            me.append(p.join(''));
            $pagin = me.find('ul.pagin');

            me.find('li').click(function paginationClick(){

                var me = $(this);
                if(me.hasClass(settings.disabledClass) || me.hasClass(settings.activeClass)){
                    return;
                }
                var page = parseInt(me.attr('data-lp'), 10);
                $owner.find('ul.pagin').each(function(){
                    renderPage($(this), page);
                });

                $owner.trigger('page', page);
            });
            renderPage($pagin, settings.page);
        });
    }

})(jQuery, window);