/**
 * Created by jonybang on 06.03.16.
 */
//= require jquery_nested_form

$(function(){
    var main_container = ".img-multiupload";
    var img_container = ".img-container";
    var img_adder = "img-adder";

    var adderCount = 0;
    function bindFileInputChange() {
        $(main_container + ' input[type=file]').change(function(evt){
            var $file = $(this);
            var $container = $(this).closest(main_container);
            var $img = $container.find(img_container + ' img');

            var imageLoaded = false;

            var files = evt.target.files; // FileList object

            var imagesCount = 0;

            // Loop through the FileList and render image files as thumbnails.
            for (var i = 0, f; f = files[i]; i++) {

                // Only process image files.
                if (!f.type.match('image.*')) {
                    continue;
                }

                var reader = new FileReader();

                imageLoaded = true;

                // Closure to capture the file information.
                reader.onload = (function(theFile) {
                    return function(e) {
                        // Render thumbnail.
                        var $cur_img = null;

                        if(imagesCount + 1 <= $img.length){
                            $cur_img = $($img[imagesCount]);
                        } else {
                            $cur_img = $img.clone();
                            $cur_img.appendTo($container.find(img_container));
                        }

                        if($cur_img){
                            $cur_img
                                .attr('src', e.target.result)
                                .attr('title', theFile.name);
                        }
                        imagesCount++;
                        $container.addClass('uploaded');
                        addIfAdder();
                    };
                })(f);

                // Read in the image file as a data URL.
                reader.readAsDataURL(f);
            }

            function addIfAdder(){
                if($file.hasClass(img_adder)){
                    if(!adderCount)
                        adderCount = parseInt($container.attr('data-count')) || 0;

                    var max = parseInt($container.attr('data-max'));

                    adderCount++;
                    if(!max || max > adderCount){
                        $container
                            .clone()
                            .insertAfter($container)
                            .find('img')
                            .attr('src', '');

                        bindFileInputChange();
                    }
                    $file.removeClass(img_adder);
                }

                if(imageLoaded){
                    var $form = $container.closest('form');
                    var $submit = $form.find('[type=submit]');
                    $submit.show();
                }

                optionalOperations ();
            }

            function optionalOperations (){
                if($container.attr('data-number-name')){
                    var name = $file.attr('name');
                    $file.attr('name', name.replace( /\[\]/g, "[" + (adderCount-1) + "]"));
                }

                var text = $container.attr('data-change-file-text');
                if(text){
                    $file.attr('title', text);
                    $container.find('.file-input-wrapper span').text(text);
                }
            }
        });
    }
    bindFileInputChange();
    $(document).on('nested:fieldAdded', function(event){
        bindFileInputChange();
    });
});
