var $ = require('jquery');
var bootbox = require('bootbox');

$(document).ready(function() {

        $('#figshareAddKey').on('click', function() {
                window.location.href = '/api/v1/settings/figshare/oauth/';
        });

        $('#figshareDelKey').on('click', function() {
            bootbox.confirm({
                title: 'Remove access key?',
                message: 'Are you sure you want to remove your figshare access key? This will ' +
                        'revoke access to figshare for all projects you have authorized.',
                callback: function(result) {
                    if(result) {
                        $.ajax({
                            url: '/api/v1/settings/figshare/oauth/',
                            type: 'DELETE',
                            contentType: 'application/json',
                            dataType: 'json',
                            success: function() {
                                window.location.reload();
                            }
                        });
                    }
                },
                buttons:{
                    confirm:{
                        label:'Delete',
                        className:'btn-danger'
                    }
                }
            });
        });
    });