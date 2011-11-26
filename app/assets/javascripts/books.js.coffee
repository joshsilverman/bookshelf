class Autocompleter
  constructor: (searchable) ->
    @searchable = searchable
    @searchable.find("#book_title").autocomplete 
#      source: @source.bind(this),
#      select: @select.bind(this)
    window.updateISSCompletion = this.callback.bind(this)
    
  callback: -> 
    @response completion[1]
    
#  source: (request, response) ->
#    title = encodeURI @searchable.find("#book_title")[0].value
#    script_tag = "<script src='http://t1-completion.amazon.com/search/complete?method=completion&q=#{title}&search-alias=stripbooks&client=amazon-search-ui&mkt=1&x=updateISSCompletion&sc=1&conf=1&noCacheIE=1322188166532'></script>"
#    $('head').append script_tag
#    @response = response
#    
#  select: (e,item) ->
#    window.item = item
#    item = item.item.value.replace /\s/g, "+"
#    $.get(
#      "/books/lookup/#{item}",
#      (text) => 
#        $('.amzn-results').html text
        
#        @searchable.find('#book_title')[0].value = $('.amzn-results #result_0 .title a')[0].innerHTML
#        @searchable.find('#book_cover_url')[0].value = $('.amzn-results #result_0 img')[0].src.match(/(^[\w\W]*\/images\/I\/[^\.]*)/)[1] + ".jpg"
#        @searchable.find('#book_author')[0].value = $('.amzn-results #result_0 div.title .ptBrand')[0].innerHTML.replace(/<[^>]*>/g, "").replace(/^by /, "")
#        @searchable.find('#book_isbn')[0].value =  $('.amzn-results #result_0 .title a')[0].href.match(/dp\/([^\/]*)\//)[1]
    )

class Contentflow
  constructor: ->
    @widget = new ContentFlow('contentFlow',
      reflectionColor: "#000000"
      circularFlow: false
      startItem: "last"
    )
    
    #edit/new modals
    $('.edit_book, .new_book').dialog(
      height:380,
      width:400,
      modal:true,
      autoOpen:false
    )
    
    #new and edit listeners
#    $('.ui-icon-pencil').click this.onEditItem
#    $('button.new').click this.onNewItem
#    
#  onEditItem: (e) ->
#    item = $(this).parent().parent().parent()
#    $('.edit_book #book_author')[0].value = item.attr "book_author"
#    $('.edit_book #book_title')[0].value = item.attr "book_title"
#    $('.edit_book #book_isbn')[0].value = item.attr "book_isbn"
#    $('.edit_book #book_cover_url')[0].value = item.attr "book_cover_url"
#    
#    $('.edit_book')[0].action = "books/#{item.attr 'book_id'}"
#    $('.edit_book')[0].id = "edit_book_#{item.attr 'book_id'}"
#    
#    new Autocompleter $(".edit_book")
#    $('.edit_book').dialog "open"
#    
#  onNewItem: ->
#    $('.new_book #book_author')[0].value = ""
#    $('.new_book #book_title')[0].value = ""
#    $('.new_book #book_isbn')[0].value = ""
#    $('.new_book #book_cover_url')[0].value = ""
#    
#    new Autocompleter $(".new_book")
#    $('.new_book').dialog "open"

$(document).ready ->
  new Contentflow