<%inherit file="base.mako"/>
<%def name="title()">Project</%def>


<%def name="content()">
  <div mod-meta='{"tpl": "project/project_header.mako", "replace": true}'></div>

  <div class="row">
    <div class="col-md-7" id='containment'>
      <section id="Wiki Home" class="preview-overflow">
        <div>
            ${ node["wiki_home"] }
            <p><a href="${node['url']}wiki/home">read more</a></p>
        </div>
      </section>
       %if node:
      <section id="Nodes">

          <div class="page-header">
            % if node["category"] == 'project':
              <div class="pull-right">
                  % if user["can_edit"]:
                  <a class="btn btn-default" data-toggle="modal" data-target="#newComponent">
                  % else:
                  <a class="btn btn-default disabled">
                  % endif
                    Add Component
                  </a>
              </div>
              <%include file="modal_add_component.mako"/>
            % endif
              <h1>Components</h1>
          </div>
          % if node["children"]:
              <div mod-meta='{
                      "tpl" : "util/render_nodes.mako",
                      "uri" : "${node["api_url"]}get_children/",
                      "replace" : true,
                      "kwargs" : {"sortable" : true}
                  }'></div>
          % else:
              <p>No components have been added to this project.</p>
          % endif

      </section>
      %endif
      <section id="Files">
        <div>
          <div class="page-header">
              <h1>Files</h1>
          </div>
          <div mod-meta='{
                  "tpl": "util/render_file_tree.mako",
                  "uri": "${node["api_url"]}get_files/",
                  "view_kwargs": {
                      "dash": true
                  },
                  "replace": true
              }'></div>
        </div>
      </section>
    </div>
    <div class="col-md-5">
        <input name="node-tags" id="node-tags" value="${','.join([tag for tag in node['tags']]) if node['tags'] else ''}" />
            <div id='logScope'>
                <%include file="log_list.mako"/>
            </div><!-- end #logScope -->
            ## Hide More widget until paging for logs is implemented
            ##<div class="paginate pull-right">more</div>
        </section>
    </div>
  </div>


##<!-- Include Knockout and view model -->
##<div mod-meta='{
##        "tpl": "metadata/knockout.mako",
##        "replace": true
##    }'></div>
##
##<!-- Render comments -->
##<div mod-meta='{
##        "tpl": "metadata/comment_group.mako",
##        "kwargs": {
##            "guid": "${node['id']}",
##            "top": true
##        },
##        "replace": true
##    }'></div>
##
##<!-- Boilerplate comment JS -->
##<div mod-meta='{
##        "tpl": "metadata/comment_js.mako",
##        "replace": true
##    }'></div>

</%def>

<%def name="javascript_bottom()">
<script>
    $(document).ready(function() {

        ### Tag Input ###

        $('#node-tags').tagsInput({
            width: "100%",
            interactive:${'true' if user["can_edit"] else 'false'},
            onAddTag:function(tag){
                $.ajax({
                    url:"${node['api_url']}" + "addtag/" + tag + "/",
                    type:"POST",
                    contentType: "application/json"
                });
            },
            onRemoveTag:function(tag){
                $.ajax({
                    url:"${node['api_url']}" + "removetag/" + tag + "/",
                    type:"POST",
                    contentType: "application/json"
                });
            },
        });
        % if not user["can_edit"]:
            // Remove delete UI if not contributor
            $('a[title="Removing tag"]').remove();
            $('span.tag span').each(function(idx, elm) {
                $(elm).text($(elm).text().replace(/\s*$/, ''))
            });
        % endif
    });
</script>
</%def>