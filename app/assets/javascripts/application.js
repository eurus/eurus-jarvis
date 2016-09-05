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
//= require sweet-alert
//= require jquery
//= require jquery_ujs
//= require sweet-alert-confirm
//= require turbolinks
//= require bootstrap-sprockets
//= require selectize
//= require bootstrap-datepicker
//= require bootstrap-datepicker.zh-CN
//= require summernote
//= require jquery.dataTables.min
//= require dataTables.bootstrap.min
//= require dataTables.buttons.min
//= require dataTables.scroller.min
//= require buttons.bootstrap.min
//= require buttons.flash.min
//= require buttons.html5.min
//= require buttons.print.min
//= require masonry/masonry.min
//= require moment
//= require bootstrap-tagsinput
//= require moment/zh-cn
//= require pace/pace
//= require_tree .


$(window).bind('page:change', function() {
    initPage();
});

function initPage() {
    initQiniu();
    $('.sidebar .list-group-item').click(function() {
        $(this).find('i.fa').remove();
        $(this).prepend('<i class="fa fa-spinner fa-spin fa-fw"></i>');
        return true;
    });
    $('#menu-toggle').click(function(e) {
        $('#wrapper').toggleClass('toggled');
    });

    $('.fromNow').each(function() {
        if ($(this).text().trim() != '') {
            $(this).text(moment($(this).text()).fromNow())
        }
    })

    var mc = $('.masonry-container');
    mc.masonry({
        columnWidth: '.item',
        itemSelector: '.item'
    })

    // $('.datepicker').datepicker({
    //   format: 'yyyy-mm-dd',
    //   autoclose:true,
    //   language:'zh-CN'
    // })

    $('.panel').fadeIn(1000);
    $('.panel').hover(function() {
        $(this).find('.actions').fadeIn(500);
    });
    $('.panel').mouseleave(function() {
        $(this).find('.actions').fadeOut(200);
    });

    // item
    $('.item').hover(function() {
        $(this).find('.actions').fadeIn(500);
    });
    $('.item').mouseleave(function() {
        $(this).find('.actions').fadeOut(200);
    });


    // tooltip
    $('[data-toggle="tooltip"]').tooltip();
    // end of tooltip

    // popover
    // $('[data-toggle="popover"]').popover({html:true})
    // end of popover

    var dontSort = [];
    var hidden = [];
    var order = [];
    var sumIndex = -1;
    var sumType = 'count';
    $('.datatable thead th').each(function(index, elem) {
        // for sum up
        if ($(this).hasClass('sum_up')) {
            sumIndex = index;
            if ($(this).hasClass('rmb')) {
                sumType = 'rmb';
            }
        }
        // for no sort
        if ($(this).hasClass('no_sort')) {
            dontSort.push({
                "bSortable": false
            });
        } else {
            dontSort.push(null);
        }

        if ($(this).hasClass('hidden')) {
            hidden.push({
                "targets": [index],
                "visible": false
            });
        }

        if ($(this).hasClass('asc')) {
            var count = $(this).prevAll('th').size();
            order.push([count, "asc"]);
        }

        if ($(this).hasClass('desc')) {
            var count = $(this).prevAll('th').size();
            order.push([count, "desc"]);
        }
        // "order": [[ 3, "desc" ]]
    });
    if (!$.fn.dataTable.isDataTable('.datatable')) {

        $('.datatable').DataTable({
            buttons: [{
                extend: 'excel',
                text: 'Excel',
                exportOptions: {
                    modifier: {
                        selected: true
                    }
                }
            }, 'print'],
            "sDom": '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"<"inline-block mr-20"B><"inline-block"f>><"clearfix">>>t<"row"<"col-sm-12 text-center"<"total-footer">>><"row view-pager"<"col-sm-12"<"pagination-wrapper"p>>>',
            "aoColumns": dontSort,
            "autoWidth": false,
            "aaSorting": [],
            "columnDefs": hidden,
            order: order,
            language: {
                "sProcessing": "处理中...",
                "sLengthMenu": "显示 _MENU_ 项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix": "",
                "sSearch": "搜索:",
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上页",
                    "sNext": "下页",
                    "sLast": "末页"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            },
            "footerCallback": function(row, data, start, end, display) {
                if (sumIndex >= 0) {
                    var api = this.api();

                    // Remove the formatting to get integer data for summation
                    var intVal = function(i) {
                        return typeof i === 'string' ?
                            i.replace(/[￥ ]/g, '') * 1 :
                            typeof i === 'number' ?
                            i : 0;
                    };

                    // Total over all pages
                    total = api
                        .column(sumIndex)
                        .data()
                        .reduce(function(a, b) {
                            return intVal(a) + intVal(b);
                        });

                    // Total over this page
                    pageTotal = api
                        .column(sumIndex, {
                            page: 'current'
                        })
                        .data()
                        .reduce(function(a, b) {
                            return intVal(a) + intVal(b);
                        }, 0);
                    var totalStr = '';
                    if (sumType == 'rmb') {
                        pageTotal = parseInt(pageTotal * 100) / 100.0;
                        total = parseInt(total * 100) / 100.0;
                        totalStr = '本页小计: ￥' + pageTotal + ' / 总计: ￥' + total;
                    } else {
                        pageTotal = parseInt(pageTotal * 10) / 10.0;
                        total = parseInt(total * 10) / 10.0;
                        totalStr = '本页小计: ' + pageTotal + ' / 总计: ' + total;

                    }

                    $('.total-footer').html(totalStr);
                    // Update footer
                    // $( api.column( sumIndex ).footer() ).html(totalStr);
                }
            }
        });
    }
    // qiniu upload picture
    // powerd by 🍌
    sn = $('#summernote').summernote({
        height: 400,
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'italic', 'underline', 'clear']],
            ['fontsize', ['fontsize']],
            ['fontname', ['fontname']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['height', ['height']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'hr', 'video']],
            ['view', ['fullscreen', 'codeview']],
            ['help', ['help']],
        ],
        onImageUpload: function(files) {
            sendFile(files[0], $(this));
        },
        onChange: function() {
            var html = $('#summernote').code();
            console.log(html);
        }
    });

    var config = {
            height: 400,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline', 'clear']],
                ['fontsize', ['fontsize']],
                ['fontname', ['fontname']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['table', ['table']],
                ['insert', ['link', 'hr']],
                ['view', ['fullscreen', 'codeview']],
                ['help', ['help']],
            ]
        }
        // $('#weekly_sumary').summernote(config);
        // $('#weekly_hope').summernote(config);
}

