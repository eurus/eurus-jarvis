# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if (typeof marked != 'undefined')
    renderer = new marked.Renderer()
    renderer.table = (header, body) =>
      return '<table class="table table-striped table-hover">\n'+ '<thead>\n'+ header + '</thead>\n'+ '<tbody>\n'+ body + '</tbody>\n'+ '</table>\n';

    renderer.image = (href, title, text) =>
      out = '<img class="img-responsive" src="' + href + '" alt="' + text + '"'
      if (title)
        out += ' title="' + title + '"'
      out += '></img>'
      return out


    initMarkdown = =>
      md = $('.markdown-src').val()
      html = marked(md, { renderer: renderer })
      $('.markdown-dist').html(html)
      $('#artical_content_html').val(html);

    initMarkdown()

  console.log('hey yo');
  search = =>
    alert 'hey'
    text = $('#artical-search-input').val();
    window.location.href="/articals?search="+text;

  $('#artical-search-btn').click search

  $('#artical-search-input').click (e)=>
    if (e.which == 13 || e.keyCode == 13)
      search()

  $('.markdown-src').keyup initMarkdown
