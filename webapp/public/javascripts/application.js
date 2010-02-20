// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.fn.showErrorsFromModal = function(req){
    $(this[0]).append(req);
    tb_remove();
}

jQuery.fn.updateHistoryFromModal = function(req){
    $(this[0]).append(req);
    tb_remove();    
}
