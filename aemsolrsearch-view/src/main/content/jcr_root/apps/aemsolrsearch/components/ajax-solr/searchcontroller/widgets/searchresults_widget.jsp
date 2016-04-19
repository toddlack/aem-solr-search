<%@ include file="/apps/aemsolrsearch/components/global.jspx" %>
<%@ taglib prefix="cqsearch" uri="http://aemsolrsearch.headwire.com/taglibs/aemsolrsearch-taglib" %>

<%--
  | Note: If you wish to extend this JSP, only include valid JavaScript in the response, as this
  |       JSP is included by searchcontroller.jsp.
  --%>

<c:if test="${resultsEnabled}">

    AjaxSolr.ResultWidget = AjaxSolr.AbstractWidget.extend({
      start: 0,

      beforeRequest: function () {
        $(this.target).html($('<img>').attr('src', '/etc/clientlibs/aemsolrsearch/ajax-solr/images/ajax-loader.gif'));
      },

      facetLinks: function (facet_field, facet_values) {
        var links = [];
        if (facet_values) {
          for (var i = 0, l = facet_values.length; i < l; i++) {
            if (facet_values[i] !== undefined) {
              links.push(
                $('<a href="#"></a>')
                .text(facet_values[i])
                .click(this.facetHandler(facet_field, facet_values[i]))
              );
            }
            else {
              links.push('no items found in current selection');
            }
          }
        }
        return links;
      },

      facetHandler: function (facet_field, facet_value) {
        var self = this;
        return function () {
          self.manager.store.remove('fq');
          self.manager.store.addByValue('fq', facet_field + ':' + AjaxSolr.Parameter.escapeValue(facet_value));
          self.doRequest();
          return false;
        };
      },

      afterRequest: function () {
        $(this.target).empty();
        for (var i = 0, l = this.manager.response.response.docs.length; i < l; i++) {
          var doc = this.manager.response.response.docs[i];
          $(this.target).append(this.template(doc));

        }
      },

      template: function (doc) {

        var snippet = '';
        var teaserField = '${resultsContentField}';
        var titleField = '${resultsTitleField}';
        var idField = 'id';
        var postContentField='${resultsPostContentField}';

        var postContentVal=doc[postContentField];
        var teaserVal= doc[teaserField];
        var idVal = doc[idField];
        if( typeof teaserVal != 'undefined') {
            var displayVal=teaserVal;
            if (Array.isArray(teaserVal)) {
                displayVal=teaserVal[0];
            }
            if(displayVal.length > 250)
            {
                snippet += displayVal.trim().substring(0, 250);
                snippet += '<span style="display:none">' + displayVal.substring(250);
                snippet += '</span> <a href="#" class="more">more</a>';
            }
            else
            {
                if (typeof displayVal === "string") {
                    snippet += displayVal.trim();
                } else {
                    snippet += displayVal;
                }
            }
        }

        var title = doc[titleField];
        var output = '';

        var highlights = this.manager.response.highlighting;
        if(highlights && highlights[idVal]) {

            if(highlights[idVal][teaserField]) {
                var teaserSnippet = highlights[idVal][teaserField][0];

                if (teaserSnippet.length > 250) {
                    snippet = teaserSnippet.substring(0, 250);
                    snippet += '<span style="display:none">' + teaserSnippet.substring(250);
                    snippet += '</span> <a href="#" class="more">more</a>';
                } else {
                    snippet = teaserSnippet;
                }
            }
        }

        output += '<div class="result-card">';
        output += '<a href="' + idVal + '" class="result-title">' + title + '</a>';
        output += '<div class="result-url">' + idVal + '</div>';
        output += '<div class="result-text">' + snippet + '</div>';
        if (typeof postContentVal != 'undefined' ) {
            output += '<div class="result-post-text">'+ postContentVal +'</div>';
        }
        output += '</div>';


        return output;
      },

      init: function () {
        $(document).on('click', 'a.more', function () {
          var $this = $(this),
              span = $this.parent().find('span');

          if (span.is(':visible')) {
            span.hide();
            $this.text('more');
          }
          else {
            span.show();
            $this.text('less');
          }

          return false;
        });
      }
    });

    Manager.addWidget(new AjaxSolr.ResultWidget({
      id: '${resultsId}',
      target: '${resultsTarget}'
    }));
</c:if>
