/*
  Copyright (c) 2009 Open Lab, http://www.open-lab.com/
  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/* Example:
  
  var tags=[
        {tag:"js",freq:30},{tag:"jquery",freq:25}, {tag:"pojo",freq:10},{tag:"agile",freq:4},
        {tag:"blog",freq:3},{tag:"canvas",freq:8}, {tag:"dialog",freq:3},{tag:"excel",freq:4},
        {tag:"engine",freq:5},{tag:"flex",freq:18}, {tag:"firefox",freq:23},{tag:"javascript",freq:40},
        {tag:"graph",freq:15},{tag:"grid",freq:20}, {tag:"hibernate",freq:13},{tag:"ical",freq:4},
        {tag:"ldap",freq:9},{tag:"load",freq:20}, {tag:"security",freq:13},{tag:"XSS",freq:21},
        {tag:"CSRF",freq:19},{tag:"html",freq:22}, {tag:"xml",freq:13},{tag:"tools",freq:21}
      ]

  $(function(){
    $("#tag").tagField({
      tags:tags,
      //jsonUrl:"tags.json",
      sortBy:"frequency",
      suggestedTags:["jquery","tagging","tag","component","delicious","javascript"],
      tagSeparator:" ",
      autoFilter:true,
      autoStart:false,
      //suggestedTagsPlaceHolder:$("#suggested"),
      boldify:true

    })
  });
*/

