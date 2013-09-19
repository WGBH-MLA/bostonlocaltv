# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('body').on "click", "#submit_cart", (e) ->
    e.preventDefault()
    $.ajax
      url: '/submit_cart'
      success: (data) ->
        $('.cart_items').after('<p>Your request has been sent!</p>')
        $('.cart_items').remove()
      error: (a, b, c) ->
        console.log a
        console.log b
        console.log c
        
  $( "#tabs" ).tabs()
  $('body').on "click", ".add_to_cart", (e) ->
    e.preventDefault()
    user = $(this).data('userid')
    item = $(this).data('itemid')
    cart = $(this).data('cartid')
    thing = $(this)
    if cart
      $.ajax
        url: '/shopping_carts/'+cart
        dataType: 'json'
        type: 'put'
        data: 
          shopping_cart:
            shopping_cart_items_attributes:
              [solr_document_id: item]
        success: (data) ->
          console.log(data)
          thing.after('<span style="position: absolute;right: 0;">Added to cart!</span>')
          thing.remove()
    else
      $.ajax
        url: '/shopping_carts'
        dataType: 'json'
        type: 'post'
        data: 
          shopping_cart:
            user_id: user
            shopping_cart_items_attributes:
              [solr_document_id: item]
        success: (data) ->
          console.log(data)
          thing.after('<span style="position: absolute;right: 0;">Added to cart!</span>')
          thing.remove()
        