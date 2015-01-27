# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	# 上にスクロールしながらダッシュボードをフェードアウトする
  remainHeight = 280
  scrollOut = 100
  fadeOut = 0.5
  $(window).on "scroll", ->
   	scrollTop = $(this).scrollTop()
  		if scrollOut < scrollTop
        $("#flick").css("opacity", 1 - ((scrollTop - scrollOut) / (remainHeight * fadeOut)))
    	else 
    		$("#flick").css("opacity", 1.0)
    return


  # 一定周期でグラフ表示のアニメーションを繰り返す
  clearInterval repeatMonthAnimate
  repeatMonthAnimate = setInterval ->
    $('#bymonth .inner').each (i) ->
    	if $(this).data('hour') > 0
    		$(this).delay(120 * i).animate 
      		height: "+=10px"
     		, 400, "easeInOutQuad", ->
      		$(this).prev('.hour').animate 
      			height: "+=2px"
       		, 400, "easeInOutQuad", ->
      		  $(this).animate 
        	    height: "-=5px"
            , 300, "easeInOutQuad", ->
              $(this).css height: "+=3px"
              return
            return
        $(this).animate 
          height: "-=10px"
          , 1000, "easeInOutCirc"
        return
      return
    return
  	, 10000 # 繰り返し秒数
  	return

###
  HTMLから呼び出せるようにclassで定義する
###
class @ByMonth
  _graphHeight = 40 # 棒グラフの最大高さ
  _hourMax = null

  constructor: (hourMax) ->
    _hourMax = hourMax
    # 棒グラフを表示するために必要な高さを設定する
    # 時間数の高さ + アニメーション時の高さ増分(12)) + 棒グラフの最大高さ
    $('#bymonth .outer').css height: ($('#bymonth .hour').height() + 12 + _graphHeight) + "px"
    # 高さの取得が終わったら非表示にする
    $('#bymonth .hour').hide()  

  # グラフを4月から順にアニメーション表示する
  showMonth: ->
  	m = -1
  	$('#bymonth .inner').each (i) ->
    	hour = $(this).data('hour')
    	if hour > 0
    		m++; delay = 120 * m
    		$(this).delay(delay).animate
      		height: (((hour / _hourMax) * _graphHeight)) + "px"
    		, 1000, "easeInOutBack"
    		# 数値はグラフよりも少し遅れて(delay + α)表示させる
    		$(this).prev('.hour').delay(delay + 700).fadeIn(350)
      return
    return


class @Flick
  setting: (fl, indelm, indimg) ->
    fl.flickSimple(
    	snap: 'first'
    	, onResize: ->
    		# update indicator
    		indelm.css width: (this.pageLength * 13) + 'px'
      return
    	, onChange: ->
    		# move indicator
        pos = (this.page - 1) * 13
      		if this.android or ! this.webkit
      			indimg.css left: pos + 'px'
      		else
            indimg.css webkitTransform: 'translate3d(' + pos + 'px,0,0)'
        return
      , onClick: (elm) ->
        elm.fadeOut('fast').fadeIn('fast').fadeOut('fast').fadeIn('fast')
        return
    )
    return

@flick = new Flick()
# HTMLからはflick.setting()のように呼び出す
