// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.js
//= require jquery_ujs
//= require lightbox.min
//= require slick.min
//= require turbolinks
//= require highlight.min.js
// require_tree .

var ready = function() {
    $('.blogo-article code').each(function(i, block) {
        //hljs.highlightAuto($(block).text(), ['javascript', 'php', 'ruby', 'html', 'css'])
        hljs.highlightBlock(block);
    });
    lightbox.option({
        'resizeDuration': 200,
        'wrapAround': true
    })

    $('.slick-slider').slick({
        dots: true,
        speed: 300,
        variableWidth: true,
        infinite: true,
        slidesToShow: 1,
        slidesToScroll: 1
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);