var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){
        var $groups = jQuery( '.groups' );
        $(".checkbox-custom").hide();
        var $table3 = jQuery("#tableuser");
        var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            "dom": '<"panel"<"panel-heading"<"row"<"col-md-6"l><"col-md-6 text-right"f>>>t<"panel-footer"<"row"<"col-md-6"i><"col-md-6 text-right"p>>>>'+'B',
            buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
            processing: true,
            serverSide: true,
            ajax: 'pengguna/getdata',
            columns: [
                { data: 'rownum', name: 'rownum',orderable: false,searchable:false },
                { data: 'name', name: 'name' },
                { data: 'nip', name: 'nip' },
                { data: 'email', name: 'email' },
                { data: 'password', name: 'password' },
                { data: 'groups', name: 'groups' },
                { data: 'action', name: 'action'}
            ]
        });

        $( '#tableuser tfoot th' ).each( function () {
                if( $(this).text() != "-" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                    if( $(this).text() != "Password" ){
                var title = $('#tableuser thead th').eq( $(this).index() ).text();
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

        $('#btn-add').click(function(){
            $('#btn-save').val("add");
            $('#frmpengguna').trigger("reset");
            $('#myModal').modal('show');
        });

        $(document).on('click','.tutup', function(){
            var validator = $("#frmpengguna").validate();
            $(".checkbox-custom").hide();
            validator.resetForm();
            $groups.select2("val", "");
            $('#frmpengguna').trigger("reset");
        });

        $groups.select2({
        placeholder: 'Pilih Group Pengguna',
            ajax: {
                url: 'pengguna/getgroups',
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
                                text: item.groups,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        var dTable = jQuery('#tableuser').DataTable(); 
        var url = "penggunas";

        $(document).on("click", ".open-modal", function () {
            var id = $(this).val();

            $.get(url + '/' + id, function (data) {
                //success data
                $(".checkbox-custom").show();
                $('#id').val(data.id);
                $('#name').val(data.name);
                $('#nip').val(data.nip);
                $('#email').val(data.email);
                $('#password').val(data.password);
                $groups.select2("data", {id: data.groups_id, text: data.groups});
                $('#btn-save').val("update");
                $('#myModal').modal('show');
            }) 
        });

        neonLogin.$container = $("#frmpengguna");
        var validator = neonLogin.$container.validate({
            ignore: [],  
            rules: {
                name: {
                    required: true,  
                },
                email: {
                    required: true,  
                },
                password: {
                    required: true,  
                },
                groups: {
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
                $("#pass").prop("checked") ? $("#pass").val("1") : $("#pass").val("0");

                $.ajaxSetup({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                    }
                })

                var formData = $('#frmpengguna').serialize();

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
                        $('#frmpengguna').trigger("reset");
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
        // $.ajax({
        //     type: "GET",
        //     url: "pengguna/getgroups"
        // }).done(function(response) {

        // response.unshift({ id: "0", name: "" });
        // var tableuser = $tableuser.jsGrid({
        //         width: "100%",
        //         filtering: false,
        //         inserting:false,
        //         editing: true,
        //         sorting: false,
        //         paging: true,
        //         autoload: true,
        //         pageSize: 10,
        //         pageButtonCount: 5,
        //         // deleteConfirm: "Do you really want to delete data?",
        //         controller: {
        //             loadData: function(filter){
        //                 return $.ajax({
        //                     type: "GET",
        //                     url: "pengguna/getgrid",
        //                     data: filter
        //                 });
        //             },
        //             updateItem: function(item){
        //                 $.ajaxSetup({
        //                     headers: {
        //                         'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
        //                     }
        //                 });
        //                 return $.ajax({
        //                     type: "PUT",
        //                     dataType: 'json',
        //                     url: "pengguna/update",
        //                     data: item
        //                 });
        //             },
        //         },
        //         fields: [
        //             {name: "id",type: "hidden",width: 15},
        //             {name: "name", type: "text"},
        //             {name: "email", type: "text"},
        //             {name: "password", type: "text", width: 90},
                    // {
                    //         name: "groups_id", 
                    //         title: "Groups", 
                    //         type: "select", 
                    //         width: 100, 
                    //         items: response, 
                    //         valueField: "id", 
                    //         textField: "groups" 
                    // },
                    // {type: "control",deleteButton: false}
            //     ]
            // });
            
        // });
    });

})(jQuery, window);
