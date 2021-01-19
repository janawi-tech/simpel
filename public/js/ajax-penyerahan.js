
function get_detail_order(petugas_lab){
    var no_order=$("#no_order").val();
    var petugas_lab=petugas_lab;
        $("#tableorder").show();
        jQuery("#tableorder").DataTable().destroy();
        var $tableorder = jQuery("#tableorder");
            var tableorder = $tableorder.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            "dom": '<"panel"<"panel-heading"<"row"<"col-md-6"l><"col-md-6 text-right"f>>>t<"panel-footer"<"row"<"col-md-6"i><"col-md-6 text-right"p>>>>'+'B',
            buttons: [],
            processing: true,
            serverSide: true,
            ajax: "penyerahan/getorder/"+no_order+"/"+petugas_lab,
            columns: [
                { data: 'id', name: 'id' },
                { data: 'alat', name: 'alat' },
                { data: 'seri', name: 'seri' },
                { data: 'catatan', name: 'catatan' }
            ]
        });

        $( '#tableorder tfoot th' ).each( function () {
                if( $(this).text() != "#" ){
                if( $(this).text() != "No" ){
                var title = $('#tableorder thead th').eq( $(this).index() ).text();
                $(this).html( '<input type="text" class="form-control" placeholder="Cari ' + title + '" />' );
                }}

                } );
                // Apply the search
        tableorder.columns().every( function () {
            var that = this;
            $( 'input', this.footer() ).on( 'keyup change', function () {
                if ( that.search() !== this.value ) {
                    that.search( this.value ).draw();
                }
            });
        } );
}

