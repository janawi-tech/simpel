function reset_alat(id_order){
    var $alat_id = jQuery( '.alat_id' );
    $.get('bukti/getalat' + '/' + id_order, function (data) {
        $alat_id.select2('data',data);
    }) 
}

var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){
        var $no_order = jQuery( '.no_order' );
        var $penyerah = jQuery( '.penyerah' );
        var $alat_id = jQuery( '.alat_id' );

        var $table3 = jQuery("#tablebukti");
            var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            buttons: [],
            processing: true,
            serverSide: true,
            ajax: 'bukti/getdata',
            columns: [
                { data: 'nomor', name: 'nomor',orderable: false,searchable:false },
                { data: 'no_order', name: 'no_order' },
                { data: 'tgl_serah', name: 'tgl_serah' },
                { data: 'pelanggan', name: 'pelanggan' },
                { data: 'penyerah', name: 'penyerah' },
                { data: 'penerima', name: 'penerima' },
                { data: 'tahun', name: 'tahun' },
                { data: 'action', name: 'action'}
            ]
        });

        $( '#tablebukti tfoot th' ).each( function () {
                if( $(this).text() != "-" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                var title = $('#tablebukti thead th').eq( $(this).index() ).text();
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
                url: 'spk/order',
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
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $penyerah.select2({
        placeholder: 'Yang Menyerahkan',
            ajax: {
                url: 'bukti/penyerah',
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

        $alat_id.select2({
        multiple: true,
        placeholder: 'Pilih Alat',
            ajax: {
                url: 'bukti/alat',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term, //search term
                      n: $('#no_order').val()
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.text,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        var dTable = jQuery('#tablebukti').DataTable(); 
        var url = "buktis";

        //display modal form for task editing
        $(document).on("click", ".open-modal", function () {
            var id = $(this).val();

            $.get(url + '/' + id, function (data) {
                //success data
                $('#id').val(data.id);
                $no_order.select2("data", {id: data.id_order, text: data.no_order});
                $penyerah.select2("data", {id: data.id_penyerah, text: data.penyerah});
                if (data.p1==1) {
                    $("#p1").attr( 'checked', 'checked' );
                }else{
                    $("#p1").attr( 'checked', false )
                }

                if (data.p2==1) {
                    $("#p2").attr( 'checked', 'checked' );
                }else{
                    $("#p2").attr( 'checked', false )
                }

                if (data.p3==1) {
                    $("#p3").attr( 'checked', 'checked' );
                }else{
                    $("#p3").attr( 'checked', false )
                }

                if (data.p4==1) {
                    $("#p4").attr( 'checked', 'checked' );
                }else{
                    $("#p4").attr( 'checked', false )
                }
                $('#tgl_serah').val(data.tgl_serah);
                $('#penerima').val(data.penerima);
                $('#btn-save').val("update");
                $('#myModal').modal('show');
            }) 
        });

        //display modal form for creating new task
        $('#btn-add').click(function(){
            $('#btn-save').val("add");
            $('#frmbukti').trigger("reset");
            $('#myModal').modal('show');
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

        neonLogin.$container = $("#frmbukti");
        var validator = neonLogin.$container.validate({
            ignore: [],  
            rules: {
                no_order: {
                    required: true,  
                },
                tgl_serah: {
                    required: true,  
                },
                penyerah: {
                    required: true,  
                },
                penerima: {
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
                $("#p1").prop("checked") ? $("#p1").val("1") : $("#p1").val("0");
                $("#p2").prop("checked") ? $("#p2").val("1") : $("#p2").val("0");
                $("#p3").prop("checked") ? $("#p3").val("1") : $("#p3").val("0");
                $("#p4").prop("checked") ? $("#p4").val("1") : $("#p4").val("0");

                $.ajaxSetup({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                    }
                })

                var formData = $('#frmbukti').serialize();

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
                        $('#frmbukti').trigger("reset");
                        $('#btn-save').prop('disabled', false);
                        swal("Berhasil!",pesan,"success");
                        $('#myModal').modal('hide');
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