jQuery.fn.tagField = function(options) {

/**
   * options.tags an object array [{tag:"tag1",freq:1},{tag:"tag2",freq:2}, {tag:"tag3",freq:3},{tag:"tag4",freq:4} ].
   * options.jsonUrl an url returning a json object array in the same format of options.tag. The url will be called with
   *                              "search" parameter to be used server side to filter results
   * option.autoFilter true/false  default=true when active show only matching tags, "false" should be used for server-side filtering
   * option.autoStart true/false  default=false when active dropdown will appear entering field, otherwise when typing
   * options.sortBy "frequency"|"tag"|"none"  default="tag"
   * options.tagSeparator default="," any separator char as space, comma, semicolumn
   * options.boldify true/false default trrue boldify the matching part of tag in dropdown
   *
   * options.suggestedTags callback an object array like ["sugtag1","sugtag2","sugtag3"] 
   * options.suggestedTagsPlaceHolder  jquery proxy for suggested tag placeholder. When placeholder is supplied (hence unique), tagField should be applied on a single input
   *                          (something like  $("#myTagFiled").tagField(...) will works fine: $(":text").tagField(...) probably not!)
   */

  // --------------------------  start default option values --------------------------
  if (!options.tags && !options.jsonUrl) {
    options.tags = [ { tag:"tag1", freq:1 }, { tag:"tag2", freq:2 }, { tag:"tag3", freq:3 }, { tag:"tag4", freq:4 } ];    
  }

  if (typeof(options.tagSeparator) == "undefined")
    options.tagSeparator = ",";

  if (typeof(options.autoFilter) == "undefined")
    options.autoFilter = true;

  if (typeof(options.autoStart) == "undefined")
    options.autoStart = false;

  if (typeof(options.boldify) == "undefined")
    options.boldify = true;

  if (typeof(options.sortBy) == "undefined")
    options.sortBy = "tag";

  // --------------------------  end default option values --------------------------


  this.each(function() {

    var theInput = $(this);
    var theDiv;
    theInput.addClass("tagBox");
    theInput.tagOptions=options;

    var suggestedTagsPlaceHolder=options.suggestedTagsPlaceHolder;
    //create suggested tags place if the case
    if (options.suggestedTags){
      if (!suggestedTagsPlaceHolder){
        //create a placeholder
        var stl=$("<div class='tagBoxSuggestedTags'><span class='label'>suggested tags: </span><span class='tabBoxSuggestedTagList'></span></div>");
        suggestedTagsPlaceHolder=stl.find(".tabBoxSuggestedTagList");
        theInput.after(stl);
      }

      //fill with suggestions
      for (var tag in options.suggestedTags) {
        suggestedTagsPlaceHolder.append($("<span class='tag'>" + options.suggestedTags[tag] + "</span>"));
      }

      // bind click on suggestion tags
      suggestedTagsPlaceHolder.find(".tag").click(function(e) {
        var element = $(this);
        var val = theInput.val();
        var tag = element.text();

        //check if already present
        var re = new RegExp(tag + "\\b");
        if (containsTag(val, tag)) {
          val = val.replace(re, ""); //remove the tag
          element.removeClass("tagUsed");
        } else {
          val = val + options.tagSeparator + tag;
          element.addClass("tagUsed");
        }
        theInput.val(refurbishTags(val));

      });


    }


    // --------------------------  INPUT FOCUS --------------------------
    var tagBoxFocus = function (e) {
      theDiv = $("#__tagBoxDiv");
      // check if the result box exists
      if (theDiv.size() <= 0) {
        //create the div
        theDiv = $("<div id='__tagBoxDiv' class='tbDiv' style='width:" + theInput.get(0).clientWidth + ";display:none; '></div>");
        theInput.after(theDiv);
        theDiv.css({left:theInput.position().left});
      }
      if (options.autoStart)
        tagBoxRefreshDiv(theInput, theDiv);
    }


    // --------------------------  INPUT BLUR --------------------------
    var tagBoxBlur = function (e) {
      // reformat string
      theDiv = $("#__tagBoxDiv");
      theInput.val(refurbishTags(theInput.val()));

      theDiv.fadeOut(200, function() {
        theDiv.remove();
      });
    }


    // --------------------------  INPUT KEYBOARD --------------------------
    var tagBoxKey = function (e) {
      var rows = theDiv.find("div.tagBoxLine");
      var rowNum = rows.index(theDiv.find("div.tagBoxSel"));

      var ret = true;
      switch (e.which) {
        case 38: //up arrow
          rowNum = (rowNum < 1 ? 0 : rowNum - 1 );
          tagBoxHLSCR(rows.eq(rowNum), true);
          break;

        case 40: //down arrow
          rowNum = (rowNum < rows.size() - 1 ? rowNum + 1 : rows.size() - 1 );
          tagBoxHLSCR(rows.eq(rowNum), false)
          break;

        case 13: //enter
          var theRow = rows.eq(rowNum);
          tagBoxClickRow(theRow);
          ret = false;
          break;

        default:
          $().stopTime("tagBoxRefresh");
          $().oneTime(400, "tagBoxRefresh", function() {
            tagBoxRefreshDiv();
          })
          break;
      }
      return ret;
    }


    // --------------------------  TAG DIV HIGHLIGHT AND SCROLL --------------------------
    var tagBoxHLSCR = function(theRowJQ, isUp) {
      if (theRowJQ.size() > 0) {
        var div = theDiv.get(0);
        var theRow = theRowJQ.get(0)
        if (isUp) {
          if (theDiv.scrollTop() > theRow.offsetTop) {
            theDiv.scrollTop(theRow.offsetTop);
          }
        } else {
          if ((theRow.offsetTop + theRow.offsetHeight) > (div.scrollTop + div.offsetHeight)) {
            div.scrollTop = theRow.offsetTop + theRow.offsetHeight - div.offsetHeight;
          }
        }
        theDiv.find("div.tagBoxSel").removeClass("tagBoxSel");
        theRowJQ.addClass("tagBoxSel");
      }
    }


    // --------------------------  TAG LINE CLICK --------------------------
    var tagBoxClickRow = function(theRow) {
      var lastComma = theInput.val().lastIndexOf(options.tagSeparator);
      var newVal = (theInput.val().substr(0, lastComma + 1) + options.tagSeparator+ (options.tagSeparator==" "?"":" ") + theRow.find(".tagBoxLineTag").text()).trim();
      theInput.val(newVal);
      theRow.parent().remove();
      $().oneTime(200, function() {
        theInput.focus();
      });
    }


    // --------------------------  REFILL TAG BOX --------------------------
    var tagBoxRefreshDiv = function () {
      var lastComma = theInput.val().lastIndexOf(options.tagSeparator);
      var search = theInput.val().substr(lastComma + 1).trim();


      // --------------------------  FILLING THE DIV --------------------------
      var fillingCallbak = function(tags) {
        if (options.sortBy == "frequency") {
          tags = tags.sort(function (a, b) {
            if (a.freq < b.freq)
              return 1;
            if (a.freq > b.freq)
              return -1;
            return 0;
          });

        } else if (options.sortBy == "tag") {
          tags = tags.sort(function (a, b) {
            if (a.tag < b.tag)
              return -1;
            if (a.tag > b.tag)
              return 1;
            return 0;
          });
        }

        for (var i in tags) {
          var el = tags[i];
          var matches = el.tag.toLocaleLowerCase().indexOf(search.toLocaleLowerCase()) == 0;
          if (!options.autoFilter || matches) {
            var line = $("<div class='tagBoxLine'></div>");
            var tag = el.tag;
            if (options.boldify && matches) {
              tag = "<b>" + tag.substring(0, search.length) + "</b>" + tag.substring(search.length);
            }

            line.append("<div class='tagBoxLineTag'>" + tag + "</div>");
            if (el.freq)
              line.append("<div class='tagBoxLineFreq'>" + el.freq + "</div>");
            theDiv.append(line);
          }
        }

        theDiv.fadeIn();
        theDiv.find("div:first").addClass("tagBoxSel");
        theDiv.find("div.tagBoxLine").bind("click", function() {
          tagBoxClickRow($(this));
        });
      }


      if (search != "" || options.autoStart) {
        theDiv.html("");

        if (options.tags)
          fillingCallbak(options.tags);
        else{
          var data = {search:search};
          $.getJSON(options.jsonUrl, data, fillingCallbak );
        }
      }
    }

    // --------------------------  CLEAN THE TAG LIST FROM EXTRA SPACES, DOUBLE COMMAS ETC. --------------------------
    var refurbishTags = function (tagString) {
      var splitted = tagString.split(options.tagSeparator);
      var res = "";
      var first = true;
      for (var i = 0; i < splitted.length; i++) {
        if (splitted[i].trim() != "") {
          if (first) {
            first = false;
            res = res + splitted[i].trim();
          } else {
            res = res + options.tagSeparator+ (options.tagSeparator==" "?"":" ") + splitted[i].trim();
          }
        }
      }
      return( res);
    }

    // --------------------------  TEST IF TAG IS PRESENT --------------------------
    var containsTag=function (tagString,tag){
      var splitted = tagString.split(options.tagSeparator);
      var res="";
      var found=false;
      tag=tag.trim();
      for(i = 0; i < splitted.length; i++){
        var testTag=splitted[i].trim();
        if (testTag==tag){
          found=true;
          break;
        }
      }
      return found;
    }


    // --------------------------  SELECT TAGS BASING ON USER INPUT --------------------------
    var delayedSelectTagFromInput= function(){
      var element = $(this);
      $().stopTime("suggTagRefresh");
      $().oneTime(400, "suggTagRefresh", function() {
        selectSuggTagFromInput();
      })

    }
    
    var selectSuggTagFromInput = function () {
      var val = theInput.val();
      suggestedTagsPlaceHolder.find(".tag").each(function(){
        var el = $(this);
        var tag=el.text();

        //check if already present
        if (containsTag(val,tag)) {
          el.addClass("tagUsed");
        } else {
          el.removeClass("tagUsed");
        }
      });

    }




    // --------------------------  INPUT BINDINGS --------------------------
    $(this).bind("focus", tagBoxFocus).bind("blur", tagBoxBlur).bind("keydown", tagBoxKey);
    if (options.suggestedTags)
      $(this).bind("keyup",delayedSelectTagFromInput) ;


  });
  return this;
}