function sendFile(file, editor) {

    var filename = false;
    try {
        filename = file['name'];
    } catch (e) {
        filename = false;
    }
    if (!filename) {
        $(".note-alarm").remove();
    }
    //以上防止在图片在编辑器内拖拽引发第二次上传导致的提示错误
    var ext = filename.substr(filename.lastIndexOf("."));
    ext = ext.toUpperCase();
    var timestamp = new Date().getTime();
    var name = timestamp + ext;
    //name是文件名，自己随意定义，aid是我自己增加的属性用于区分文件用户
    data = new FormData();
    data.append("file", file);
    data.append("key", name);
    data.append("token", $("#summernote").attr('token'));
    $.ajax({
        data: data,
        type: "POST",
        url: "http://upload.qiniu.com",
        cache: false,
        contentType: false,
        processData: false,
        success: function(data) {
            var url = $("#summernote").attr('urlhead') + data['key'];
            editor.summernote('insertImage', url);
        },
        error: function() {
            sweetAlert("Oops", "图片上传失败，请重新上传");
        }
    });



}


function initQiniu() {
    if ($('#pickfiles').length > 0) {
        var url = $('#pickfiles').data('url');
        var token = $('#pickfiles').data('token');
        console.log("token = " + token);
        var uploader = Qiniu.uploader({
            runtimes: 'html5,flash,html4', // 上传模式,依次退化
            browse_button: 'pickfiles', // 上传选择的点选按钮，**必需**
            // 在初始化时，uptoken, uptoken_url, uptoken_func 三个参数中必须有一个被设置
            // 切如果提供了多个，其优先级为 uptoken > uptoken_url > uptoken_func
            // 其中 uptoken 是直接提供上传凭证，uptoken_url 是提供了获取上传凭证的地址，如果需要定制获取 uptoken 的过程则可以设置 uptoken_func
            uptoken: token, // uptoken 是上传凭证，由其他程序生成
            // uptoken_url: '/uptoken',         // Ajax 请求 uptoken 的 Url，**强烈建议设置**（服务端提供）
            // uptoken_func: function(file){    // 在需要获取 uptoken 时，该方法会被调用
            //    // do something
            //    return uptoken;
            // },
            get_new_uptoken: false, // 设置上传文件的时候是否每次都重新获取新的 uptoken
            // downtoken_url: '/downtoken',
            // Ajax请求downToken的Url，私有空间时使用,JS-SDK 将向该地址POST文件的key和domain,服务端返回的JSON必须包含`url`字段，`url`值为该文件的下载地址
            // unique_names: true, // 默认 false，key 为文件名。若开启该选项，JS-SDK 会为每个文件自动生成key（文件名）
            save_key: true, // 默认 false。若在服务端生成 uptoken 的上传策略中指定了 `sava_key`，则开启，SDK在前端将不对key进行任何处理
            domain: url, // bucket 域名，下载资源时用到，**必需**
            // container: 'container', // 上传区域 DOM ID，默认是 browser_button 的父元素，
            max_file_size: '100mb', // 最大文件体积限制
            flash_swf_url: '//cdn.bootcss.com/plupload/2.1.1/Moxie.swf', //引入 flash,相对路径
            max_retries: 3, // 上传失败最大重试次数
            // dragdrop: true, // 开启可拖曳上传
            drop_element: 'container', // 拖曳上传区域元素的 ID，拖曳文件或文件夹后可触发上传
            chunk_size: '4mb', // 分块上传时，每块的体积
            auto_start: true, // 选择文件后自动上传，若关闭需要自己绑定事件触发上传,
            //x_vars : {
            //    自定义变量，参考http://developer.qiniu.com/docs/v6/api/overview/up/response/vars.html
            //    'time' : function(up,file) {
            //        var time = (new Date()).getTime();
            // do something with 'time'
            //        return time;
            //    },
            //    'size' : function(up,file) {
            //        var size = file.size;
            // do something with 'size'
            //        return size;
            //    }
            //},
            init: {
                'FilesAdded': function(up, files) {
                    plupload.each(files, function(file) {
                        // 文件添加进队列后,处理相关的事情
                    });
                },
                'BeforeUpload': function(up, file) {
                    // 每个文件上传前,处理相关的事情
                    console.log('before upload');
                },
                'UploadProgress': function(up, file) {
                    // 每个文件上传时,处理相关的事情
                    console.log('uploading');
                },
                'FileUploaded': function(up, file, info) {
                    // 每个文件上传成功后,处理相关的事情
                    // 其中 info 是文件上传成功后，服务端返回的json，形式如
                    // {
                    //    "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
                    //    "key": "gogopher.jpg"
                    //  }
                    // 参考http://developer.qiniu.com/docs/v6/api/overview/up/response/simple-response.html

                    var domain = up.getOption('domain');
                    var res = JSON.parse(info);
                    console.log(res);
                    var sourceLink = domain + res.key;
                    console.log('uploaded: ' + sourceLink);
                    var textArea = $('.markdown-src')[0];
                    var imgElem = '![alt text](' + sourceLink + ')';

                    insertAtCursor(textArea, imgElem);
                    $('.markdown-src').keyup();
                },
                'Error': function(up, err, errTip) {
                    //上传出错时,处理相关的事情
                    console.log('error:' + errTip);
                },
                'UploadComplete': function() {
                    //队列文件处理完毕后,处理相关的事情
                },
                'Key': function(up, file) {
                    // 若想在前端对每个文件的key进行个性化处理，可以配置该函数
                    // 该配置必须要在 unique_names: false , save_key: false 时才生效

                    var key = "";
                    // do something with key here
                    return key
                }
            }
        });
    }
}

function insertAtCursor(myField, myValue) {
    //IE support
    if (document.selection) {
        myField.focus();
        sel = document.selection.createRange();
        sel.text = myValue;
    }
    //MOZILLA and others
    else if (myField.selectionStart || myField.selectionStart == '0') {
        var startPos = myField.selectionStart;
        var endPos = myField.selectionEnd;
        myField.value = myField.value.substring(0, startPos) + myValue + myField.value.substring(endPos, myField.value.length);
    } else {
        myField.value += myValue;
    }
}
