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
        $('#submit_cart').attr('disabled', 'disabled')
      error: (a, b, c) ->
        alert('Sorry there was an error, please try again')
  
  $('body').on "click", '.remove-cart-item', (e) ->
    e.preventDefault()
    item = $(this).data('id')
    cart = $(this).data('cart')
    $.ajax
      url: '/shopping_carts/'+cart+'/shopping_cart_items/'+item
      dataType: 'json'
      type: 'delete'
      success: (data) ->
        $('.cart_list_item-'+item).remove()
        if $('.cart_list_item').length == 0
          $('#submit_cart').attr('disabled', 'disabled')
        
  $( "#tabs" ).tabs()
  $('body').on "click", '.add_to_cart_no_user', (e) ->
    e.preventDefault();
    $( "#dialog" ).dialog({ position: { my: "center top", at: "center top", of: "#bd_prod" } })

  $('body').on "click", ".add_to_cart", (e) ->
    e.preventDefault()
    user = $(this).data('userid')
    item = $(this).data('itemid')
    cart = $(this).data('cartid')
    title = $(this).data('title')
    thing = $(this)
    if cart
      $.ajax
        url: '/shopping_carts/'+cart
        dataType: 'json'
        type: 'put'
        data: 
          shopping_cart:
            shopping_cart_items_attributes:
              [solr_document_id: item, title: title]
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
              [solr_document_id: item, title: title]
        success: (data) ->
          console.log(data)
          thing.after('<span style="position: absolute;right: 0;">Added to cart!</span>')
          thing.remove()
        