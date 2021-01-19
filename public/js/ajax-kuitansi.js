function get_customer(no_order){
    $.get('kuitansis/customer/'+no_order, function (data) {
        $("#customer_id").val(data.id);
        $("#customer").val(data.pemilik);
    });
}

var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){
        var $no_order = jQuery( '.no_order' );
        var $table3 = jQuery("#tablekuitansi");
        var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
            processing: true,
            serverSide: true,
            ajax: 'kuitansi/getdata',
            columns: [
                { data: 'rownum', name: 'rownum',orderable: false,searchable:false },
                { data: 'no_bukti', name: 'no_bukti' },
                { data: 'no_order', name: 'no_order' },
                { data: 'tgl_bayar', name: 'tgl_bayar' },
                { data: 'customer', name: 'customer' },
                { data: 'dari', name: 'dari' },
                { data: 'total', name: 'total' },
                { data: 'action', name: 'action'}
            ]
        });

        $( '#tablekuitansi tfoot th' ).each( function () {
                if( $(this).text() != "-" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                var title = $('#tablekuitansi thead th').eq( $(this).index() ).text();
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
                url: 'kuitansi/order',
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

        var dTable = jQuery('#tablekuitansi').DataTable(); 
        var url = "kuitansis";

        //display modal form for task editing
        $(document).on("click", ".open-modal", function () {
            var id = $(this).val();

            $.get(url + '/' + id, function (data) {
                //success data
                $('#id').val(data.id);
                $('#no_bukti').val(data.no_bukti);
                $no_order.select2("data", {id: data.no_order, text: data.no_order});
                $('#customer_id').val(data.customer_id);
                $('#customer').val(data.customer);
                $('#tgl_bayar').val(data.tgl_bayar);
                $('#dari').val(data.dari);
                $('#keterangan').val(data.keterangan);
                $('#btn-save').val("update");
                $('#myModal').modal('show');
            }) 
        });

        //display modal form for creating new task
        $('#btn-add').click(function(){
            $('#btn-save').val("add");
            $('#frmkuitansi').trigger("reset");
            $('#myModal').modal('show');
        });

        $(document).on('click','.tutup', function(){
            var validator = $("#frmkuitansi").validate();
            validator.resetForm();
            $no_order.select2("val", "");
            $('#frmkuitansi').trigger("reset");
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

        neonLogin.$container = $("#frmkuitansi");
        var validator = neonLogin.$container.validate({
            ignore: [],  
            rules: {
                no_bukti: {
                    required: true,  
                },
                no_order: {
                    required: true,  
                },
                customer: {
                    required: true,  
                },
                tgl_bayar: {
                    required: true,  
                },
                dari: {
                    required: true,  
                },
                keterangan: {
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

                var formData = $('#frmkuitansi').serialize();

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
                        $('#frmkuitansi').trigger("reset");
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
