function reset_alat(id_order){
    var $alat_id = jQuery( '.alat_id' );
    $.get('spk/getalat' + '/' + id_order, function (data) {
        $alat_id.select2('data',data);
    }) 
}


var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){
        var $petugas_id = jQuery( '.petugas_id' );
        var $no_order = jQuery( '.no_order' );
        var $alat_id = jQuery( '.alat_id' );
        var $tempat = jQuery( '.tempat' );
        var $ka_instalasi = jQuery( '.ka_instalasi' );

        var $table3 = jQuery("#tablespk");
            var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            buttons: [],
            processing: true,
            serverSide: true,
            ajax: 'spk/getdata',
            columns: [
                { data: 'nomor', name: 'nomor',orderable: false,searchable:false },
                { data: 'no_order', name: 'no_order' },
                { data: 'petugas', name: 'petugas' },
                { data: 'kainstalasi', name: 'kainstalasi' },
                { data: 'tahun', name: 'tahun' },
                { data: 'action', name: 'action'}
            ]
        });

        $( '#tablespk tfoot th' ).each( function () {
                if( $(this).text() != "-" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                var title = $('#tablespk thead th').eq( $(this).index() ).text();
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
        //display modal form for task editing
        var dTable = jQuery('#tablespk').DataTable(); 
        var url = "spks";

        $petugas_id.select2({
        placeholder: 'Pilih Petugas',
            ajax: {
                url: 'penerimaan/pemeriksa',
                // dataType: 'json',
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

        $ka_instalasi.select2({
        placeholder: 'Kepala Instalasi',
            ajax: {
                url: 'spk/ka_instalasi',
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
                                text: item.nama,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $tempat.select2({
        placeholder: 'Pilih Tempat',
            ajax: {
                url: 'spk/gettempat',
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
                                text: item.laboratorium,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

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


        $alat_id.select2({
        multiple: true,
        placeholder: 'Pilih Alat',
            ajax: {
                url: 'spk/alat',
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

        neonLogin.$container = $("#frmspk");
        var validator = neonLogin.$container.validate({
            ignore: [],  
            rules: {
                petugas_id: {
                    required: true,  
                },
                unit_kerja: {
                    required: true,  
                },
                no_order: {
                    required: true,  
                },
                alat_id: {
                    required: true,  
                },
                tempat: {
                    required: true,  
                },
                ka_instalasi: {
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

                var formData = $('#frmspk').serialize();

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
                $.ajax({
                    type: type,
                    url: my_url,
                    data: formData,
                    dataType: 'json',
                    success: function (data) {
                        var validator = $("#frmspk").validate();
                        validator.resetForm();
                        $petugas_id.select2("val", "");
                        $alat_id.select2("val", "");
                        $tempat.select2("val", "");
                        $ka_instalasi.select2("val", "");
                        $no_order.select2("val", "");
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

        $(document).on("click", ".open-modal", function () {
            var id = $(this).val();

            $.get(url + '/' + id, function (data) {
                $('#id').val(data.id);
                $no_order.select2("data", {id: data.no_order, text: data.no_order});
                $petugas_id.select2("data", {id: data.petugas_id, text: data.petugas});
                $tempat.select2("data", {id: data.tempat, text: data.tmpt});
                $ka_instalasi.select2("data", {id: data.ka_instalasi, text: data.kainstalasi});
                $alat_id.select2('data', data.alat_id);
                $('#unit_kerja').val(data.unit_kerja);
                $('#tgl_spk').val(data.tgl_spk);
                $('#catatan').val(data.catatan);
                $('#btn-save').val("update");
                $('#myModal').modal('show');
            }) 
        });

        //display modal form for creating new task
        $('#btn-add').click(function(){
            $('#btn-save').val("add");
            $('#frmspk').trigger("reset");
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

        $(document).on('click','.tutup', function(){
            var validator = $("#frmspk").validate();
            validator.resetForm();
            $petugas_id.select2("val", "");
            $alat_id.select2("val", "");
            $tempat.select2("val", "");
            $ka_instalasi.select2("val", "");
            $no_order.select2("val", "");
            $('#frmspk').trigger("reset");
        });

    });

})(jQuery, window);
