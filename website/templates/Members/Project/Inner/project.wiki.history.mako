<%inherit file="project.view.mako" />
<div>
    <div style="width:200px; float:right; margin-left:30px;">
    <%include file="_wiki_status.mako" />
    <%include file="_wiki_history.mako" />
    History
    </div>
    ${content}
</div>