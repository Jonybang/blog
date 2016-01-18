//= require epiceditor
//= require tabIndent

$(function(){
    var editor = new EpicEditor({container: 'blogo-editor-container', textarea: 'blogo-editor'}).load(function () {
        $('#blogo-editor').hide();
    });
});
