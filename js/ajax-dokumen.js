var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){
        var $no_order = jQuery( '.no_order' );
        $('#dok1').dropify();
        $('#dok2').dropify();
        var $table3 = jQuery("#tabledokumen");
            var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            buttons: [],
            processing: true,
            serverSide: true,
            ajax: 'dokumen/getdata',
            columns: [
                { data: 'nomor', name: 'nomor' },
                { data: 'no_order', name: 'no_order' },
                { data: 'tahun', name: 'tahun' },
                { data: 'dok1', name: 'dok1' },
                { data: 'dok2', name: 'dok2' },
                { data: 'action', name: 'action'}
            ]
        });

        $( '#tabledokumen tfoot th' ).each( function () {
                if( $(this).text() != "Dokumen 1" ){
                    if( $(this).text() != "Dokumen 2" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                var title = $('#tabledokumen thead th').eq( $(this).index() ).text();
                $(this).html( '<input type="text" class="form-control" placeholder="Cari ' + title + '" />' );
                }}}}

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

        var dTable = jQuery('#tabledokumen').DataTable(); 
        var url = "dokumens";

        //display modal form for task editing
        $(document).on("click", ".open-modal", function () {
            var id = $(this).val();

            $.get(url + '/' + id, function (data) {
                //success data
                $('#id').val(data.id);
                $no_order.select2("data", {id: data.id_order, text: data.no_order});
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
                text: "Hapus Dokumen?",
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

                var your_form = $("#frmbukti")[0];
                var formData = new FormData(your_form);

                //used to determine the http verb to use [add=POST], [update=PUT]
                var state = $('#btn-save').val();

                var type = "POST"; //for creating new resource
                var id = $('#id').val();;
                var my_url = url;

                if (state == "update"){
                    var pesan ="Data telah diupdate";
                    type = "POST"; //for updating existing resource
                    my_url = 'dokumenz/' + id;
                }else{
                    var pesan ="Data telah disimpan";
                }

                $('#btn-save').attr("disabled", "disabled");
                // console.log(formData);
                $.ajax({
                    type: type,
                    url: my_url,
                    data: formData,
                    contentType: false,
                    processData:false,
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

        $(document).on("click", ".btn-edit", function () {
            var id = $(this).val();
            $.get('dokumens/' + id, function (data) {
                $('#id').val(data.id);
                $no_order.select2("data", {id: data.id_order, text: data.no_order});
                var drEvent1 = $('#dok1').dropify();
                drEvent1 = drEvent1.data('dropify');
                drEvent1.resetPreview();
                drEvent1.clearElement();
                drEvent1.settings.defaultFile = "uploads/"+data.dok1;
                drEvent1.destroy();
                drEvent1.init();

                var drEvent2 = $('#dok2').dropify();
                drEvent2 = drEvent2.data('dropify');
                drEvent2.resetPreview();
                drEvent2.clearElement();
                drEvent2.settings.defaultFile = "uploads/"+data.dok2;
                drEvent2.destroy();
                drEvent2.init();
                $('#btn-save').val("update");
                $("#myModal").modal("show");
            });
        });

    });

})(jQuery, window);