var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){
        // $('.catatan').editable();
        $("#tableorder").hide();
        var $no_order = jQuery( '.no_order' );
        var $petugas_lab = jQuery( '.petugas_lab' );
        var $petugas_yantek = jQuery( '.petugas_yantek' );
        var $table3 = jQuery("#tablepenyerahan");
            var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            "dom": '<"panel"<"panel-heading"<"row"<"col-md-6"l><"col-md-6 text-right"f>>>t<"panel-footer"<"row"<"col-md-6"i><"col-md-6 text-right"p>>>>'+'B',
            buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
            processing: true,
            serverSide: true,
            ajax: 'penyerahan/getdata',
            columns: [
                { data: 'rownum', name: 'rownum',orderable: false,searchable:false },
                { data: 'tgl_serah', name: 'tgl_serah' },
                { data: 'no_order', name: 'no_order' },
                { data: 'petugas_lab', name: 'petugas_lab' },
                { data: 'petugas_yantek', name: 'petugas_yantek' },
                { data: 'action', name: 'action'}
            ]
        });

        $( '#tablepenyerahan tfoot th' ).each( function () {
                if( $(this).text() != "-" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                var title = $('#tablepenyerahan thead th').eq( $(this).index() ).text();
                $(this).html( '<input type="text" class="form-control" placeholder="Cari ' + title + '" />' );
                }}}

                } );
                // Apply the search
        table3.columns().every( function () {
            var that = this;
            $( 'input', this.footer() ).on( 'keyup change', function () {
                if ( that.search() !== this.value ) {
                    that.search( this.value ).draw();
                }
            });
        } );

        $no_order.select2({
        placeholder: 'Pilih Nomor Order',
            ajax: {
                url: 'penyerahan/order',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.no_order,
                                id: item.no_order
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $petugas_lab.select2({
        placeholder: 'Petugas Lab',
            ajax: {
                url: 'penyerahan/lab',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term,
                      n: $('#no_order').val()
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.nama,
                                id: item.petugas_id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $petugas_yantek.select2({
        placeholder: 'Petugas Yantek',
            ajax: {
                url: 'penyerahan/yantek',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.name,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        var dTable = jQuery('#tablepenyerahan').DataTable(); 
        var url = "penyerahans";

        //display modal form for task editing
        $(document).on("click", ".open-modal", function () {
            var id = $(this).val();

            $.get(url + '/' + id, function (data) {
                //success data
                $('#id').val(data.id);
                $('#tgl_serah').val(data.tgl_serah);
                $petugas_lab.select2("data", {id: data.petugas_lab, text: data.lab});
                $petugas_yantek.select2("data", {id: data.petugas_yantek, text: data.yantek});
                $no_order.select2("data", {id: data.no_order, text: data.no_order});
                $('#no_order').val(data.no_order);

                $("#tableorder").show();
                jQuery("#tableorder").DataTable().destroy();
                var $tableorder = jQuery("#tableorder");
                    var tableorder = $tableorder.DataTable( {
                    "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
                    "dom": '<"panel"<"panel-heading"<"row"<"col-md-6"l><"col-md-6 text-right"f>>>t<"panel-footer"<"row"<"col-md-6"i><"col-md-6 text-right"p>>>>'+'B',
                    buttons: [],
                    processing: true,
                    serverSide: true,
                    ajax: "penyerahan/getorder/"+data.no_order+"/"+data.petugas_lab,
                    columns: [
                        { data: 'id', name: 'id' },
                        { data: 'alat', name: 'alat' },
                        { data: 'seri', name: 'seri' },
                        { data: 'catatan', name: 'catatan' }
                    ]
                });

                $( '#tableorder tfoot th' ).each( function () {
                        if( $(this).text() != "#" ){
                        if( $(this).text() != "No" ){
                        var title = $('#tableorder thead th').eq( $(this).index() ).text();
                        $(this).html( '<input type="text" class="form-control" placeholder="Cari ' + title + '" />' );
                        }}

                        } );
                        // Apply the search
                tableorder.columns().every( function () {
                    var that = this;
                    $( 'input', this.footer() ).on( 'keyup change', function () {
                        if ( that.search() !== this.value ) {
                            that.search( this.value ).draw();
                        }
                    });
                } );

                $('#btn-save').val("update");
                $('#myModal').modal('show');
            }) 
        });

        //display modal form for creating new task
        $('#btn-add').click(function(){
            $("#tableorder").hide();
            $('#btn-save').val("add");
            $('#frmpenyerahan').trigger("reset");
            $('#myModal').modal('show');
        });

        $(document).on('change','.catatan', function(){
           var catatan = $(this).val();
           var id =$(this).attr("id");
           $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                }
           });
           $.ajax({
                type: "PUT",
                url: "penyerahan/detail",
                data: {id:id,catatan:catatan},
                dataType: 'json',
                success: function (data) {
                    // jQuery("#tableorder").DataTable().ajax.reload(null,false);
                },
                error: function (data) {
                    console.log('Error:', data);
                }
            }); 
        });

        $(document).on('click','.tutup', function(){
            var validator = $("#frmpenyerahan").validate();
            validator.resetForm();
            $no_order.select2("val", "");
            $petugas_yantek.select2("val", "");
            $petugas_lab.select2("val", "");
            $("#tableorder").hide();
            $('#frmpenyerahan').trigger("reset");
        });

        $(document).on("click", ".delete-task", function () {
            swal({
                title: "Konfirmasi",
                text: "Hapus Kuitansi?",
                icon: "warning",
                buttons: ["Batal", "Hapus"],
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    var id = $(this).val();
                    $.ajaxSetup({
                        headers: {'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')}
                    });

                    $.ajax({
                        type: "DELETE",
                        url: url + '/' + id,
                        success: function (data) {
                            dTable.ajax.reload(null,false);
                            swal("Berhasil!","Data telah dihapus","success");
                        },
                        error: function (data) {
                            console.log('Error:', data);
                        }
                    });
                } else {
                  // swal("Your imaginary file is safe!");
                }
            }); 
            
        });

        neonLogin.$container = $("#frmpenyerahan");
        var validator = neonLogin.$container.validate({
            ignore: [],  
            rules: {
                tgl_serah: {
                    required: true,  
                },
                no_order: {
                    required: true,  
                },
                petugas_lab: {
                    required: true,  
                },
                petugas_yantek: {
                    required: true,  
                },
            },
            highlight: function(element){
                $(element).closest('.form-group').addClass('has-danger');
            },
            unhighlight: function(element)
            {
                $(element).closest('.form-group').removeClass('has-danger');
            },
            errorPlacement: function(error, element) {  },
            submitHandler: function(ev)
            {
                $.ajaxSetup({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                    }
                })

                var formData = $('#frmpenyerahan').serialize();

                //used to determine the http verb to use [add=POST], [update=PUT]
                var state = $('#btn-save').val();

                var type = "POST"; //for creating new resource
                var id = $('#id').val();;
                var my_url = url;

                if (state == "update"){
                    var pesan ="Data telah diupdate";
                    type = "PUT"; //for updating existing resource
                    my_url += '/' + id;
                }else{
                    var pesan ="Data telah disimpan";
                }

                $('#btn-save').attr("disabled", "disabled");
                // console.log(formData);
                $.ajax({
                    type: type,
                    url: my_url,
                    data: formData,
                    dataType: 'json',
                    success: function (data) {
                        $("#tgl_serah").val("");
                        $("#no_order").val("");
                        $petugas_lab.select2("val", "");
                        $petugas_yantek.select2("val", "");
                        $no_order.select2("val", "");
                        $('#btn-save').prop('disabled', false);
                        swal("Berhasil!",pesan,"success");
                        $('#myModal').modal('hide');
                        $("#tableorder").hide();
                        dTable.ajax.reload(null,false);
                    },
                    error: function (data) {
                        console.log('Error:', data);
                    }
                });
            }
        });


    });

})(jQuery, window);
