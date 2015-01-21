# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# 上にスクロールしながらダッシュボードをフェードアウトする
$(document).ready ->
    remainHeight = 280
    scrollOut = 100
    fadeOut = 0.5
    $(window).on "scroll", ->
     	scrollTop = $(this).scrollTop()
    		if scrollOut < scrollTop
	        	$("#flick").css("opacity", 1 - ((scrollTop - scrollOut) / (remainHeight * fadeOut)))
      		else 
        		$("#flick").css("opacity", 1.0)
