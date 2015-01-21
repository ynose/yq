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

  # グラフを4月から順にアニメーション表示する
  monthAnimate = (hourMax) ->
  	m = -1
  	$('#bymonth .inner').each (i) ->
    	hour = $(this).data('hour')
    	if hour > 0
    		m++
    		$(this).delay(120 * m).animate
      		height: (((hour / hourMax) * 40)) + "px"
    		, 1000, "easeInOutBack"
    		# 数値はグラフよりも少し遅れて表示させる
    		$(this).prev('.hour').delay((120 * m) + 700).fadeIn(350)
      return
    return

		# ロード時にグラフ表示を実行する
		monthAnimate(48)


  # 一定周期でグラフ表示のアニメーションを繰り返す
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
