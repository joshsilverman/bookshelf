autocompleter =
  build: ->
    $("#book_title" ).autocomplete 
      source: autocompleter.source,
      select: autocompleter.select
    window.updateISSCompletion = this.callback  
    
  callback: => 
    @response completion[1]
    
  source: (request, response) =>
    title = encodeURI $('#book_title')[0].value
    script_tag = "<script src='http://t1-completion.amazon.com/search/complete?method=completion&q=#{title}&search-alias=stripbooks&client=amazon-search-ui&mkt=1&x=updateISSCompletion&sc=1&conf=1&noCacheIE=1322188166532'></script>"
    $('head').append script_tag
    @response = response
    
  select: (e,item) ->
    window.item = item
    item = item.item.value.replace /\s/g, "+"
    $.get(
      "/books/lookup/#{item}",
      (text) -> 
        $('.amzn-results').append text
        
        $('#book_title')[0].value = $('.amzn-results #result_0 .title a')[0].innerHTML
        $('#book_cover_url')[0].value = $('.amzn-results #result_0 img')[0].src.match(/(^[\w\W]*\/images\/I\/[^\.]*)/)[1] + ".jpg"
        $('#book_author')[0].value = $('.amzn-results #result_0 div.title .ptBrand')[0].innerHTML.replace(/<[^>]*>/g, "").replace(/^by /, "")
        $('#book_isbn')[0].value =  $('.amzn-results #result_0 .title a')[0].href.match(/dp\/([^\/]*)\//)[1]
    )

contentflow =
  build: ->
    @widget = new ContentFlow('contentFlow', {
      reflectionColor: "#000000",
      onMakeActive: @onMakeActive
      }
    )
    
    #edit modal
    $('.edit_book').dialog(
      height:380,
      width:400,
      modal:true,
      autoOpen:false
    )
    
#    $('.ui-icon').hover -> $(this).addClass "ui-state-hover" , -> $(this).removeClass "ui-state-hover" 
    $('.ui-icon-pencil').click this.onEditItem
    
  onMakeActive: (element) -> 
    console.log element
    
  onEditItem: (e) ->
    item = $(this).parent().parent().parent()
    $('#book_author')[0].value = item.attr "book_author"
    $('#book_title')[0].value = item.attr "book_title"
    $('#book_isbn')[0].value = item.attr "book_isbn"
    $('#book_cover_url')[0].value = item.attr "book_cover_url"
    
    $('.edit_book')[0].action = "books/#{item.attr 'book_id'}"
    $('.edit_book')[0].id = "edit_book_#{item.attr 'book_id'}"
    
    $('.edit_book').dialog "open"
    

$(document).ready -> 
  autocompleter.build() if $("#book_title")
  contentflow.build() #if $("#book_title")